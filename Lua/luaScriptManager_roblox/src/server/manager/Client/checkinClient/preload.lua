--!strict

local manager: any = nil

local class: any = {}

local function assets()

	local list: any = {

		-- IMPORTANT
		"rbxassetid://4962815669"; -- intro logo
		"rbxassetid://4966677367"; -- text
		"rbxassetid://196969716"; -- roundGradient


		-- INTRO SECTION
		"rbxassetid://196969716"; -- gradient


		-- MAIN SECTION
		"rbxassetid://1095263251"; -- shadow
		"rbxassetid://190596490"; -- gradient
		"rbxassetid://6234091852"; -- passport
		"rbxassetid://2930708535"; -- passportIcon
		"rbxassetid://4726772330"; -- arrow

		"rbxassetid://6057825132"; -- Main Background
		"rbxassetid://6218696263"; -- Info Background
		"rbxassetid://6270536003"; -- Confirm Background
		"rbxassetid://6218746148"; -- Passport Background


		-- CONFIRM SECTION
		"rbxassetid://264416968"; -- effectCirlce
		"rbxassetid://2596012739"; -- effectImpact
		"rbxassetid://1591573730"; -- tick


		-- SOUNDS
		"rbxassetid://4612386368"; -- activateSound
		"rbxassetid://4612384434"; -- backSound
		"rbxassetid://4612384434"; -- clickSound
		"rbxassetid://4612384231"; -- failSound
		"rbxassetid://4612386064"; -- introImpact
		"rbxassetid://2513971488"; -- introSound
		"rbxassetid://4612386526"; -- introSwoosh
		"rbxassetid://6102989958"; -- navigateSound

	}

	for index, value in pairs(manager.classRef.tickets) do

		table.insert(list, "rbxassetid://" .. value.checkinImage)

	end

	local userId = manager.service.players.LocalPlayer.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content = manager.service.players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

	table.insert(list, content)

	return list

end

function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

	manager.service.contentProvider:PreloadAsync(assets())

end

return class