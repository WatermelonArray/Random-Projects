local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))
local LocalPlayer = game:GetService("Players").LocalPlayer

local cam = workspace.CurrentCamera

local Info = TweenInfo.new(
	0.8,							-- Length
	Enum.EasingStyle.Sine,			-- Easing Style
	Enum.EasingDirection.InOut		-- Easing Direction
)



return function(model, anim)

	local Enter = {CFrame = model.Parent.camLock.CFrame}

	if model.debounce.Value == false then
		_s.ReplicatedStorage.RE.lockerRep:FireServer(anim, model)

		if model.active.Value == false then
			
			
			local animc = coroutine.wrap(function() require(anim)(model) end)
			animc()
			
			local char = LocalPlayer.Character
			
			LocalPlayer.PlayerScripts.ControlScript.Disabled = true
			
			local tweenEnter = _s.TweenService:Create(cam, Info, Enter)
			
			tweenEnter:Play()
		else
			
			local animc = coroutine.wrap(function() require(anim)(model) end)
			animc()
			local char = LocalPlayer.Character
			
			
			
			local Leave = {CFrame = char.PrimaryPart.CFrame * CFrame.new(0, 0, -5) * CFrame.new(0, 2.4, -0.45)}
			
			local tweenEnter = _s.TweenService:Create(cam, Info, Leave)
			
			
			tweenEnter:Play()

			char.PrimaryPart.CFrame = model.Parent.charLock.CFrame * CFrame.new(0, 0, -5)
			
			
			wait(1)
			
			LocalPlayer.PlayerScripts.ControlScript.Disabled = false
		end
	end
end