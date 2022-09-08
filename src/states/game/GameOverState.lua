--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:enter(params)
    self.score = params.score
    self.victory = params.victory
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function GameOverState:render()
    local message = "Game Over"
    if self.victory then
        message = "Victory!!!"
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(255/255, 255/255, 1/255, 1)
    love.graphics.printf(message, 2, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Score: " .. tostring(self.score), 2,
        VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.printf('Press Enter to Play', 2,
        VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end