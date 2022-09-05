--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/utils'

require 'src/states/BaseState'

require 'src/StateMachine'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/GameOverState'

require 'src/animation/Entity'
require 'src/animation/Animation'
require 'src/animation/entity_list'
require 'src/Player'
require 'src/Map'


gTextures = {
    [BASE_TEXTURE] = love.graphics.newImage('graphics/pacman-sprite-sheet.png'),
}

gFrames = {
    ['background'] = GenerateQuads(gTextures['base'], {x=200, y=0}, {x=168, y=220}, 3),
    ['player'] = { GenerateOneQuad(gTextures['base'], {x=3, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=20, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=35, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=48, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=63, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=76, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=93, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=110, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
        GenerateOneQuad(gTextures['base'], {x=127, y=91}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}),
    },
    ['dot'] = GenerateOneQuad(gTextures['base'], {x=2, y=80}, {x=3, y=3}),
    ['tiles'] = GenerateQuads(gTextures['base'], {x=TIME_LIST_POS_X, y=TIME_LIST_POS_Y}, {x=MAP_TILE_SIZE, y=MAP_TILE_SIZE}, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.otf', 8),
    ['medium'] = love.graphics.newFont('fonts/roboto.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.otf', 32),
}