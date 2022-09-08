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
                frames = {1, 2, 3, 2},
                interval = 0.1
            },
            ['go-left'] = {
                quads = 'player',
                frames = {1, 4, 5, 4},
                interval = 0.1
            },
            ['go-up'] = {
                quads = 'player',
                frames = {1, 6, 7, 6},
                interval = 0.1
            },
            ['go-down'] = {
                quads = 'player',
                frames = {1, 8, 9, 8},
                interval = 0.1
            },
            ['explode'] = {
                quads = 'player-explode',
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
                interval = 0.1
            }
        }
    },
    ['monster-1'] = {
        defaultAnimation = 'go-up',
        animations = {
            ['go-right'] = {
                quads = 'monster-1', frames = {1, 2}, interval = 0.3},
            ['go-left'] = {
                quads = 'monster-1', frames = {3, 4}, interval = 0.3
            },
            ['go-up'] = {
                quads = 'monster-1', frames = {5, 6}, interval = 0.3
            },
            ['go-down'] = {
                quads = 'monster-1', frames = {7, 8}, interval = 0.3 },
            ['vulnerable'] = {
                quads = 'monster-explode', frames = {1, 2}, interval = 0.3},
            ['vulnerable-end'] = {
                quads = 'monster-explode', frames = {1, 2, 3, 4}, interval = 0.1},
            ['explode'] = {
                quads = 'monster-explode', frames = {1}, interval = 1 },
            ['run-right'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['run-left'] = {
                quads = 'monster-explode', frames = {6}, interval = 1},
            ['run-up'] = {
                quads = 'monster-explode',frames = {6},interval = 1},
            ['run-down'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['points'] = {
                quads = 'points', frames = {1}, interval = 1},
        },
    },
    ['monster-2'] = {
        defaultAnimation = 'go-up',
        animations = {
            ['go-right'] = {
                quads = 'monster-2', frames = {1, 2}, interval = 0.3},
            ['go-left'] = {
                quads = 'monster-2', frames = {3, 4}, interval = 0.3
            },
            ['go-up'] = {
                quads = 'monster-2', frames = {5, 6}, interval = 0.3
            },
            ['go-down'] = {
                quads = 'monster-2', frames = {7, 8}, interval = 0.3 },
            ['vulnerable'] = {
                quads = 'monster-explode', frames = {1, 2}, interval = 0.5},
            ['vulnerable-end'] = {
                quads = 'monster-explode', frames = {1, 2, 3, 4}, interval = 0.1},
            ['explode'] = {
                quads = 'monster-explode', frames = {1}, interval = 1 },
            ['run-right'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['run-left'] = {
                quads = 'monster-explode', frames = {6}, interval = 1},
            ['run-up'] = {
                quads = 'monster-explode',frames = {6},interval = 1},
            ['run-down'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['points'] = {
                quads = 'points', frames = {1}, interval = 1},
        },
    },
    ['monster-3'] = {
        defaultAnimation = 'go-up',
        animations = {
            ['go-right'] = {
                quads = 'monster-3', frames = {1, 2}, interval = 0.3},
            ['go-left'] = {
                quads = 'monster-3', frames = {3, 4}, interval = 0.3
            },
            ['go-up'] = {
                quads = 'monster-3', frames = {5, 6}, interval = 0.3
            },
            ['go-down'] = {
                quads = 'monster-3', frames = {7, 8}, interval = 0.3 },
            ['vulnerable'] = {
                quads = 'monster-explode', frames = {1, 2}, interval = 0.5},
            ['vulnerable-end'] = {
                quads = 'monster-explode', frames = {1, 2, 3, 4}, interval = 0.1},
            ['explode'] = {
                quads = 'monster-explode', frames = {1}, interval = 1 },
            ['run-right'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['run-left'] = {
                quads = 'monster-explode', frames = {6}, interval = 1},
            ['run-up'] = {
                quads = 'monster-explode',frames = {6},interval = 1},
            ['run-down'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['points'] = {
                quads = 'points', frames = {1}, interval = 1},
        },
    },
    ['monster-4'] = {
        defaultAnimation = 'go-up',
        animations = {
            ['go-right'] = {
                quads = 'monster-4', frames = {1, 2}, interval = 0.3},
            ['go-left'] = {
                quads = 'monster-4', frames = {3, 4}, interval = 0.3
            },
            ['go-up'] = {
                quads = 'monster-4', frames = {5, 6}, interval = 0.3
            },
            ['go-down'] = {
                quads = 'monster-4', frames = {7, 8}, interval = 0.3 },
            ['vulnerable'] = {
                quads = 'monster-explode', frames = {1, 2}, interval = 0.5},
            ['vulnerable-end'] = {
                quads = 'monster-explode', frames = {1, 2, 3 ,4}, interval = 0.1},
            ['explode'] = {
                quads = 'monster-explode', frames = {1}, interval = 1 },
            ['run-right'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['run-left'] = {
                quads = 'monster-explode', frames = {6}, interval = 1},
            ['run-up'] = {
                quads = 'monster-explode',frames = {6},interval = 1},
            ['run-down'] = {
                quads = 'monster-explode', frames = {5}, interval = 1},
            ['points'] = {
                quads = 'points', frames = {1}, interval = 1},
        },
    },
}