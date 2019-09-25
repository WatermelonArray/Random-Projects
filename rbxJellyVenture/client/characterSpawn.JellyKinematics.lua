local player_Data = game:GetService("ReplicatedStorage"):FindFirstChild("player_data")
local re_ToServer = game:GetService("ReplicatedStorage"):FindFirstChild("rEevent_toServer")

local blockData = require(game:GetService("ReplicatedStorage"):WaitForChild("Block_Information"))

local tweenService = game:GetService("TweenService")

local tempInventory = {}

-------------------------------------

local function spawnBlock(v)
	local findBLOCK = blockData[v]
	
	local p = Instance.new("Part")
	p.Size = Vector3.new(1, 1, 1)
	p.Anchored = true
	p.CanCollide = false
	
	p.Color = findBLOCK.info.Color
	p.Material = findBLOCK.info.Material
	p.Transparency = findBLOCK.info.Transparency
	p.Reflectance = findBLOCK.info.Reflectance
	p.Name = findBLOCK[1]
	
	local position = Instance.new("Vector3Value")
	position.Parent = p
	position.Name = "offset"
	
	return p
end

local function renderJelly(player)
	local tPart = player.t
	local toolPart
	if player.Name == game:GetService("Players").LocalPlayer.Name then
		toolPart = player.tool
	end
	
	local t, b = tPart.CFrame, (player.collision.CFrame * CFrame.new(0, -player.collision.Size.Y / 2, 0))
	local render = player.render
	
	local rotation = (t.p - b.p).unit
	local distance = (t.p - b.p).magnitude
	
	local height = (t.p.Y - b.p.Y)
	local length = (t.p.X - b.p.X)
	local width = (t.p.Z - b.p.Z)
	
	
	
	local sizeX, sizeY = 3, distance
	
	local sizeXMin = 1
	
	if 9 - distance >= sizeXMin then
		sizeX = 9 - distance
	else
		sizeX = sizeXMin
	end
	
	render.Size = Vector3.new(sizeX, sizeY, sizeX)
	
	render.CFrame = b * CFrame.new(length / 2, height / 2, width / 2)
	
	render.CFrame = CFrame.new(render.CFrame.p, t.p) * CFrame.fromEulerAnglesXYZ(-math.rad(90), 0, 0)
	
	--if player.Name == game:GetService("Players").LocalPlayer.Name then
		tPart.force.Position = (player.collision.CFrame * CFrame.new(0, 3, 0)).p
		
		--print(tostring(player.Name) .. ": " .. tostring(tPart.force.Position))
		
		if player.Name == game:GetService("Players").LocalPlayer.Name then
			toolPart.force.Position = (player.collision.CFrame * CFrame.new(0, 0, player.collision.Size.X / 2)).p
		end
	--end
	
-------------------------------------
--     render inventory system     --
-------------------------------------

	if #tempInventory ~= #_G.inventory then
		local block = spawnBlock(_G.inventory[#_G.inventory - #tempInventory])
		
		block.offset.Value = Vector3.new(
			math.random(-player.collision.Size.X / 3 * 10, player.collision.Size.X / 3 * 10) / 10,
			math.random(-player.collision.Size.Y / 3 * 10, player.collision.Size.Y / 3 * 10) / 10,
			math.random(-player.collision.Size.Z / 3 * 10, player.collision.Size.Z / 3 * 10) / 10)
		block.Parent = player.collision
		
		table.insert(tempInventory, #tempInventory + 1, block)
	end
	
	if player.Name == game:GetService("Players").LocalPlayer.Name then
		for index, value in pairs(tempInventory) do
			
			-- Poistion Calculation
			
			local x, y, z
			x = player.render.Size.X
			y = player.render.Size.Y
			z = player.render.Size.Z
			
			local newoffsetX = (x / player.collision.Size.X) * value.offset.Value.X
			local newoffsetY = (y / player.collision.Size.Y) * value.offset.Value.Y
			local newoffsetZ = (z / player.collision.Size.Z) * value.offset.Value.Z
			
			--[[if math.random(0, 1) == 1 then newoffsetX = - newoffsetX end
			if math.random(0, 1) == 1 then newoffsetY = - newoffsetY end
			if math.random(0, 1) == 1 then newoffsetZ = - newoffsetZ end]]
			
			value.CFrame = player.render.CFrame * CFrame.new(newoffsetX, newoffsetY, newoffsetZ)
			
			-- Size Calculation
			
			local sx = (1 / player.collision.Size.X) * player.render.Size.X
			local sy = (1 / player.collision.Size.Y) * player.render.Size.Y
			local sz = (1 / player.collision.Size.Z) * player.render.Size.Z
			
			value.Size = Vector3.new(sx, sy, sz)
			
		end
	end
end

-------------------------------------

local function spawnCharacter(playerInstance)
	local template = game:GetService("ReplicatedStorage"):WaitForChild("character")
	template.render.BrickColor = BrickColor.Random()
	
	template.Name = playerInstance.Name
	
	template.collision.force:Destroy()
	template.tool:Destroy()
	
	return template
end

-------------------------------------

return function(plr)
	
-------------------------------------
--       player event setup        --
-------------------------------------
	
	local currentPlayers = {}
	
	for index, value in pairs(game:GetService("Players"):GetPlayers()) do
		if value ~= game:GetService("Players").LocalPlayer then
			table.insert(currentPlayers, #currentPlayers + 1, spawnCharacter(value))
		end
	end
	
	game:GetService("Players").PlayerAdded:Connect(function(player)
		table.insert(currentPlayers, #currentPlayers + 1, spawnCharacter(player))
	end)
	
	game:GetService("Players").PlayerRemoving:Connect(function(player)
		for index, value in pairs(currentPlayers) do
			if value.Name == player.Name then
				value:Destroy()
				table.remove(currentPlayers, index)
				break
			end
		end
	end)
	
-------------------------------------
	
	game:GetService("RunService").RenderStepped:Connect(function(step)
		renderJelly(plr)
		plr.collision.gyro.CFrame = CFrame.new()
		
-------------------------------------
--       not so jelly stuff        --
-------------------------------------
		
		for index, value in pairs(currentPlayers) do
			local stats = player_Data:FindFirstChild(value.Name)
			
			if (value.collision.CFrame.p - plr.collision.CFrame.p).magnitude < 50 then
				
				local current_X, current_Y = value.collision.CFrame.p.X, value.collision.CFrame.p.Y
				
				local endX, endY = stats.X.Value, stats.Y.Value
				
				local differenceX = (endX - current_X)
				
				
				endX = (current_X + (differenceX / 2))
				
				
				value.collision.CFrame = CFrame.new(endX, endY, 0)
				
				value.Parent = workspace.players
				renderJelly(value)
				
			else
				value.Parent = game:GetService("ReplicatedStorage").tempPlayers
			end
		end
		
	end)
end