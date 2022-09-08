--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

Map = Class{}

function Map:init(def)
    self.w = def['width'] or math.floor(VIRTUAL_WIDTH / MAP_TILE_SIZE)
    self.h = def['height'] or math.floor(VIRTUAL_HEIGHT / MAP_TILE_SIZE)
    
    -- self.WALL_VAL = def['wall_val'] or 1
    -- self.EMPTY_VAL = def['empty_val'] or 0

    self.tile_w = def['tile_w']
    self.tile_h = def['tile_h']

    self.spritesheet = def.spritesheet

    self.tiles = self:init_tiles(def)

    self.matrix = self:initMatrix(def)

    self.timer = 0

    self.width = self.tile_w * self.w
    self.height = self.tile_h * self.h

    self.player_start = def.player_start or {x=self.tile_w, y=self.tile_h}
    self.monster_pos = def.monster_start or {x=self.width - self.tile_w, self.height - self.tile_h}

end

-- def should containt folowing info
-- ['tiles'] = {
--     [1] = {
--         name = 'wall'
--         type = 'spread'
--         ['frames'] = {quad1, quad2, .., quad16},
--     },
--     ....
-- }
-- Index of the tile will represent the tile code value in the matrix. Value 1 in the matrix means a wall on the map at index x, y
-- Type 'spread' is for tiles that connect to each other (patterns, walls etc). This type should define spreads for all cases
--  (exp corner, edge etc.), 16 in total 
function Map:init_tiles(def) 
    assert(def['tiles'])

    local tiles = {}
    for idx, tile in pairs(def['tiles']) do
        tiles[idx] = {}
        tiles[idx]['val'] = idx
        tiles[idx]['type'] = tile['type']
        tiles[idx]['name'] = tile['name']
        tiles[idx]['frames'] = tile['frames']
    end
    
    return tiles
end

function Map:initMatrix(def)
    local matrix = {}
    assert(#def['matrix'] == def.height)
    for y = 1, self.h do
        assert(#def['matrix'][y] == def.width)
        matrix[y] = {}
        for x = 1, self.w do
            local value = def['matrix'][y][x]
            assert(value <= #self.tiles)
            matrix[y][x] = value
        end
    end
    return matrix
end

function Map:update(dt)
    self.timer = self.timer + dt
    if self.timer > 1 then
        self.timer = 0
    end
end

-- seletc appropriate tile based on the neighbours 
-- assuming the given tile is a wall as well
function Map:select_tile(y, x, tile)
    -- compose the name of the key
    local idx_name = 'TILE_IDX_'
    local value = self.matrix[y][x]
    if y > 1 and (self.matrix[y - 1][x] == value) then
        idx_name = idx_name .. 'U'
    end
    if x < self.w and self.matrix[y][x + 1] == value then
        idx_name = idx_name .. 'R'
    end
    if y < self.h and self.matrix[y + 1][x] == value then
        idx_name = idx_name .. 'D'
    end
    if x > 1 and self.matrix[y][x - 1] == value then
        idx_name = idx_name .. 'L'
    end
    return tile.frames[TILE_IDX[idx_name]] or gFrames['tiles'][16]
end

function Map:render(pos)
    for y =1, self.h do
        for x=1, self.w do
            local value = self.matrix[y][x]
            if value > 0 then
                local tile = self.tiles[value]
                if tile.type == 'spread' then
                    quad =  self:select_tile(y, x, tile)
                else
                    quad = tile.frames[1]
                end
                love.graphics.draw(self.spritesheet,
                quad,
                pos.x + (x - 1) * MAP_TILE_SIZE, pos.y + (y - 1) * MAP_TILE_SIZE)
            end
        end
    end
end