--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

DEFAULT_SPEED = 20

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    self.stateMachine:update(dt)
    Entity.update(self, dt)
end

function Player:render(pos)
    Entity.render(self, pos)
end