--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

MonsterRunState = Class{__includes=BaseState}

function MonsterRunState:init(entity, map)
    self.monster = entity
    self.map = map

    self.monster.currentAnimation.currentFrameIndex = 1
end

function MonsterRunState:enter()
    self.monster:setAnimation('points')
    self.timer = 3
    self.monster:setAlive(false)
end

function MonsterRunState:exit()
    self.monster:setAlive(true)
end

function MonsterRunState:update(dt)
    if self.timer > 0 then
        self.timer = self.timer - dt
        return
    end
    if self.monster.x == self.map.monster_pos.x and 
            self.monster.y == self.map.monster_pos.y then
        self.monster:changeState('move')
        return
    end

    local vx = 0
    local vy = 0
    if self.monster.x > self.map.monster_pos.x then
        self.monster:setAnimation('run-left')
        vx = - self.monster.speed
    else if self.monster.x < self.map.monster_pos.x then
        self.monster:setAnimation('run-right')
        vx = self.monster.speed
    else if self.monster.y < self.map.monster_pos.y then
        self.monster:setAnimation('run-down')
        vy = self.monster.speed
    else if self.monster.y > self.map.monster_pos.y then
        self.monster:setAnimation('run-up')
        vy = -self.monster.speed
    end end end end

    pos = self.monster:calculateUpdatePosition(dt, vx, vy)
    self.monster:updatePlayerPos(pos, self.map)
end