local Blocks = require(game:GetService("ReplicatedStorage"):WaitForChild("Block_Information"))

-------------------------------------

local function spawnBlock(position, v)
	local p = Instance.new("Part")
	p.Position = Vector3.new(position.X, position.Y, 0)
	p.Size = Vector3.new(10, 10, 10)
	p.Anchored = true
	p.CanCollide = true
	
	p.Color = v.info.Color
	p.Material = v.info.Material
	p.Transparency = v.info.Transparency
	p.Reflectance = v.info.Reflectance
	p.Name = v[1]
	
	p.Parent = workspace.blocks
end

-------------------------------------

return function()
	
	local numberOfBlockData = #Blocks
	local currentLevel = 0
	
	for y = 1, 10 do
		for x = 1, 50 do
			--wait()
			--[[local random = math.noise(x, y, workspace.DistributedGameTime)
			if random < 0 then random = -random end]]
			
			--print(math.floor(math.random() * numberOfBlockData) + 1)
			
			spawnBlock({X = x * 10 - 10, Y = -y * 10 + 10}, Blocks["Rock"])
			
		end
	end
end