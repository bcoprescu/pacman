--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.player = Player(ENTITY_DEFS['player'])
    self.map = Map(LEVEL_1)
    self.monsters = self:createMonsters()
    
    self.player.x = self.map.player_start.x
    self.player.y = self.map.player_start.y
    
    self.player.stateMachine = StateMachine{
        ['idle'] = function() return PlayerIdleState(self.player, self.map) end,
        ['move'] = function() return PlayerMoveState(self.player, self.map) end,
        ['explode'] = function() return PlayerExplodeState(self.player, self.map) end,
    }
    self.score = 0
    self.lives = 3

    self.player.stateMachine:change('idle')
    self.freeze = false
    self.freeze_timer = 0

    self.dot_number = self:countDots()
end

function PlayState:countDots()
    local dots = 0
    for y =1, self.map.h do 
        for x = 1, self.map.w do
            if self.map.matrix[y][x] == 2 or
                    self.map.matrix[y][x] == 3 then
                dots = dots + 1
            end
        end
    end
    return dots
end

function PlayState:createMonsters()
    local monsters = {}
    for i =1, 4 do
        monsters[i] = Monster(ENTITY_DEFS['monster-'..i])
        monsters[i].x = self.map.monster_pos.x
        monsters[i].y = self.map.monster_pos.y
        monsters[i].stateMachine = StateMachine{
            ['move'] = function() return MonsterMoveState(monsters[i], self.map) end,
            ['vulnerable'] = function() return MonsterVulnerableState(monsters[i], self.map) end,
            ['run'] = function() return MonsterRunState(monsters[i], self.map) end,
        }
        monsters[i].stateMachine:change('move')
    end

    return monsters
end

function PlayState:resetPlay()
    self.player.x = self.map.player_start.x
    self.player.y = self.map.player_start.y
    self.player.stateMachine:change('idle')
    self.player:setAnimation('go-right')

    local monsters = {}
    for i =1, 4 do
        self.monsters[i].x = self.map.monster_pos.x
        self.monsters[i].y = self.map.monster_pos.y
        self.monsters[i].stateMachine:change('move')
        self.monsters[i]:setAnimation('go-up')
    end
end

function PlayState:makeMonstersVulnerable()
    for i =1, #self.monsters do
        if self.monsters[i]:isAlive() then
            self.monsters[i]:changeState('vulnerable')
        end
    end
end

function PlayState:freezePlay()
    self.freeze = true
    self.freeze_timer = 1.3
end

function PlayState:checkMonsterColision()
    local player_center = {
        x = self.player.x + self.player.w / 2,
        y = self.player.y + self.player.h / 2,
    }
    for i = 1, #self.monsters do
        local monster_center = {
            x = self.monsters[i].x + self.monsters[i].w / 2,
            y = self.monsters[i].y + self.monsters[i].h / 2,
        }

        if math.abs(player_center.x - monster_center.x) < self.map.tile_w and 
                math.abs(player_center.y - monster_center.y) < self.map.tile_h then
            -- a colision was detected
            if self.monsters[i]:isVulnerable() then
                self.monsters[i]:changeState('run')
                self.score = self.score + 200
            else if self.monsters[i]:isAlive() then
                self.player:changeState('explode')
                self:freezePlay()
                self.lives = self.lives - 1
                break
            end end
        end
    end
end

function PlayState:checkDotColision()
    local x = self.player.x
    local y = self.player.y
    local x_case = math.floor(x / self.map.tile_w) + 1
    local y_case = math.floor(y / self.map.tile_h) + 1

    local x_end_case = math.floor( (x + self.player.w)  / self.map.tile_w)
    if x >  math.floor(x / self.map.tile_w) * self.map.tile_w then
        x_end_case = x_end_case + 1
    end
    local y_end_case = math.floor( (y + self.player.h) / self.map.tile_h)
    if y >  math.floor(y / self.map.tile_h) * self.map.tile_h then
        y_end_case = y_end_case  + 1
    end

    for yy = y_case, y_end_case do 
        for xx = x_case, x_end_case do
            if self.map.matrix[yy][xx] == 2 then
                self.score = self.score + 10
                self.map.matrix[yy][xx] = 0
                self.dot_number = self.dot_number - 1
            end
            if self.map.matrix[yy][xx] == 3 then
                self.score = self.score + 50
                self.map.matrix[yy][xx] = 0
                self:makeMonstersVulnerable()
                self.dot_number = self.dot_number - 1
            end
        end
    end
    return true
end

function PlayState:update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if self.dot_number == 0 or self.lives == 0 then
        gStateMachine:change('game-over', {score=self.score, victory=self.lives > 0})
        return
    end

    if self.freeze then
        self.freeze_timer = self.freeze_timer - dt
        if self.freeze_timer <= 0 then
            self.freeze = false
            self:resetPlay()
        end
        self.player.currentAnimation:update(dt)
    else 
        for i = 1, #self.monsters do
            self.monsters[i]:update(dt)
        end
        self.player:update(dt)
        self:checkDotColision()
        self:checkMonsterColision()
        self.map:update(dt)
    end
end


function PlayState:render()
    local offset = {x = 0, y = 25}
    self.map:render(offset)
    for i = 1, #self.monsters do
        self.monsters[i]:render(offset)
    end
    self.player:render(offset)
    
    love.graphics.setColor(255/255, 255/255, 1/255, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Score: " .. tostring(self.score), 0, 0, VIRTUAL_WIDTH, 'right')
    love.graphics.setColor(1, 1, 1, 1)

    for i = 1, self.lives + 1 do
        love.graphics.draw(gTextures['base'], gFrames['player'][2], 
        VIRTUAL_WIDTH - 14 * (i -1), 10)
    end
end