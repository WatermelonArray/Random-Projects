local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage game:GetService("ReplicatedStorage")

local maxWalkSpeed = 20
local slowDownRate = 3

local moving = false
local jumping = false

-------------------------------------

return function(array)
	UserInputService.InputBegan:Connect(function(input, process)
		if process == false then
			if input.KeyCode == Enum.KeyCode.D then
				array[1].collision.force.Force = Vector3.new(array[1].collision:GetMass() * 100,  array[1].collision.force.Force.Y, 0)
				moving = true
			elseif input.KeyCode == Enum.KeyCode.A then
				array[1].collision.force.Force = Vector3.new(-(array[1].collision:GetMass() * 100),  array[1].collision.force.Force.Y, 0)
				moving = true
			elseif input.KeyCode == Enum.KeyCode.W and jumping == false then
				jumping = true
				array[1].collision.force.Force = Vector3.new(array[1].collision.force.Force.X, array[1].collision:GetMass() * 275, 0)
				wait(0.1)
				array[1].collision.force.Force = Vector3.new(array[1].collision.force.Force.X,  -1177.2, 0)
				
				delay(0, function()
					while wait() do
						
						local rayStart = array[1].collision.CFrame
						local normal = -rayStart.upVector
						local ray = Ray.new(rayStart.p, normal.unit * 5000)
						
						
						local hit, pos, surf = workspace:FindPartOnRayWithIgnoreList(ray, {workspace.players})
						
						if jumping == true and (rayStart.p.Y - pos.Y) < array[1].collision.Size.Y / 2 then
							jumping = false
							break
						end
					end
				end)
			end
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input, process)
		if process == false then
			if input.KeyCode == Enum.KeyCode.D then
				array[1].collision.force.Force = Vector3.new(0,  array[1].collision.force.Force.Y, 0)
				moving = false
			elseif input.KeyCode == Enum.KeyCode.A then
				array[1].collision.force.Force = Vector3.new(0,  array[1].collision.force.Force.Y, 0)
				moving = false
			elseif input.KeyCode == Enum.KeyCode.W then
				array[1].collision.force.Force = Vector3.new(array[1].collision.force.Force.X,  -1177.2, 0)
			end
		end
	end)
	
	game:GetService("RunService").RenderStepped:Connect(function()
		
		if array[1].collision.Velocity.X > maxWalkSpeed then
			array[1].collision.Velocity = Vector3.new(maxWalkSpeed, array[1].collision.Velocity.Y, 0)
		end
		
		if array[1].collision.Velocity.X < -maxWalkSpeed then
			array[1].collision.Velocity = Vector3.new(-maxWalkSpeed, array[1].collision.Velocity.Y, 0)
		end
		
		
		if moving == false then
			
			if array[1].collision.Velocity.X > 0 and array[1].collision.Velocity.X - slowDownRate > 0 then
				array[1].collision.Velocity = Vector3.new(array[1].collision.Velocity.X - slowDownRate, array[1].collision.Velocity.Y, 0)
			elseif array[1].collision.Velocity.X > 0 and array[1].collision.Velocity.X < slowDownRate then
				array[1].collision.Velocity = Vector3.new(0, array[1].collision.Velocity.Y, 0)
			end
			
			if array[1].collision.Velocity.X < 0 and array[1].collision.Velocity.X + slowDownRate < 0 then
				array[1].collision.Velocity = Vector3.new(array[1].collision.Velocity.X + slowDownRate, array[1].collision.Velocity.Y, 0)
			elseif array[1].collision.Velocity.X < 0 and array[1].collision.Velocity.X > -slowDownRate then
				array[1].collision.Velocity = Vector3.new(0, array[1].collision.Velocity.Y, 0)
			end
		end
	end)
end