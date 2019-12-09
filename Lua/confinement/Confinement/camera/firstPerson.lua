local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))

local Camera = workspace.CurrentCamera
local LocalPlayer = _s.Players.LocalPlayer

local rotx, roty = 0, 0
local active = true
local sprint = false



_s.UserInputService.InputBegan:Connect(function(Input, gameProcess)
	if gameProcess == false then
		if Input.KeyCode == Enum.KeyCode.Q then
			active = false
			_s.UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			_s.UserInputService.MouseIconEnabled = true
		elseif Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.RightShift then
			sprint = true
			LocalPlayer.Character.Humanoid.WalkSpeed = 20
		end
	end
end)

_s.UserInputService.InputEnded:Connect(function(Input, gameProcess)
	if gameProcess == false then
		if Input.KeyCode == Enum.KeyCode.Q then
			active = true
			_s.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			_s.UserInputService.MouseIconEnabled = false
		elseif Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.RightShift then
			sprint = false
			LocalPlayer.Character.Humanoid.WalkSpeed = 8
		end
	end
end)

_s.UserInputService.InputChanged:Connect(function(Input, gameProcess)
	if gameProcess == false then
		if Input.UserInputType == Enum.UserInputType.MouseMovement then
			if Input.Delta.X then
				if active then
					rotx, roty = rotx + -_s.UserInputService:GetMouseDelta().x / 10, roty + -_s.UserInputService:GetMouseDelta().y / 10
				end
			end
		end
	end
end)



local function fixrot()
	local tempx, tempy = rotx, roty
	if tempy < -2 and tempy > 2 then
		tempy = 0
	elseif tempy > 85 then
		tempy = 85
	elseif tempy < -85 then
		tempy = -85
	end
	
	if _s.UserInputService:GetMouseDelta().x / 10 < 1 and _s.UserInputService:GetMouseDelta().x / 10 > -1 then
		tempx = rotx
	end
	rotx = tempx
	roty = tempy
end

local function invisichar(bool, hatbool)
	if bool == true then
		for Index, Value in pairs(LocalPlayer.Character:GetChildren()) do
			if Value:IsA("BasePart") then
				Value.Transparency = 1
			end
		end
	end
	if hatbool then
		for Index, Value in pairs(LocalPlayer.Character:GetChildren()) do
			if Value:IsA("Accessory") then
				Value.Handle.Transparency = 1
			end
		end
	end
end

local function setFOV(bool)
	local max = 60
	local min = 55
	local framecount = 5
	
	if bool then
		if Camera.FieldOfView < max then
			Camera.FieldOfView = Camera.FieldOfView + ((max - min) / framecount)
		end
	else
		if Camera.FieldOfView > min then
			Camera.FieldOfView = Camera.FieldOfView - ((max - min) / framecount)
		end
	end
end

LocalPlayer.CharacterAdded:Connect(function(Char)
	repeat wait() until Char.HumanoidRootPart
	wait(0.5)
	invisichar(true)
end)
LocalPlayer.PlayerScripts.ControlScript.Changed:Connect(function()
	active = not LocalPlayer.PlayerScripts.ControlScript.Disabled
	
	if active == true then
		rotx = LocalPlayer.Character.HumanoidRootPart.Orientation.Y
		roty = LocalPlayer.Character.Head.Orientation.Z
	end
end)

local function setup()
	
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.FieldOfView = 55
	--LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
	_s.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	--_s.UserInputService.MouseIconEnabled = false
	
	wait(0.5)
	invisichar(true, true)
	
	_s.RunService.RenderStepped:Connect(function(step)
		if active then
			fixrot()
			
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.p) * CFrame.fromEulerAnglesXYZ(0, math.rad(rotx), 0)
			local RotPos = (LocalPlayer.Character.HumanoidRootPart.CFrame) * CFrame.new(0, 2.4, -0.45) * CFrame.fromEulerAnglesXYZ(math.rad(roty), 0, 0)
			
			Camera.CFrame = RotPos
			
			if sprint then
				setFOV(true)
			else
				setFOV(false)
			end
		else
			setFOV(false)
			--Camera.CFrame = LocalPlayer.Character.Head.CFrame
		end
	end)
end

return setup