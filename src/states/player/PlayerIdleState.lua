--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

PlayerIdleState = Class{__includes=BaseState}

function PlayerIdleState:init(entity, map)
    self.entity = entity
    self.map = map

    self.entity.currentAnimation.currentFrameIndex = 1
end

function PlayerIdleState:update(dt)
    if love.keyboard.wasPressed('up') or 
        love.keyboard.wasPressed('down') or
        love.keyboard.wasPressed('left') or
        love.keyboard.wasPressed('right') then
            self.entity:changeState('move')
    end
end

function PlayerIdleState:render()
end
