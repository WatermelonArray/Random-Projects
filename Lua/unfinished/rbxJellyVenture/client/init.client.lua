--[[local RunService = game:GetService("RunService")

local camera = workspace.CurrentCamera

local sideCam = require(script:WaitForChild("2dCamera"))
local sideControl = require(script:WaitForChild("2dControls"))

local jelly = require(script:WaitForChild("jellyKinematics"))(workspace:WaitForChild("Model"))

wait(1)

camera.CameraType = Enum.CameraType.Scriptable

local function spawnPart()
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.Size = Vector3.new(0.5, 0.5, 0.5)
	p.BrickColor = BrickColor.Random()
	p.Parent = workspace
	return p
end

--local g = spawnPart()

local UserInputService = game:GetService("UserInputService")

UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
UserInputService.MouseIconEnabled = false
	
sideControl({workspace.Model})

RunService.RenderStepped:Connect(function()
	sideCam({true})
end)]]

wait(1)

game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):ClearAllChildren()

for Index, Value in pairs(script:GetChildren()) do
	if Value:IsA("ModuleScript") then
		print(Value.Name)
		delay(0, function()
			require(Value)()
		end)
	end
end