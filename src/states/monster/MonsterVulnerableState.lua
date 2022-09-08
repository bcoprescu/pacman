--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

MonsterVulnerableState = Class{__includes=BaseState}

DIRECTIONS = {
    ['run-up'] = {vx=0, vy=-1,},
    ['run-down'] = {vx=0, vy=1,},
    ['run-right'] = {vx=1, vy=0,},
    ['run-left'] = {vx=-1, vy=0,},
}
function MonsterVulnerableState:init(entity, map)
    self.monster = entity
    self.map = map
    self.monster.currentAnimation.currentFrameIndex = 1
    self.direction = DIRECTIONS['run-up']
end

function MonsterVulnerableState:enter()
    self.monster:setVulnerable(true)
    self.monster:setAnimation('vulnerable')
    self.timer = 10
    self.update_animation = true
end

function MonsterVulnerableState:exit()
    self.monster:setVulnerable(false)
end

-- try to run away from the player
function MonsterVulnerableState:bestRunDirection(player)
    if math.abs(player.x - self.monster.x) <
            math.abs(player.y - self.monster.y) then
        if player.x > self.monster.x then
            return 'run-left'
        else
            return 'run-right'
        end
    else 
        if player.y > self.monster.y then
            return 'run-up'
        else
            return 'run-down'
        end
    end
end

function MonsterVulnerableState:update(dt, player)
    self.timer = self.timer - dt
    if self.timer < 3 and self.update_animation then
        self.monster:setAnimation('vulnerable-end')
        self.update_animation = false
    end
    if self.timer < 0 then
        self.monster:setVulnerable(false)
        self.monster:changeState('move')
        return
    end

    local x = self.monster.x + self.direction.vx * self.monster.speed * dt
    local y = self.monster.y + self.direction.vy * self.monster.speed * dt
    if not self.monster:checkColision({x=x, y=y}, self.map, {[1] = true}) then
        clear_directions = {}
        for key, dir in pairs(DIRECTIONS) do
            x = self.monster.x + dir.vx * self.monster.speed * dt
            y = self.monster.y + dir.vy * self.monster.speed * dt
            if self.monster:checkColision({x=x, y=y}, self.map, {[1] = true}) then 
                table.insert(clear_directions, key)
            end
        end
        self.direction = DIRECTIONS[clear_directions[math.random(1, #clear_directions)]]
        assert(self.direction)
    end

    if self.direction then
        local pos = self.monster:calculateUpdatePosition(dt,
                self.direction.vx * self.monster.speed,
                self.direction.vy * self.monster.speed)
        self.monster:updatePlayerPos(pos, self.map)
    end
end