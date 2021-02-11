--!strict

local manager: any = nil

local class: any = {}



function staffPersonDead(person: any)

	person.Character:WaitForChild("Humanoid").Died:Connect(function()

		manager.service.players:FindFirstChild(person.Name).CharacterAdded:Wait()
		local newRadio = manager.service.replicatedStorage.radio.Radio:Clone()
		newRadio.Parent = person.Backpack
		newRadio:FindFirstChild("LocalScript").Disabled = false
		staffPersonDead(person)

	end)

end

function giveRadio(person: any)
	manager.print(person.name.. " is a staff member at jetEire!")

	local newRadio = manager.service.replicatedStorage.radio.Radio:Clone()
	newRadio.Parent = person.Backpack
	newRadio:FindFirstChild("LocalScript").Disabled = false
	staffPersonDead(person)
end

function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

	local LocalPlayer: any = manager.service.players.LocalPlayer

	while LocalPlayer == nil do
		manager.service.players.ChildAdded:Wait()
		LocalPlayer = manager.service.players.LocalPlayer
	end
	local Backpack = LocalPlayer:WaitForChild("Backpack")
	local getRankJE = LocalPlayer:GetRankInGroup(374802)
	if (getRankJE > 15 and getRankJE < 35) or (getRankJE > 46) then
		giveRadio(LocalPlayer)
	elseif LocalPlayer.Name == "Player1" or LocalPlayer.Name == "Player2"  then
		giveRadio(LocalPlayer)
	end
end

return class

