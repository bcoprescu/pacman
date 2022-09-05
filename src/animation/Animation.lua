--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

Animation = Class{}

function Animation:init(def) 
    self.frames = def.frames
    self.interval = def.interval
    self.texture = def.texture or BASE_TEXTURE
    self.quads = def.quads

    self.currentFrameIndex = 0

    self.timer = 0
end

function Animation:update(dt)
    if (self.timer > self.interval) then
        self.currentFrameIndex = (self.currentFrameIndex + 1) % #self.frames
        self.timer = 0
    else
        self.timer = self.timer + dt
    end
 end

 function Animation:getFrame()
    return gFrames[self.quads][self.frames[self.currentFrameIndex + 1]]
 end
 
 function Animation:getTexture()
    return gTextures[self.texture]
 end
