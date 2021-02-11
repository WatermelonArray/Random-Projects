--!strict

local manager: any = nil

local class: any = {}

function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

end

return class