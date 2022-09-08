--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

Entity = Class{}

function Entity:init(def)

    self.animations = self:createAnimations(def['animations'])
    self.currentAnimation = Animation(self.animations[def.defaultAnimation])
    
    self.w = def.width or PLAYER_WIDTH
    self.h = def.height or PLAYER_HEIGHT

    self.x = def.x or VIRTUAL_WIDTH /2 - self.w /2
    self.y = def.y or VIRTUAL_HEIGHT /2 - self.h/2

    self.vX = def.vX or 0
    self.vY = def.vY or 0
end

function Entity:createAnimations(anim)

    local animationsReturned = {}

    for k, animationDef in pairs(anim) do
        animationsReturned[k] = Animation {
            quads = animationDef.quads or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end
    return animationsReturned
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:setAnimation(name)
    self.currentAnimation = self.animations[name]
    self.currentAnimation.currentFrameIndex = 0
end 

function Entity:update(dt)
    self.stateMachine:update(dt)
    self.currentAnimation:update(dt)
end

function Entity:render(pos)
    self.stateMachine:render(pos)
    love.graphics.draw(self.currentAnimation:getTexture(),
        self.currentAnimation:getFrame(),
        pos.x + self.x, pos.y + self.y)
end

function Entity:checkColision(pos, map, walls)
    local x = pos.x
    local y = pos.y
    local x_case = math.floor(x / map.tile_w) + 1
    local y_case = math.floor(y / map.tile_h) + 1

    local x_end_case = math.floor( (x + self.w)  / map.tile_w)
    if x >  math.floor(x / map.tile_w) * map.tile_w then
        x_end_case = x_end_case + 1
    end
    local y_end_case = math.floor( (y + self.h) / map.tile_h)
    if y >  math.floor(y / map.tile_h) * map.tile_h then
        y_end_case = y_end_case  + 1
    end

    for yy = y_case, y_end_case do 
        for xx = x_case, x_end_case do
            if walls[map.matrix[yy][xx]] then
                return false
            end
        end
    end
    return true
end

function Entity:calculateUpdatePosition(dt, vx, vy)
    local y = self.y + vy * dt
    local x = self.x + vx * dt

    -- if close to the edge then reposition 
    if math.abs(x - math.floor(x+0.5)) < 0.6 * math.abs(vx * dt) then
        x = math.floor(x+0.5)
    end
    if math.abs(y - math.floor(y+0.5)) < 0.6 * math.abs(vy * dt) then
        y = math.floor(y+0.5)
    end

    return {x=x, y=y}
end


function Entity:updatePlayerPos(pos, map)
     
    -- let it slide through the edge and come out on the oder side
    -- add some offset to stop it from going out of the board 
    if pos.x < - self.w + map.tile_w then
        pos.x = map.width - map.tile_w
    end 
    if pos.x > map.width - map.tile_w then 
        pos.x = - self.w + map.tile_w
    end
    if pos.y < -self.h + map.tile_h then
        pos.y = map.height - map.tile_h
    end 
    if pos.y > map.height + map.tile_h then 
        pos.y = - self.h - map.tile_h
    end
    
    self.x = pos.x
    self.y = pos.y

end
