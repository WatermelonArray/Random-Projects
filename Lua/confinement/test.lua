-- Implementation for sliding movement using MOUSE in Lua.

--[[
    What ideas may be involved for the implementation?

    = Implementation for using MAX value on both X and Y inputs from the mouse.
    = Perhaps a pseudo square with it's own size to limit how far the mosue is able to move.
        ^^ This will mean that both players will be given a fair advantage when widescreen and ulra widescreen monitors are used.
        ^^ Since the algorithm works by dividing the mosue coordinate by the screen resolution, a player with an X cooridinate may have a different sensitivity.

    = Another implementation taht oculd be used by SCALE ascross a given resolution.
        ^^ For example on mouse movement: (ScreenResX / maxMove) * (mouseXCoordinate * Sensitivity)
        ^^ Grab the screen resolution and divide it by so many iterations on both X and Y.
        ^^ This would mean I can only move 10 times across the X or Y axis on the screen.

    = Another implementation would be to use Mouse Delta if the controller setup is done correctly.
        ^^ Delta meaning the amount of force used to move the mouse on the X and Y plane. This is mostly a 2 dimenisional vector.
]]

require(mouseInputService) -- this is not a real service (or library for you c# / c++ users) but it is used for refences to load in an API for the mouse

local cursorX = mouseLocation.X
local cursorY = mouseLocation.Y

local player1 = componentReference_1 -- insert player object here (perhaps using 'self')
local player2 = componentReference_2 -- same for the comment above

local maxMove = 100 -- split the screen into 100 segments on both X and Y

local function GetPosition() -- keeps code clean for future reference
    local tempX = (screenResX / maxMove) * (cursorX) -- similar refence to the original implementation idea
    local tempY = (ScreenResY / maxMove) * (cursorY)

    return tempX, tempY
end

local function Update()

    local posX, posY = GetPosition()

    player1.Position = Vector3.new(0, pos.X, 0) -- this is using RBXLua API but we can use a similar concept for this algorithm
    player2.Position = Vector3.new(0, pos.Y, 0)
end













