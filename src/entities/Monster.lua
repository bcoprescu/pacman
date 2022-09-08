--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

Monster = Class{__includes = Entity}

function Monster:init(def)
    Entity.init(self, def)

    self.speed = 22
    self.vulnerable = false
    self.alive = true
end

function Monster:update(dt)
    self.stateMachine:update(dt)

    Entity.update(self, dt)
end

function Monster:setAlive(alive)
    self.alive = alive
end

function Monster:isAlive()
    return self.alive
end

function Monster:setVulnerable(vulnderable)
    self.vulnerable = vulnderable
end

function Monster:isVulnerable()
    return self.vulnerable
end