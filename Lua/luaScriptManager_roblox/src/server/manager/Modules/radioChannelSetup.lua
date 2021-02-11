--!strict

local manager: any = nil

local class: any = {}

function createFolder()
	local temp = manager.assets.server["RadioFrequencies"]:Clone()
	temp.Parent = game.Workspace
	wait(2)
	temp.Script.Disabled = false
end

function class.Run(managerRef: any) -- Runs the module

	manager = managerRef
    createFolder()
end

return class