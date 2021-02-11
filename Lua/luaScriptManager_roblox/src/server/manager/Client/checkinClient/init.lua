--!strict

local manager: any = nil

local class: any = {}

local classList: any = {}

local opened: boolean = false

local hasGUI: boolean = false

local notDied: boolean = true

local gui: any = nil
local anim: any = nil
local kiosk: any = nil

local debounce: boolean = true

local mainScreen: boolean = true
local infoScreen: boolean = false
local confirmScreen: boolean = false
local passportScreen: boolean = false

local passportOn: boolean = false

local scanning: boolean = false

local finished: boolean = false

local currentClass: number = 1

---------------------------------
--|| CHECKIN BASED FUNCTIONS ||--
---------------------------------

local function setupClasses()

	local localList: any = {}

	for index, value in pairs(manager.classRef.tickets) do

		localList[value.posRef] = value

	end

	return localList

end

local function checkOwned(ref: number)

	local ticketArray = classList[ref]


	if not ticketArray.free then

		if manager.service.marketplaceService:PlayerOwnsAsset(manager.service.players.LocalPlayer, ticketArray.id) then

			return true, false

		end

		for index, value in pairs(ticketArray.oldId) do

			if value.check then

				if manager.service.marketplaceService:PlayerOwnsAsset(manager.service.players.LocalPlayer, value) then

					return true, true

				end
			end
		end

		return false, false

	else

		return true, false

	end
end

local function generateSurfaceGui(ref: any, folder: any)

	local GUI: any = manager.service.replicatedStorage.checkin.monitorUI:Clone()

	GUI.Adornee = ref.monitor

	GUI.Parent = folder

end

local function createFolder()

	local folder: any = Instance.new("Folder")

	folder.Name = "checkinScreen"

	folder.Parent = manager.service.players.LocalPlayer.PlayerGui

	for index, value in pairs(manager.workspaceAssets.SelfCheckIn:GetChildren()) do

		generateSurfaceGui(value, folder)

	end

	return folder

end

-----------------------------
--|| GUI BASED FUNCTIONS ||--
-----------------------------

local function guicheckDistance(x: number, y: number)

	if gui then

		local xStatus: boolean = false
		local yStatus: boolean = false

		if x < gui.main.box.AbsolutePosition.X or x > (gui.main.box.AbsolutePosition.X + gui.main.box.AbsoluteSize.X) then

			xStatus = true

		end

		if y < gui.main.box.AbsolutePosition.Y or y > (gui.main.box.AbsolutePosition.Y + gui.main.box.AbsoluteSize.Y) then

			yStatus = true

		end

		return xStatus == true or yStatus == true

	end

	return false

end

local function guichangeClass(direction: number)

	if gui then

		debounce = false

		-- 0 previous | 1 next
		if direction == 1 then

			currentClass += 1

		elseif direction == 0 then

			currentClass -= 1

		end

		if currentClass > #classList then

			currentClass = 1

		elseif currentClass <= 0 then

			currentClass = #classList

		end



		local previousClass = currentClass - 1
		local nextClass = currentClass + 1

		if previousClass <= 0 then

			previousClass = #classList

		end

		if nextClass > #classList then

			nextClass = 1

		end

		local data = {

			mid = {
				text = classList[currentClass].name;
				image = "rbxassetid://" .. classList[currentClass].checkinImage;
			};

			left = {
				text = classList[previousClass].name;
				image = "rbxassetid://" .. classList[previousClass].checkinImage;
			};

			right = {
				text = classList[nextClass].name;
				image = "rbxassetid://" .. classList[nextClass].checkinImage;
			};

		}

		anim.changeClass(gui, data)

		debounce = true
	end
end

local function guiclose()

	if gui then

		debounce = false

		gui.close.Visible = false

		require(manager.service.players.LocalPlayer.PlayerScripts.PlayerModule):GetControls():Enable()
		manager.service.players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

		manager.service.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
		manager.service.starterGui:SetCore("TopbarEnabled", true)
		manager.service.starterGui:SetCore("ResetButtonCallback", true)

		anim.close(gui)

		kiosk.monitor.ProximityPrompt.Enabled = true

		hasGUI = false
		mainScreen = true
		infoScreen = false
		confirmScreen = false
		passportScreen = false

		passportOn = false

		scanning = false

		finished = false

		notDied = false

		currentClass = 1

		debounce = true

		gui:Destroy()

		gui = nil

	end
end

local function guiselectClass()

	if gui then

		debounce = false

		mainScreen = false
		infoScreen = true
		confirmScreen = false
		passportScreen = false

		gui.main.box.frame.info.main.classType.Text = classList[currentClass].name
		gui.main.box.frame.info.main.classDescription.Text = classList[currentClass].checkinDescription
		gui.main.box.frame.info.main.render.Image = "rbxassetid://" .. classList[currentClass].checkinImage

		anim.info(gui, true)

		debounce = true
	
	end
end

local function guibackClass()

	if gui then

		debounce = false

		anim.info(gui, false)

		mainScreen = true
		infoScreen = false
		confirmScreen = false
		passportScreen = false

		debounce = true

	end
end

local function guiselectConfirm()

	if gui then

		debounce = false

		mainScreen = false
		infoScreen = false
		confirmScreen = true
		passportScreen = false

		local userId = manager.service.players.LocalPlayer.UserId
		local thumbType = Enum.ThumbnailType.HeadShot
		local thumbSize = Enum.ThumbnailSize.Size420x420
		local content = manager.service.players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

		gui.main.box.frame.confirm.main.classType.Text = classList[currentClass].name
		---gui.main.box.frame.confirm.main.render.Image = "rbxassetid://" .. classList[currentClass].checkinImage
		gui.main.box.frame.confirm.main.playerRender.Image = content

		anim.confirm(gui, true)

		debounce = true

	end
end

local function guibackConfirm()

	if gui then

		debounce = false

		anim.confirm(gui, false)

		mainScreen = false
		infoScreen = true
		confirmScreen = false
		passportScreen = false

		debounce = true

	end
end

local function guiselectPassport()

	if gui then

		debounce = false

		mainScreen = false
		infoScreen = false
		confirmScreen = false
		passportScreen = true

		anim.passport(gui, true)

		debounce = true

	end
end

local function guibackPassport()

	if gui then

		debounce = false

		anim.passport(gui, false)

		mainScreen = false
		infoScreen = false
		confirmScreen = true
		passportScreen = false

		debounce = true

	end
end

local function guihandleScanner(direction: number?)

	if gui then

		local prevScale: number = 0.05
		local scale: number = 0.1
		local nextScale: number = 0.15

		local speed = 0.03

		local tickCount: number = 0

		local direction = direction or 0

		scanning = true

		local reverse: boolean = false



		gui.main.box.frame.scanPassport.main.colorRGB.BackgroundColor3 = Color3.new(1, 1, 1)
		gui.main.box.frame.scanPassport.main.colorRGB.UIGradient.Enabled = true



		local globalColor = Color3.new(1, 0, 0)

		local startSeq = ColorSequenceKeypoint.new(0, globalColor)
		local endSeq = ColorSequenceKeypoint.new(1, globalColor)

		local moveSeq = ColorSequenceKeypoint.new(scale, Color3.new(1, 1, 1))
		local prevSeq =  ColorSequenceKeypoint.new(prevScale, globalColor)
		local nextSeq =  ColorSequenceKeypoint.new(nextScale, globalColor)

		if direction == 1 then

			scanning = false
			gui.main.box.frame.scanPassport.main.colorRGB.UIGradient.Enabled = false

		else

			while scanning do

				if reverse then

					scale -= speed
					prevScale -= speed
					nextScale -= speed

					if scale < 0.1 then

						scale = 0.1

					end

					if nextScale < 0.15 then

						nextScale = 0.15

					end

					if prevScale < 0.05 then

						prevScale = 0.05

						reverse = false

					end

				else

					scale += speed
					prevScale += speed
					nextScale += speed

					if scale > 0.9 then

						scale = 0.9

					end

					if nextScale > 0.95 then

						nextScale = 0.95

						reverse = true

					end

					if prevScale > 0.85 then

						prevScale = 0.85

					end

				end

				moveSeq = ColorSequenceKeypoint.new(scale, Color3.new(1, 1, 1))
				nextSeq =  ColorSequenceKeypoint.new(nextScale, globalColor)
				prevSeq =  ColorSequenceKeypoint.new(prevScale, globalColor)

				gui.main.box.frame.scanPassport.main.colorRGB.UIGradient.Color = ColorSequence.new(
					{
						startSeq,
						prevSeq,
						moveSeq,
						nextSeq,
						endSeq,
					}
				)

				wait()

				tickCount += 1

				if tickCount > 60 then

					finished = true

					gui.main.box.frame.scanPassport.main.colorRGB.BackgroundColor3 = Color3.new(0, 1, 0)
					gui.main.box.frame.scanPassport.main.colorRGB.UIGradient.Enabled = false

					anim.confirmTicket(gui)

					workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

					guiclose()

					return

				end
			end
		end
	end
end

local function guihandlePassportAnim(direction: number?)

	if gui then

		local goal = {Position = UDim2.new(0.575, 0, 0.675, 0)}

		local info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

		local direction = direction or 0

		if direction == 1 then

			goal = {Position = UDim2.new(0.575, 0, 1.675, 0)}

			info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

			passportOn = false

			guihandleScanner(1)

		else

			spawn(guihandleScanner)

		end

		manager.service.tweenService:Create(gui.main.box.frame.scanPassport.passport, info, goal):Play()

	end
end

local function guiRun() -- Runs the module

	wait(0.1)

	classList = setupClasses()

	anim = require(manager.service.replicatedStorage.anim.animMainCheckIn)



	gui.main.box.frame.main.arrowR.MouseButton1Click:Connect(function() guichangeClass(1) end)

	gui.main.box.frame.main.arrowL.MouseButton1Click:Connect(function() guichangeClass(0) end)

	gui.main.box.frame.main.data.mid.button.MouseButton1Click:Connect(function() guiselectClass() end)

	gui.main.box.frame.info.bottom.backButton.MouseButton1Click:Connect(function() guibackClass() end)

	gui.main.box.frame.info.bottom.selectButton.MouseButton1Click:Connect(function() guiselectConfirm() end)

	gui.main.box.frame.confirm.bottom.backButton.MouseButton1Click:Connect(function() guibackConfirm() end)

	gui.main.box.frame.confirm.bottom.selectButton.MouseButton1Click:Connect(function() guiselectPassport() end)



	gui.close.MouseButton1Up:Connect(function(x: number, y: number)

		if debounce and not passportScreen then

			if guicheckDistance(x, y) then

				guiclose()

			end

		end
	end)



	manager.service.userInputService.InputBegan:Connect(function(input: any, process: boolean)

		if debounce then

			if input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.DPadRight then

				if mainScreen then

					guichangeClass(1)

				end

			elseif input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.DPadLeft then

				if mainScreen then

					guichangeClass(0)

				end

			elseif input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.ButtonA and finished == false then

				if mainScreen then

					guiselectClass()

				elseif infoScreen then

					guiselectConfirm()

				elseif confirmScreen then

					guiselectPassport()

				elseif passportScreen then

					guihandlePassportAnim()

				end

			elseif input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.ButtonB then

				if mainScreen then

					guiclose()

				elseif infoScreen then

					guibackClass()

				elseif confirmScreen then

					guibackConfirm()

				end

			end
		end
	end)



	manager.service.userInputService.InputEnded:Connect(function(input: any, process: boolean)

		if debounce and passportScreen and finished == false then

			if input.KeyCode == Enum.KeyCode.Return then

				guihandlePassportAnim(1)

			end

		end
	end)

	local colorCount: number = 1

	while wait() do

		if gui then

			if (not scanning and not finished) then

				colorCount += 1

				if colorCount > 360 then colorCount = 1 end

				gui.main.box.frame.scanPassport.main.colorRGB.BackgroundColor3 = Color3.fromHSV(colorCount / 360, 255 / 255, 255 / 255)

			end

		else

			break

		end
	end
end

--------------------------------
--|| START MODULE FUNCTIONS ||--
--------------------------------

local function spawnGUI(local_kiosk: any)

	local local_gui: any = manager.service.replicatedStorage.checkin["check-in_UI"]:Clone()

	local_gui.Parent = manager.service.players.LocalPlayer.PlayerGui

	hasGUI = true

	local_kiosk.monitor.ProximityPrompt.Enabled = false

	require(manager.service.players.LocalPlayer.PlayerScripts.PlayerModule):GetControls():Disable()
	manager.service.players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

	manager.service.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	manager.service.starterGui:SetCore("TopbarEnabled", false)
	manager.service.starterGui:SetCore("ResetButtonCallback", false)

	local classList: any = setupClasses()

	local_gui.main.box.frame.main.data.left.classType.Text = classList[#classList].name
	local_gui.main.box.frame.main.data.left.render.Image = "rbxassetid://" .. classList[#classList].checkinImage

	local_gui.main.box.frame.main.data.mid.classType.Text = classList[1].name
	local_gui.main.box.frame.main.data.mid.render.Image = "rbxassetid://" .. classList[1].checkinImage

	local_gui.main.box.frame.main.data.right.classType.Text = classList[2].name
	local_gui.main.box.frame.main.data.right.render.Image = "rbxassetid://" .. classList[2].checkinImage

	local animIntro = require(manager.service.replicatedStorage.anim.animIntroCheckIn)
	animIntro.Main(local_gui)

	wait(0.1)

	gui = local_gui
	kiosk = local_kiosk

	guiRun()

end

local function initialize()

	manager.service.players.LocalPlayer.Chatted:Connect(function(msg)

		if msg == "!sc" then

			opened = not opened

			for index, value in pairs(manager.workspaceAssets.SelfCheckIn:GetChildren()) do

				value.monitor.ProximityPrompt.Enabled = opened

				value.monitor.ProximityPrompt.Triggered:Connect(function()

					if opened then

						if not hasGUI then

							spawnGUI(value)

						end

					end
				end)
			end
		end
	end)
end

function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

	require(script.preload).Run(manager)

	local folder: any = createFolder()

	local animModule: any = require(manager.service.replicatedStorage.anim.animCheckinMonitor)

	manager.service.players.LocalPlayer.Character.Humanoid.Died:Connect(function(char)

		if gui then

			gui:Destroy()

		end

	end)

	manager.service.players.LocalPlayer.CharacterAdded:Connect(function(char)

		require(manager.service.players.LocalPlayer.PlayerScripts.PlayerModule):GetControls():Enable()

		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

		manager.service.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
		manager.service.starterGui:SetCore("TopbarEnabled", true)
		manager.service.starterGui:SetCore("ResetButtonCallback", true)

		if kiosk then

			kiosk.monitor.ProximityPrompt.Enabled = true

			kiosk = nil

		end

		if workspace.CurrentCamera:FindFirstChildOfClass("BlurEffect").Name == "blur" then

			workspace.CurrentCamera:FindFirstChildOfClass("BlurEffect"):Destroy()

		end

		notDied = true

		hasGUI = false

		gui = nil

		--manager.print("ATTEMPTING CLIENT")

	end)

	animModule.Main(folder)

	initialize()

end

return class