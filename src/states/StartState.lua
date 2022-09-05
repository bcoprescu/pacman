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
        VIRTUAL_WIDTH / 168,
        VIRTUAL_HEIGHT / 220)
    
        love.graphics.setFont(gFonts['large'])
        love.graphics.setColor(255/255, 255/255, 1/255, 1)
        love.graphics.printf('Pacman', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setFont(gFonts['small'])
        love.graphics.printf('By BC', 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end