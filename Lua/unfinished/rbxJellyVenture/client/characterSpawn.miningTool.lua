local UserInputService = game:GetService("UserInputService")
local re_ToServer = game:GetService("ReplicatedStorage"):FindFirstChild("rEevent_toServer")

local block = require(game:GetService("ReplicatedStorage"):WaitForChild("Block_Information"))

local active = false

local damaged_blocks = {
	
}

local mouse = game:GetService("Players").LocalPlayer:GetMouse()

return function(plr)
	
	local tool = game:GetService("ReplicatedStorage").miningTool:Clone()
	tool.Parent = plr
	
	UserInputService.InputBegan:Connect(function(input, process)
		if process == false then
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				active = true
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input, process)
		if process == false then
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				active = false
			end
		end
	end)
	
	game:GetService("RunService").RenderStepped:Connect(function(step)
		
		local mouseCFrame = Vector3.new(mouse.hit.p.X, mouse.hit.p.Y, 3)
		
		local toolPartCFrame = plr.tool.CFrame.p
		
		local point = CFrame.new(Vector3.new(toolPartCFrame.X, toolPartCFrame.Y, 3), mouseCFrame)
		
		tool.CFrame = point
		
		if active then
			local mouseVector = Vector3.new(mouse.hit.p.X, mouse.hit.p.Y, 0)
			
			local unit = (mouseVector - plr.collision.CFrame.p).unit
			
			local ray = Ray.new(plr.collision.CFrame.p, unit * 20)
			
			local hit, pos, surf = workspace:FindPartOnRayWithIgnoreList(ray, {workspace.players, workspace.ignoreBlocks, workspace.Model, workspace.SPAWN})
			
			if hit then
				if damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)]then
					damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][2] = damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][2] - step
					
					damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][3].Size = (damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][3].oSize.Value / block[hit.Name].hp) * damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][2]
					
					if damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][2] <= 0 then
						damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)][3]:Destroy()
						
						table.insert(_G.inventory, #_G.inventory + 1, hit.Name)
						
						re_ToServer:FireServer({"removePart", hit})
					end
				else
					local fakePart = hit:Clone()
					fakePart.Parent = workspace.ignoreBlocks
					
					local vector = Instance.new("Vector3Value")
					vector.Parent = fakePart
					vector.Name = "oSize"
					vector.Value = fakePart.Size
						
					hit.Material = Enum.Material.SmoothPlastic
					hit.Transparency = 0.75
					hit.Color = Color3.new(1, 1, 1)
					
					damaged_blocks[hit.Name .. tostring(hit.Position.X) .. tostring(hit.Position.Y)] = {hit.Name, block[hit.Name].hp, fakePart}
				end
			end
		end
		
	end)
end