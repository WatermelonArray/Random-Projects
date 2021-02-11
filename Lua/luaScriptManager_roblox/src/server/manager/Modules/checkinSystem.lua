--!strict

local manager: any = nil

local class: any = {}

local checkIn_cache: any = {}

local function CreateCheckIn(ref: any)

	local temp = manager.assets.server["Check-In"]:Clone()

	temp:SetPrimaryPartCFrame(ref.CFrame)

	table.insert(checkIn_cache, temp)

	ref:Destroy()

end

local function FillNodes()

	-- Spawn Models

	for index, node in pairs(manager.workspaceAssets.SelfCheckIn:GetChildren()) do

		CreateCheckIn(node)

	end

	for index, model in pairs(checkIn_cache) do

		model.Parent = manager.workspaceAssets.SelfCheckIn

	end

end



function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

	FillNodes()

end

return class