local function setup()
	game:GetService("Players").PlayerAdded:Connect(function(player)		
		player:WaitForChild("PlayerGui"):ClearAllChildren()
				
		
		wait(1)
		
		for Index, Value in pairs(game:GetService("StarterGui"):GetChildren()) do
			Value:Clone().Parent = player.PlayerGui
		end
		
		player.PlayerGui.Client.Disabled = false
	end)
end

-------------------------------------

return function()
	setup()
end