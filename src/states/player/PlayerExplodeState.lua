--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

PlayerExplodeState = Class{__includes=BaseState}

function PlayerExplodeState:init(entity, map)
    self.entity = entity
    self.map = map

    self.timer = 0
    self.entity:setAnimation('explode')
end

function PlayerExplodeState:update(dt)
    self.timer = self.timer + dt
    if self.timer > 3 then
        self.timer = 0
        self.entity:changeState('idle')
        self.entity:setAnimation('go-right')
    end
    self.entity.currentAnimation:update(dt)
end

function PlayerExplodeState:render(dt)
end