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

require 'src/map/level_1'

require 'src/StateMachine'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/GameOverState'

require 'src/states/player/PlayerExplodeState'
require 'src/states/player/PlayerMoveState'
require 'src/states/player/PlayerIdleState'

require 'src/states/monster/MonsterMoveState'
require 'src/states/monster/MonsterVulnerableState'
require 'src/states/monster/MonsterRunState'

require 'src/entities/Entity'
require 'src/entities/Animation'
require 'src/entities/entity_list'
require 'src/entities/Player'
require 'src/entities/Monster'

require 'src/map/Map'

gTextures = {
    [BASE_TEXTURE] = love.graphics.newImage('graphics/pacman-sprite-sheet_1.png'),
}

gFrames = {
    ['background'] = GenerateQuads(gTextures['base'], {x=371, y=4}, {x=168, y=220}, 2),
    ['player'] = GenerateQuads(gTextures['base'], {x=3, y=92}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 9),
    ['player-explode'] = GenerateQuads(gTextures['base'], {x=3, y=105}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 11),
    ['monster-1'] = GenerateQuads(gTextures['base'], {x=5, y=123}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 8),
    ['monster-2'] = GenerateQuads(gTextures['base'], {x=5, y=136}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 8),
    ['monster-3'] = GenerateQuads(gTextures['base'], {x=5, y=149}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 8),
    ['monster-4'] = GenerateQuads(gTextures['base'], {x=5, y=162}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 8),
    ['monster-explode'] = GenerateQuads(gTextures['base'], {x=5, y=175}, {x=PLAYER_WIDTH, y=PLAYER_HEIGHT}, 8),
    ['dot'] = GenerateOneQuad(gTextures['base'], {x=2, y=80}, {x=3, y=3}),
    ['tiles'] = GenerateQuads(gTextures['base'], {x=TIME_LIST_POS_X, y=TIME_LIST_POS_Y}, {x=MAP_TILE_SIZE, y=MAP_TILE_SIZE}, 16),
    ['points'] = {GenerateOneQuad(gTextures['base'], {x=157, y=169}, {x=15, y=7})},
    ['banner'] = {GenerateOneQuad(gTextures['base'], {x=2, y=4}, {x=181, y=45})},
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['robo'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}