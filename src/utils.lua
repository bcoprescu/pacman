--[[
    Pacman

    Author: Bogdan Oprescu
    bcoprescu@yahoo.com
]]

--[[
    Generate specified number of quads of specified size starting starting with specified offset
    Quads are located horizontally in the spreadsheet
    args:   atlas - original spritesheet 
            offset - starting position
            size - tile size
            count - number of tiles
]]
function GenerateQuads(atlas, offset, size, count)
    local sheetWidth = atlas:getWidth()
    local sheetHeight = atlas:getHeight()

    local spritesheet = {}

    for x = 0, count - 1 do
        spritesheet[x + 1] = GenerateOneQuad(atlas, {x=offset.x + x * size.x, y=offset.y}, size) 
    end

    return spritesheet
end

function GenerateOneQuad(atlas, offset, size)
    local sheetWidth = atlas:getWidth()
    local sheetHeight = atlas:getHeight()

    local endX = offset.x + size.x
    local endY = offset.y + size.y
    assert(sheetWidth >= offset.x + size.x)
    assert(sheetHeight >= offset.y + size.y)
    
    return love.graphics.newQuad(offset.x, offset.y,
                size.x, size.y, atlas:getDimensions())

end