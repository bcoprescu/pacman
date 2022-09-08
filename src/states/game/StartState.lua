--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

StartState = Class{__includes = BaseState}


function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.draw(gTextures['base'], gFrames['background'][1], 
        0, 0)
    love.graphics.draw(gTextures['base'], gFrames['banner'][1], 
        -5, VIRTUAL_HEIGHT / 2 - 60)


    love.graphics.setColor(255/255, 255/255, 1/255, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('By BC', 2, VIRTUAL_HEIGHT / 2 - 5, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.printf('Press Enter', 2, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH, 'center')
end