local function WeldFunction(x, y)
	if y ~= x then
		local W = Instance.new("Weld")
		W.Parent = x
		W.Part0 = x
		W.Part1 = y
		local CJ = CFrame.new(x.Position)
		local C0 = x.CFrame:inverse() * CJ
		local C1 = y.CFrame:inverse() * CJ
		W.C0 = C0
		W.C1 = C1
		y.Anchored = false
		x.Anchored = false
	end
end

local function Weld(Object)
	local FirstPart
	
	if Object:FindFirstChild("Handle") then FirstPart = Object.Handle else FirstPart = Object:GetChildren()[1] end
	
	local function WeldSearch(ObjectTable)
		
		local Table = ObjectTable:GetChildren()
		
		for Index, Value in pairs(Table) do
			
			if Value:IsA("BasePart") then
				WeldFunction(FirstPart, Value)
				
			else
				WeldSearch(Value)
			end
		end
	end
	WeldSearch(Object)
end

-------------------------------------

return function()
	local localCharacter = game:GetService("ReplicatedStorage"):WaitForChild("character"):Clone()
	localCharacter.Name = game:GetService("Players").LocalPlayer.Name
	localCharacter.render.BrickColor = BrickColor.Random()
	
	localCharacter.Parent = workspace.players
	localCharacter.collision.CFrame = workspace.SPAWN.CFrame
	
	_G.inventory = {}
	
	delay(0, function() require(script:FindFirstChild("2dControls"))({localCharacter}) end)
	delay(0, function() require(script:FindFirstChild("2dCamera"))({localCharacter}) end)
	delay(0, function() require(script:FindFirstChild("replication"))(localCharacter) end)
	delay(0, function() require(script:FindFirstChild("jellyKinematics"))(localCharacter) end)
	delay(0, function() require(script:FindFirstChild("miningTool"))(localCharacter) end)
	
end