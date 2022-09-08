--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

MonsterMoveState = Class{__includes=BaseState}

function MonsterMoveState:init(entity, map)
    self.monster = entity
    self.map = map

    self.monster.currentAnimation.currentFrameIndex = 1
    self.direction = {vx=0, vy=-self.monster.speed, animation='go-up'}
end

function MonsterMoveState:enter()
    self.direction = {vx=0, vy=-self.monster.speed, animation='go-up'}
    self.monster:setAnimation('go-up')
end

function MonsterMoveState:update(dt)
    local pos = self.monster:calculateUpdatePosition(dt, self.direction.vx, self.direction.vy)
    if (not self.monster:checkColision(pos, self.map, {[1] = true})) or 
            (self.monster.x == self.map.monster_pos.x 
            and self.direction.vy > -self.monster.speed) then
        local directions = {
            ['go-up'] = {vx=0, vy = -self.monster.speed, animation='go-up'},
            ['go-down'] = {vx=0, vy=self.monster.speed, animation='go-down'},
            ['go-left'] = {vx=-self.monster.speed, vy=0, animation='go-left'},
            ['go-right'] = {vx=self.monster.speed, vy=0, animation='go-right'}
        }
        local clear_directions = {}
        for key, dir in pairs(directions) do
            local x = self.monster.x + dir.vx * dt
            local y = self.monster.y + dir.vy * dt
            if self.monster:checkColision({x=x, y=y}, self.map, {[1] = true}) then 
                table.insert(clear_directions, key)
            end
        end
        assert(#clear_directions > 0)
        self.direction = directions[clear_directions[math.random(1, #clear_directions)]]
        self.monster:setAnimation(self.direction.animation)
    end 
    if self.direction then
        local pos = self.monster:calculateUpdatePosition(dt, self.direction.vx, self.direction.vy)
        self.monster:updatePlayerPos(pos, self.map)
    end
end
