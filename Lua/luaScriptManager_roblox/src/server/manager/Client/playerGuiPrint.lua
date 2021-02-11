--!strict

local manager: any = nil

local class: any = {}

function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

	manager.service.players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child: any)

		manager.warn(child.Name .. " was added")

	end)

	manager.service.players.LocalPlayer.PlayerGui.ChildRemoved:Connect(function(child: any)

		manager.warn(child.Name .. " was removed")

	end)

	--[[manager.service.players.LocalPlayer.PlayerGui.DescendantAdded:Connect(function(child: any)

		manager.warn(child.Name .. " descendant added")

	end)

	manager.service.players.LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(child: any)

		manager.warn(child.Name .. " descendant removed")

	end)]]

end

return class