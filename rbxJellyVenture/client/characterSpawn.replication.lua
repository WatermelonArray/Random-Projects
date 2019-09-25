return function(player)
	local re_ToServer = game:GetService("ReplicatedStorage"):FindFirstChild("rEevent_toServer")
	
	while wait(0.05) do
		re_ToServer:FireServer({"replicateV", player.Name,
			{
				player.collision.CFrame.p.X;
				player.collision.CFrame.p.Y;
				false;
			}
		})
	end
end