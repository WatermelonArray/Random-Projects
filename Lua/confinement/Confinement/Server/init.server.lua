local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))

local Ignore = {
	
}

local function IsNotIgnored(Module)
	local Return
	for _i, Value in pairs(Ignore) do
		if not Return then
			Return = string.lower(Module.Name) == "server_" .. string.lower(Value)
		else
			break
		end
	end
	return Return
end


for _i, Module in pairs(script:GetChildren()) do
	if Module:IsA("ModuleScript") and string.sub(Module.Name, 1, 7) == "server_" and not IsNotIgnored(Module) then
		print(Module)
		local ResultError = pcall(function()
			local Result = require(Module)
			if type(Result) == "function" then
				spawn(Result)
			end
		end)
	end
end