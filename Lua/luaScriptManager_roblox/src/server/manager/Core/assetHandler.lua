--!strict

local core: any = {}

if game:GetService("RunService"):IsServer() then

	for index, asset in pairs(script.Parent.Parent.Assets.shared:GetChildren()) do

		asset.Parent = game:GetService("ReplicatedStorage")

	end

	script.Parent.Parent.Assets.shared:Destroy()

end

return core