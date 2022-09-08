--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

PlayerMoveState = Class{__includes=BaseState}

function PlayerMoveState:init(player, map)
    self.player = player
    self.map = map
    self.direction = 'none'
    self.nextDirection = 'none'

    self.next_vX = 0
    self.next_vY = 0

end

function PlayerMoveState:update(dt)

    if love.keyboard.wasPressed('up') then
        self.nextDirection = 'go-up'
        self.next_vX = 0
        self.next_vY = - DEFAULT_SPEED
    end
    if love.keyboard.wasPressed('down') then
        self.nextDirection = 'go-down'
        self.next_vX = 0
        self.next_vY = DEFAULT_SPEED
    end
    if love.keyboard.wasPressed('left') then
        self.nextDirection = 'go-left'
        self.next_vX = - DEFAULT_SPEED
        self.next_vY = 0
    end
    if love.keyboard.wasPressed('right') then
        self.nextDirection = 'go-right'
        self.next_vX = DEFAULT_SPEED
        self.next_vY = 0
    end

    -- self.player.currentAnimation:update(dt)
    local keep_moving = true
    if not (self.nextDirection == self.direction) then
        local pos = self.player:calculateUpdatePosition(dt, self.next_vX, self.next_vY)
        -- id for wall is 1, 4 is the monster gate
        if self.player:checkColision(pos, self.map, {[1]=true, [4]=true}) then
            self.direction = self.nextDirection
            self.player.vX = self.next_vX
            self.player.vY = self.next_vY
            self.player:updatePlayerPos(pos, self.map)
            self.player:setAnimation(self.direction)
            keep_moving = false
        end
    end
    if keep_moving then
        local pos = self.player:calculateUpdatePosition(dt, self.player.vX, self.player.vY)
        -- id for wall is 1, 4 is the monster gate
        if self.player:checkColision(pos, self.map, {[1]=true, [4]=true}) then
            self.player:updatePlayerPos(pos, self.map)
        else 
            self.player.stateMachine:change('idle')
        end
    end

    -- if self.player:checkColision() then
    --     self.player.stateMachine:change('explode')
    -- end
end

function PlayerMoveState:render()
end