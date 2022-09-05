--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.player = Player(ENTITY_DEFS['player'])
    self.map = Map({})
end

function PlayState:update(dt)
    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
    self.map:update(dt)
end


function PlayState:render()
    self.map:render()
    self.player:render()
end