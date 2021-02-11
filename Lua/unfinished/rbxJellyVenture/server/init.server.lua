local re = Instance.new("RemoteEvent")
re.Parent = game:GetService("ReplicatedStorage")
re.Name = "rEevent_toServer"

local reC = Instance.new("RemoteEvent")
reC.Parent = game:GetService("ReplicatedStorage")
reC.Name = "rEevent_toClient"

local player_Data = game:GetService("ReplicatedStorage"):FindFirstChild("player_data")

local playerInventory = {}

-------------------------------------

local function checkInventoryStatus(name)
	if playerInventory[name] then return true end
	
	playerInventory[name] = {}
	
	return true
end

-------------------------------------

re.OnServerEvent:Connect(function(client, data)
	if data[1] == "replicateV" then
		
		
		if player_Data:FindFirstChild(data[2]) then
			local playerFolder = player_Data:FindFirstChild(data[2])
			
			playerFolder.X.Value = data[3][1]
			playerFolder.Y.Value = data[3][2]
			playerFolder.Action.Value = data[3][3]
		else
			local file = Instance.new("Configuration")
			file.Name = data[2]
				local x = Instance.new("NumberValue")
				x.Name = "X"
				x.Parent = file
				local y = Instance.new("NumberValue")
				y.Name = "Y"
				y.Parent = file
				local active = Instance.new("BoolValue")
				active.Name = "Action"
				active.Parent = file
				
			file.Parent = player_Data
			
			x.Value = data[3][1]
			y.Value = data[3][2]
			active.Value = data[3][3]
		end
	elseif data[1] == "removePart" then
		
		if checkInventoryStatus(client.Name) then
			table.insert(playerInventory[client.Name], #playerInventory[client.Name] + 1, data[2].Name)
		end
		
		reC:FireAllClients(data[2])
		
		data[2]:Destroy()
	end
end)

-------------------------------------

for Index, Value in pairs(script:GetChildren()) do
	if Value:IsA("ModuleScript") then
		print(Value.Name)
		require(Value)()
	end
end