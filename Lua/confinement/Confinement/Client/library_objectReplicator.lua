local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))


local baseid = "rbxassetid://"
local LocalPlayer = _s.Players.LocalPlayer


local function runModule(a, m)
	require(a)(m)
end

local function setup()
	_s.ReplicatedStorage.RE.lockerRep.OnClientEvent:Connect(function(anim, model, client)
		if client ~= LocalPlayer then
			runModule(anim, model)
		end
	end)
	
	_s.ReplicatedStorage.RE.genRep.OnClientEvent:Connect(function(anim, client)
		if client ~= LocalPlayer then
			runModule(anim, model)
		end
	end)
end

return setup