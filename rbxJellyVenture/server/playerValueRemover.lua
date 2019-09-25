return function()
	local player_Data = game:GetService("ReplicatedStorage"):FindFirstChild("player_data")
	
	game:GetService("Players").PlayerRemoving:Connect(function(player)
		player_Data:FindFirstChild(player.Name):Destroy()
	end)
end