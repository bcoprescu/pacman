--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

DEFAULT_SPEED = 25

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    if love.keyboard.wasPressed('up') then
        self.vX = 0
        self.vY = -DEFAULT_SPEED
        self.setAnimation(self, 'go-up')
    else if love.keyboard.wasPressed('down') then
        self.vX = 0
        self.vY = DEFAULT_SPEED
        self:setAnimation('go-down')
    else if love.keyboard.wasPressed('left') then
        self.vX = -DEFAULT_SPEED
        self.vY = 0
        self:setAnimation('go-left')
    else if love.keyboard.wasPressed('right') then
        self.vX = DEFAULT_SPEED
        self.vY = 0
        self:setAnimation('go-right')
    end end end end

    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end