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

function Entity:setAnimation(name)
    self.currentAnimation = self.animations[name]
end 

function Entity:update(dt)
    if (self.vX > 0 and self.x + self.vX *dt + self.w < VIRTUAL_WIDTH) or 
            (self.vX < 0 and self.x + self.vX *dt > 0) or 
            (self.vY > 0 and self.y + self.vY *dt + self.h < VIRTUAL_HEIGHT) or
            (self.vY < 0 and self.y + self.vY *dt > 0) then
        self.x = self.x + self.vX *dt
        self.y = self.y + self.vY *dt
    end
    self.currentAnimation:update(dt)
end

function Entity:render()
    love.graphics.draw(self.currentAnimation:getTexture(),
        self.currentAnimation:getFrame(),
        self.x, self.y)
end