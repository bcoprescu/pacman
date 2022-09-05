--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]


ENTITY_DEFS = {
    ['player'] = {
        defaultAnimation = 'go-right',
        animations = {
            ['go-right'] = {
                quads = 'player',
                frames = {1, 3, 2},
                interval = 0.2
            },
            ['go-left'] = {
                quads = 'player',
                frames = {1, 5, 4},
                interval = 0.2
            },
            ['go-up'] = {
                quads = 'player',
                frames = {1, 7, 6},
                interval = 0.2
            },
            ['go-down'] = {
                quads = 'player',
                frames = {1, 9, 8},
                interval = 0.2
            },
        }
    }
}