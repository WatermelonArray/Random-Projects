local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage game:GetService("ReplicatedStorage")

local lastX = 0
local lastY = 0

local lastDX = 0
local lastDY = 0

-------------------------------------

local function fixVector(x, y, offset)
	
	local tempx, tempy = x, y
	
	if tempx > offset then
		tempx = offset
	elseif tempx < -offset then
		tempx = -offset
	end
	
	if tempy > offset then
		tempy = offset
	elseif tempy < -offset then
		tempy = -offset
	end
	
	return tempx, tempy
end
	

-------------------------------------

local function renderCamera(array)
	local LocalPlayer = Players.LocalPlayer
		local basePart = array[1].collision
	local Mouse = LocalPlayer:GetMouse()
	
	local camera = workspace.CurrentCamera
	
	local maxX = Mouse.ViewSizeX
	local maxY = Mouse.ViewSizeY
	local currentX = Mouse.X
	local currentY = Mouse.Y
	local deltaX = UserInputService:GetMouseDelta().X / 10
	local deltaY = UserInputService:GetMouseDelta().Y / 10
	
	local x = 0
	local y = 0
	
	local differentX = 0
	local differentY = 0
	
	local studOffset = 2.5
	
	-- Fix Delta Algorithm --
	if deltaX == lastDX then
		deltaX = 0
	else
		lastDX = deltaX
	end
	if deltaY == lastDY then
		deltaY = 0
	else
		lastDY = deltaY
	end
	
	
	-------------------------
	
	local finalPos = CFrame.new(
		basePart.CFrame * Vector3.new(0, 0, 20)
	)
	
	camera.CFrame = finalPos
end

-------------------------------------

return function(array)
	game:GetService("RunService").RenderStepped:Connect(function()
		renderCamera(array)
	end)
end