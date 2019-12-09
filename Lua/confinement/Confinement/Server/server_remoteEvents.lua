local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))

local function setup()
	local EventFolder = Instance.new("Folder")
	EventFolder.Name = "RE"
	EventFolder.Parent = _s.ReplicatedStorage	
	
	local doorRep = Instance.new("RemoteEvent")
	doorRep.Name = "lockerRep"
	doorRep.Parent = EventFolder
	
		doorRep.OnServerEvent:Connect(function(Client, anim, model)
			local char = Client.Character
			
			print(model.active.Value)
			
			if model.active.Value then
				char.PrimaryPart.CFrame = model.Parent.charLock.CFrame * CFrame.new(0, 0, -5)
				wait(1)
				model.active.Value = false
			else
				
				model.active.Value = true
			end
			doorRep:FireAllClients(anim, model, Client)
		end)
	
	
	
	
	
	local genRep = Instance.new("RemoteEvent")
	genRep.Name = "genRep"
	genRep.Parent = EventFolder
	
		genRep.OnServerEvent:Connect(function(Client, anim)
			local char = Client.Character
			
			print(anim.active.Value)
			
			if anim.active.Value then
				char.PrimaryPart.Anchored = false
				wait(0.5)
				anim.active.Value = false
			else
				char.PrimaryPart.Anchored = true
				anim.active.Value = true
			end
			genRep:FireAllClients(anim, Client)
		end)
		
end

return setup