local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))
local LocalPlayer = game:GetService("Players").LocalPlayer

local M = script.Parent.Parent
local cam = workspace.CurrentCamera

local Info = TweenInfo.new(
	0.5,							-- Length
	Enum.EasingStyle.Sine,			-- Easing Style
	Enum.EasingDirection.InOut		-- Easing Direction
)

local Enter = {CFrame = M.camLock.CFrame}

return function(model)
	local anim = model.anim
	if anim.debounce.Value == false then
		_s.ReplicatedStorage.RE.genRep:FireServer(anim)
		if anim.active.Value == false then
			
			
			local animc = coroutine.wrap(require(anim)()) animc()
			
			local char = LocalPlayer.Character
			
			LocalPlayer.PlayerScripts.ControlScript.Disabled = true
			
			local tweenEnter = _s.TweenService:Create(cam, Info, Enter)
			
			tweenEnter:Play()
		else
			
			local animc = coroutine.wrap(require(anim)()) animc()
			
			local char = LocalPlayer.Character
			
			
			
			local Leave = {CFrame = char.PrimaryPart.CFrame * CFrame.new(0, 2.4, -0.45)}
			
			local tweenEnter = _s.TweenService:Create(cam, Info, Leave)
			
			
			tweenEnter:Play()
			
			wait(0.2)
			
			LocalPlayer.PlayerScripts.ControlScript.Disabled = false
		end
	end
end