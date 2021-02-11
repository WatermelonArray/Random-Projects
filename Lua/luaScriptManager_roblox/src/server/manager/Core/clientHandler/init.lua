--!strict

local core: any = {}

if game:GetService("RunService"):IsServer() then

	local clientModules: any = script.Parent.Parent
	
	local clientLoader = script.loader:Clone()

	local sm = script.Parent.Parent:Clone()

	sm.Parent = clientLoader

	sm.Name = "core"

	clientLoader.core.Assets:Destroy()
	clientLoader.core.Modules:Destroy()

	clientLoader.Parent = game:GetService("StarterPlayer").StarterPlayerScripts

	clientLoader.Disabled = false



	--[[game:GetService("Players").PlayerAdded:Connect(function(player)

		local clientLoader = script.loader:Clone()

		local sm = script.Parent.Parent:Clone()

		sm.Parent = clientLoader

		sm.Name = "core"

		clientLoader.core.Assets:Destroy()
		clientLoader.core.Modules:Destroy()

		clientLoader.Parent = player

		--clientLoader.Parent = game:GetService("StarterPlayer").StarterPlayerScripts

		clientLoader.Disabled = false

	end)]]

end

return core