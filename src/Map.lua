--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

Map = Class{}

function Map:init(def)
    self.w = def['width'] or math.floor(VIRTUAL_WIDTH / MAP_TILE_SIZE)
    self.h = def['height'] or math.floor(VIRTUAL_HEIGHT / MAP_TILE_SIZE)
    
    self.WALL_VAL = def['wall_val'] or 1
    self.EMPTY_VAL = def['empty_val'] or 0

    self.matrix = self:initMatrix()

    self.timer = 0

end

function Map:initMatrix()
    local matrix = {}
    for y = 1, self.h do
        matrix[y] = {}
        for x = 1, self.w do
            if x == 1 or x == self.w or y == 1 or y == self.h then
                matrix[y][x] = self.WALL_VAL
            else
                matrix[y][x] = self.EMPTY_VAL
            end
        end
    end
    return matrix
end

function Map:walkMatrix()
    for y =2, self.h - 2 do
        for x =2, self.w - 2 do
            if self.matrix[y][x] == self.EMPTY_VAL and 
                    self.matrix[y + 1][x] == self.EMPTY_VAL and
                    self.matrix[y][x + 1] == self.EMPTY_VAL and
                    self.matrix[y + 1][x + 1] == self.EMPTY_VAL then
                local rand = math.random(1, 4) - 1
                self.matrix[y + rand % 2][x + rand /2] = self.WALL_VAL
            end
        end
    end
    for y =1, self.h - 1 do
        for x =1, self.w - 1 do
            if self.matrix[y][x] == self.EMPTY_VAL and 
                    self.matrix[y + 1][x] == self.WALL_VAL and
                    self.matrix[y - 1][x] == self.WALL_VAL and
                    self.matrix[y][x - 1] == self.WALL_VAL and
                    self.matrix[y][x + 1] == self.WALL_VAL then
                self.matrix[y][x] = self.WALL_VAL
            end
        end
    end
end

function Map:update(dt)
    self.timer = self.timer + dt
    if self.timer > 1 then 
        self:walkMatrix()
        self.timer = 0
    end
end

-- seletc appropriate tile based on the neighbours 
-- assuming the given tile is a wall as well
function Map:select_tile(y, x)
    -- compose the name of the key
    local idx_name = 'TILE_IDX_'
    if y > 1 and (self.matrix[y - 1][x] == self.WALL_VAL) then
        idx_name = idx_name .. 'U'
    end
    if x < self.w and self.matrix[y][x + 1] == self.WALL_VAL then
        idx_name = idx_name .. 'R'
    end
    if y < self.h and self.matrix[y + 1][x] == self.WALL_VAL then
        idx_name = idx_name .. 'D'
    end
    if x > 1 and self.matrix[y][x - 1] == self.WALL_VAL then
        idx_name = idx_name .. 'L'
    end
    return gFrames['tiles'][TILE_IDX[idx_name]] or gFrames['tiles'][16]
end

function Map:render()
    for y =1, self.h do
        for x=1, self.w do
            if self.matrix[y][x] == self.WALL_VAL then
                quad =  self:select_tile(y, x)
                padding = 0
            else 
                quad = gFrames['dot']
                padding = 0
            end
            love.graphics.draw(gTextures[BASE_TEXTURE],
            quad,
            (x - 1) * MAP_TILE_SIZE + padding, (y - 1) * MAP_TILE_SIZE + padding)
        end
    end
end