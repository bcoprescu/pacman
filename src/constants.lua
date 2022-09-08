--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]


WINDOW_WIDTH = 720
WINDOW_HEIGHT = 900

BASE_TEXTURE = 'base'

PLAYER_WIDTH = 12
PLAYER_HEIGHT = 12

VIRTUAL_WIDTH = 41*4
VIRTUAL_HEIGHT = PLAYER_HEIGHT * 19 + 25


MAP_TILE_SIZE = 4
TIME_LIST_POS_X = 180
TIME_LIST_POS_Y = 223

-- Index of wall tiles in list, depending on adjacent cells 
-- Initioals stand for the wall cells araound U - up, D - down, L - left, R - right 

TILE_IDX = {
    TILE_IDX_URDL = 1,
    TILE_IDX_URD = 2,
    TILE_IDX_RDL = 3,
    TILE_IDX_UDL = 4,
    TILE_IDX_URL = 5,
    TILE_IDX_RD = 6,
    TILE_IDX_DL = 7,
    TILE_IDX_UL = 8,
    TILE_IDX_UR = 9,
    TILE_IDX_UD = 10,
    TILE_IDX_RL = 11,
    TILE_IDX_D = 12,
    TILE_IDX_R = 13,
    TILE_IDX_U = 14,
    TILE_IDX_L = 15,
    TILE_IDX_ = 16,
}