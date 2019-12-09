local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))



local Info = TweenInfo.new(
	0.6,							-- Length
	Enum.EasingStyle.Sine,			-- Easing Style
	Enum.EasingDirection.InOut		-- Easing Direction
)

local Info2 = TweenInfo.new(
	0.375,							-- Length
	Enum.EasingStyle.Sine,			-- Easing Style
	Enum.EasingDirection.In			-- Easing Direction
)




local baseid = "rbxassetid://"

local openSound = 212719873
local closeSound = 212711664

local function anim(model)
	
	local Open1 = {CFrame = model:GetPrimaryPartCFrame() * CFrame.fromEulerAnglesXYZ(0, math.rad(80), 0)}

	local Close1 = {CFrame = model:GetPrimaryPartCFrame() * CFrame.fromEulerAnglesXYZ(0, 0, 0)}

	if model.debounce.Value == false then
		
		model.debounce.Value = true
		
		local temp1 = Instance.new("Part")
		temp1.Anchored = true
		temp1.Size = Vector3.new(0.1, 0.1, 0.1)
		temp1.Transparency = 1
		temp1.CFrame = model:GetPrimaryPartCFrame()
		temp1.CanCollide = false
		
		local sound1 = Instance.new("Sound")
		sound1.Parent = model
		sound1.MaxDistance = 40
		
		local sound2 = Instance.new("Sound")
		sound2.Parent = model
		sound2.MaxDistance = 40
		
		temp1.Changed:Connect(function()
			model:SetPrimaryPartCFrame(temp1.CFrame)
		end)
		
		local tweenOpen1 = _s.TweenService:Create(temp1, Info, Open1)
		
		local tweenClose1 = _s.TweenService:Create(temp1, Info2, Close1)
	
			sound1.SoundId = baseid .. openSound
			sound1:Play()
			
			tweenOpen1:Play()
			tweenOpen1.Completed:Connect(function()
				sound2.SoundId = baseid .. closeSound
				sound2:Play()
			
				tweenClose1:Play()
			end)
		
		
		tweenClose1.Completed:Connect(function()
			temp1:Destroy()
			model.debounce.Value = false
		end)
		
		
		sound1.Ended:Connect(function() sound1:Destroy() end)
	end
end

return anim