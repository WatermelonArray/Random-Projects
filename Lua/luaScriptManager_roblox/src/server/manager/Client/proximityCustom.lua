--!strict

local manager: any = nil

local class: any = {}

local GamepadButtonImage: any = {

	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png";
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png";
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png";
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png";
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png";
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png";
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png";
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png";
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png";
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png";
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png";

}

local KeyboardButtonImage: any = {

	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png";
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png";
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png";
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png";
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png";

}

local KeyboardButtonIconMapping: any = {

	["'"] = "rbxasset://textures/ui/Controls/apostrophe.png";
	[","] = "rbxasset://textures/ui/Controls/comma.png";
	["`"] = "rbxasset://textures/ui/Controls/graveaccent.png";
	["."] = "rbxasset://textures/ui/Controls/period.png";
	[" "] = "rbxasset://textures/ui/Controls/spacebar.png";

}

local KeyCodeToTextMapping: any = {

	[Enum.KeyCode.LeftControl] = "Ctrl";
	[Enum.KeyCode.RightControl] = "Ctrl";
	[Enum.KeyCode.LeftAlt] = "Alt";
	[Enum.KeyCode.RightAlt] = "Alt";
	[Enum.KeyCode.F1] = "F1";
	[Enum.KeyCode.F2] = "F2";
	[Enum.KeyCode.F3] = "F3";
	[Enum.KeyCode.F4] = "F4";
	[Enum.KeyCode.F5] = "F5";
	[Enum.KeyCode.F6] = "F6";
	[Enum.KeyCode.F7] = "F7";
	[Enum.KeyCode.F8] = "F8";
	[Enum.KeyCode.F9] = "F9";
	[Enum.KeyCode.F10] = "F10";
	[Enum.KeyCode.F11] = "F11";
	[Enum.KeyCode.F12] = "F12";

}



function class.Run(managerRef: any) -- Runs the module

	manager = managerRef

	local LocalPlayer: any = manager.service.players.LocalPlayer

	while LocalPlayer == nil do

		manager.service.players.ChildAdded:Wait()
		LocalPlayer = manager.service.players.LocalPlayer

	end



	local PlayerGui: any = LocalPlayer:WaitForChild("PlayerGui")

	local function getScreenGui()

		local screenGui: any = PlayerGui:FindFirstChild("ProximityPrompts")

		if screenGui == nil then

			screenGui = Instance.new("ScreenGui")
			screenGui.Name = "ProximityPrompts"
			screenGui.ResetOnSpawn = false
			screenGui.Parent = PlayerGui

		end

		return screenGui

	end

	local function createProgressBarGradient(parent: any, leftSide: any)

		local frame: any = Instance.new("Frame")
		frame.Size = UDim2.fromScale(0.5, 1)
		frame.Position = UDim2.fromScale(leftSide and 0 or 0.5, 0)
		frame.BackgroundTransparency = 1
		frame.ClipsDescendants = true
		frame.Parent = parent

		local image: any = Instance.new("ImageLabel")
		image.BackgroundTransparency = 1
		image.Size = UDim2.fromScale(2, 1)
		image.Position = UDim2.fromScale(leftSide and 0 or -1, 0)
		image.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
		image.Parent = frame

		local gradient: any = Instance.new("UIGradient")

		gradient.Transparency = NumberSequence.new {

			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(.4999, 0),
			NumberSequenceKeypoint.new(.5, 1),
			NumberSequenceKeypoint.new(1, 1)

		}

		gradient.Rotation = leftSide and 180 or 0
		gradient.Parent = image

		return gradient

	end

	local function createCircularProgressBar()

		local bar: any = Instance.new("Frame")
		bar.Name = "CircularProgressBar"
		bar.Size = UDim2.fromOffset(58, 58)
		bar.AnchorPoint = Vector2.new(0.5, 0.5)
		bar.Position = UDim2.fromScale(0.5, 0.5)
		bar.BackgroundTransparency = 1

		local gradient1: any = createProgressBarGradient(bar, true)
		local gradient2: any = createProgressBarGradient(bar, false)

		local progress: any = Instance.new("NumberValue")
		progress.Name = "Progress"
		progress.Parent = bar

		progress.Changed:Connect(function(value: number)

			local angle: any = math.clamp(value * 360, 0, 360)
			gradient1.Rotation = math.clamp(angle, 180, 360)
			gradient2.Rotation = math.clamp(angle, 0, 180)

		end)

		return bar

	end

	local function createPrompt(prompt: any, inputType: any, gui: any)

		local tweensForButtonHoldBegin: any = {}
		local tweensForButtonHoldEnd: any = {}
		local tweensForFadeOut: any = {}
		local tweensForFadeIn: any = {}
		local tweenInfoInFullDuration: any = TweenInfo.new(prompt.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		local tweenInfoOutHalfSecond: any = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tweenInfoFast: any = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tweenInfoQuick: any = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

		local promptUI: any = Instance.new("BillboardGui")
		promptUI.Name = "Prompt"
		promptUI.AlwaysOnTop = true

		local frame: any = Instance.new("Frame")
		frame.Size = UDim2.fromScale(0.5, 1)
		frame.BackgroundTransparency = 1
		frame.BackgroundColor3 = Color3.fromRGB(51, 88, 130)
		frame.Parent = promptUI

		local roundedCorner: any = Instance.new("UICorner")
		roundedCorner.Parent = frame

		local inputFrame: any = Instance.new("Frame")
		inputFrame.Name = "InputFrame"
		inputFrame.Size = UDim2.fromScale(1, 1)
		inputFrame.BackgroundTransparency = 1
		inputFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
		inputFrame.Parent = frame

		local resizeableInputFrame: any = Instance.new("Frame")
		resizeableInputFrame.Size = UDim2.fromScale(1, 1)
		resizeableInputFrame.Position = UDim2.fromScale(0.5, 0.5)
		resizeableInputFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		resizeableInputFrame.BackgroundTransparency = 1
		resizeableInputFrame.Parent = inputFrame

		local inputFrameScaler: any = Instance.new("UIScale")
		inputFrameScaler.Parent = resizeableInputFrame

		local inputFrameScaleFactor: any = inputType == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
		table.insert(tweensForButtonHoldBegin, manager.service.tweenService:Create(inputFrameScaler, tweenInfoFast, { Scale = inputFrameScaleFactor }))
		table.insert(tweensForButtonHoldEnd, manager.service.tweenService:Create(inputFrameScaler, tweenInfoFast, { Scale = 1 }))

		local actionText: any = Instance.new("TextLabel")
		actionText.Name = "ActionText"
		actionText.Size = UDim2.fromScale(1, 1)
		actionText.Font = Enum.Font.GothamSemibold
		actionText.TextSize = 19
		actionText.BackgroundTransparency = 1
		actionText.TextTransparency = 1
		actionText.TextColor3 = Color3.new(1, 1, 1)
		actionText.TextXAlignment = Enum.TextXAlignment.Left
		actionText.Parent = frame
		table.insert(tweensForButtonHoldBegin, manager.service.tweenService:Create(actionText, tweenInfoFast, { TextTransparency = 1 }))
		table.insert(tweensForButtonHoldEnd, manager.service.tweenService:Create(actionText, tweenInfoFast, { TextTransparency = 0 }))
		table.insert(tweensForFadeOut, manager.service.tweenService:Create(actionText, tweenInfoFast, { TextTransparency = 1 }))
		table.insert(tweensForFadeIn, manager.service.tweenService:Create(actionText, tweenInfoFast, { TextTransparency = 0 }))

		local objectText: any = Instance.new("TextLabel")
		objectText.Name = "ObjectText"
		objectText.Size = UDim2.fromScale(1, 1)
		objectText.Font = Enum.Font.GothamSemibold
		objectText.TextSize = 14
		objectText.BackgroundTransparency = 1
		objectText.TextTransparency = 1
		objectText.TextColor3 = Color3.new(0.7, 0.7, 0.7)
		objectText.TextXAlignment = Enum.TextXAlignment.Left
		objectText.Parent = frame

		table.insert(tweensForButtonHoldBegin, manager.service.tweenService:Create(objectText, tweenInfoFast, { TextTransparency = 1 }))
		table.insert(tweensForButtonHoldEnd, manager.service.tweenService:Create(objectText, tweenInfoFast, { TextTransparency = 0 }))
		table.insert(tweensForFadeOut, manager.service.tweenService:Create(objectText, tweenInfoFast, { TextTransparency = 1 }))
		table.insert(tweensForFadeIn, manager.service.tweenService:Create(objectText, tweenInfoFast, { TextTransparency = 0 }))

		table.insert(tweensForButtonHoldBegin, manager.service.tweenService:Create(frame, tweenInfoFast, { Size = UDim2.fromScale(0.5, 1), BackgroundTransparency = 1 }))
		table.insert(tweensForButtonHoldEnd, manager.service.tweenService:Create(frame, tweenInfoFast, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.2 }))
		table.insert(tweensForFadeOut, manager.service.tweenService:Create(frame, tweenInfoFast, { Size = UDim2.fromScale(0.5, 1), BackgroundTransparency = 1 }))
		table.insert(tweensForFadeIn, manager.service.tweenService:Create(frame, tweenInfoFast, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.2 }))

		local roundFrame: any = Instance.new("Frame")
		roundFrame.Name = "RoundFrame"
		roundFrame.Size = UDim2.fromOffset(48, 48)

		roundFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		roundFrame.Position = UDim2.fromScale(0.5, 0.5)
		roundFrame.BackgroundTransparency = 1
		roundFrame.Parent = resizeableInputFrame

		local roundedFrameCorner: any = Instance.new("UICorner")
		roundedFrameCorner.CornerRadius = UDim.new(0.5, 0)
		roundedFrameCorner.Parent = roundFrame

		table.insert(tweensForFadeOut, manager.service.tweenService:Create(roundFrame, tweenInfoQuick, { BackgroundTransparency = 1 }))
		table.insert(tweensForFadeIn, manager.service.tweenService:Create(roundFrame, tweenInfoQuick, { BackgroundTransparency = 0.5 }))

		if inputType == Enum.ProximityPromptInputType.Gamepad then

			if GamepadButtonImage[prompt.GamepadKeyCode] then

				local icon = Instance.new("ImageLabel")
				icon.Name = "ButtonImage"
				icon.AnchorPoint = Vector2.new(0.5, 0.5)
				icon.Size = UDim2.fromOffset(24, 24)
				icon.Position = UDim2.fromScale(0.5, 0.5)
				icon.BackgroundTransparency = 1
				icon.ImageTransparency = 1
				icon.Image = GamepadButtonImage[prompt.GamepadKeyCode]
				icon.Parent = resizeableInputFrame
				table.insert(tweensForFadeOut, manager.service.tweenService:Create(icon, tweenInfoQuick, { ImageTransparency = 1 }))
				table.insert(tweensForFadeIn, manager.service.tweenService:Create(icon, tweenInfoQuick, { ImageTransparency = 0 }))

			end

		elseif inputType == Enum.ProximityPromptInputType.Touch then

			local buttonImage: any = Instance.new("ImageLabel")
			buttonImage.Name = "ButtonImage"
			buttonImage.BackgroundTransparency = 1
			buttonImage.ImageTransparency = 1
			buttonImage.Size = UDim2.fromOffset(25, 31)
			buttonImage.AnchorPoint = Vector2.new(0.5, 0.5)
			buttonImage.Position = UDim2.fromScale(0.5, 0.5)
			buttonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
			buttonImage.Parent = resizeableInputFrame

			table.insert(tweensForFadeOut, manager.service.tweenService:Create(buttonImage, tweenInfoQuick, { ImageTransparency = 1 }))
			table.insert(tweensForFadeIn, manager.service.tweenService:Create(buttonImage, tweenInfoQuick, { ImageTransparency = 0 }))

		else

			local buttonImage: any = Instance.new("ImageLabel")
			buttonImage.Name = "ButtonImage"
			buttonImage.BackgroundTransparency = 1
			buttonImage.ImageTransparency = 1
			buttonImage.Size = UDim2.fromOffset(28, 30)
			buttonImage.AnchorPoint = Vector2.new(0.5, 0.5)
			buttonImage.Position = UDim2.fromScale(0.5, 0.5)
			buttonImage.Image = "rbxasset://textures/ui/Controls/key_single.png"
			buttonImage.Parent = resizeableInputFrame
			table.insert(tweensForFadeOut, manager.service.tweenService:Create(buttonImage, tweenInfoQuick, { ImageTransparency = 1 }))
			table.insert(tweensForFadeIn, manager.service.tweenService:Create(buttonImage, tweenInfoQuick, { ImageTransparency = 0 }))



			local buttonTextString: string = manager.service.userInputService:GetStringForKeyCode(prompt.KeyboardKeyCode)

			local buttonTextImage: string = KeyboardButtonImage[prompt.KeyboardKeyCode]

			if not buttonTextImage then

				buttonTextImage = KeyboardButtonIconMapping[buttonTextString]

			end

			if not buttonTextImage then

				local keyCodeMappedText = KeyCodeToTextMapping[prompt.KeyboardKeyCode]

				if keyCodeMappedText then

					buttonTextString = keyCodeMappedText

				end

			end



			if buttonTextImage then

				local icon: any = Instance.new("ImageLabel")
				icon.Name = "ButtonImage"
				icon.AnchorPoint = Vector2.new(0.5, 0.5)
				icon.Size = UDim2.fromOffset(36, 36)
				icon.Position = UDim2.fromScale(0.5, 0.5)
				icon.BackgroundTransparency = 1
				icon.ImageTransparency = 1
				icon.Image = buttonTextImage
				icon.Parent = resizeableInputFrame
				table.insert(tweensForFadeOut, manager.service.tweenService:Create(icon, tweenInfoQuick, { ImageTransparency = 1 }))
				table.insert(tweensForFadeIn, manager.service.tweenService:Create(icon, tweenInfoQuick, { ImageTransparency = 0 }))

			elseif buttonTextString and buttonTextString ~= "" then

				local buttonText: any = Instance.new("TextLabel")
				buttonText.Name = "ButtonText"
				buttonText.Position = UDim2.fromOffset(0, -1)
				buttonText.Size = UDim2.fromScale(1, 1)
				buttonText.Font = Enum.Font.GothamSemibold
				buttonText.TextSize = 14

				if string.len(buttonTextString) > 2 then

					buttonText.TextSize = 12

				end

				buttonText.BackgroundTransparency = 1
				buttonText.TextTransparency = 1
				buttonText.TextColor3 = Color3.new(1, 1, 1)
				buttonText.TextXAlignment = Enum.TextXAlignment.Center
				buttonText.Text = buttonTextString
				buttonText.Parent = resizeableInputFrame
				table.insert(tweensForFadeOut, manager.service.tweenService:Create(buttonText, tweenInfoQuick, { TextTransparency = 1 }))
				table.insert(tweensForFadeIn, manager.service.tweenService:Create(buttonText, tweenInfoQuick, { TextTransparency = 0 }))

			else

				manager.error("ProximityPrompt '" .. prompt.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(prompt.KeyboardKeyCode))

			end

		end



		if inputType == Enum.ProximityPromptInputType.Touch or prompt.ClickablePrompt then

			local button: any = Instance.new("TextButton")
			button.BackgroundTransparency = 1
			button.TextTransparency = 1
			button.Size = UDim2.fromScale(1, 1)
			button.Parent = promptUI

			local buttonDown: boolean = false

			button.InputBegan:Connect(function(input: any)

				if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and

					input.UserInputState ~= Enum.UserInputState.Change then
					prompt:InputHoldBegin()
					buttonDown = true

				end

			end)



			button.InputEnded:Connect(function(input: any)

				if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then

					if buttonDown then

						buttonDown = false
						prompt:InputHoldEnd()

					end

				end

			end)

			promptUI.Active = true

		end

		if prompt.HoldDuration > 0 then

			local circleBar: any = createCircularProgressBar()
			circleBar.Parent = resizeableInputFrame
			table.insert(tweensForButtonHoldBegin, manager.service.tweenService:Create(circleBar.Progress, tweenInfoInFullDuration, { Value = 1 }))
			table.insert(tweensForButtonHoldEnd, manager.service.tweenService:Create(circleBar.Progress, tweenInfoOutHalfSecond, { Value = 0 }))

		end

		local holdBeganConnection: any
		local holdEndedConnection: any
		local triggeredConnection: any
		local triggerEndedConnection: any

		if prompt.HoldDuration > 0 then

			holdBeganConnection = prompt.PromptButtonHoldBegan:Connect(function()

				for _, tween in ipairs(tweensForButtonHoldBegin) do

					tween:Play()

				end

			end)

			holdEndedConnection = prompt.PromptButtonHoldEnded:Connect(function()

				for _, tween in ipairs(tweensForButtonHoldEnd) do

					tween:Play()

				end

			end)

		end



		triggeredConnection = prompt.Triggered:Connect(function()

			for _, tween in ipairs(tweensForFadeOut) do

				tween:Play()

			end

		end)



		triggerEndedConnection = prompt.TriggerEnded:Connect(function()

			for _, tween in ipairs(tweensForFadeIn) do

				tween:Play()

			end

		end)



		local function updateUIFromPrompt()

			-- todo: Use AutomaticSize instead of GetTextSize when that feature becomes available
			local actionTextSize: any = manager.service.textService:GetTextSize(prompt.ActionText, 19, Enum.Font.GothamSemibold, Vector2.new(1000, 1000))
			local objectTextSize: any = manager.service.textService:GetTextSize(prompt.ObjectText, 14, Enum.Font.GothamSemibold, Vector2.new(1000, 1000))
			local maxTextWidth: any = math.max(actionTextSize.X, objectTextSize.X)
			local promptHeight: number = 72
			local promptWidth: number = 72
			local textPaddingLeft: number = 72

			if (prompt.ActionText ~= nil and prompt.ActionText ~= "") or

				(prompt.ObjectText ~= nil and prompt.ObjectText ~= "") then
				promptWidth = maxTextWidth + textPaddingLeft + 24

			end

			local actionTextYOffset: number = 0

			if prompt.ObjectText ~= nil and prompt.ObjectText ~= '' then

				actionTextYOffset = 9

			end

			actionText.Position = UDim2.new(0.5, textPaddingLeft - promptWidth/2, 0, actionTextYOffset)
			objectText.Position = UDim2.new(0.5, textPaddingLeft - promptWidth/2, 0, -10)

			actionText.Text = prompt.ActionText
			objectText.Text = prompt.ObjectText
			actionText.AutoLocalize = prompt.AutoLocalize
			actionText.RootLocalizationTable = prompt.RootLocalizationTable

			objectText.AutoLocalize = prompt.AutoLocalize
			objectText.RootLocalizationTable = prompt.RootLocalizationTable

			promptUI.Size = UDim2.fromOffset(promptWidth, promptHeight)
			promptUI.SizeOffset = Vector2.new(prompt.UIOffset.X / promptUI.Size.Width.Offset, prompt.UIOffset.Y / promptUI.Size.Height.Offset)

		end

		local changedConnection: any = prompt.Changed:Connect(updateUIFromPrompt)

		updateUIFromPrompt()

		promptUI.Adornee = prompt.Parent
		promptUI.Parent = gui

		for _, tween in ipairs(tweensForFadeIn) do

			tween:Play()

		end

		local function cleanup()

			if holdBeganConnection then

				holdBeganConnection:Disconnect()

			end

			if holdEndedConnection then

				holdEndedConnection:Disconnect()

			end

			triggeredConnection:Disconnect()

			triggerEndedConnection:Disconnect()

			changedConnection:Disconnect()

			for _, tween in ipairs(tweensForFadeOut) do

				tween:Play()

			end

			wait(0.2)

			promptUI.Parent = nil

		end

		return cleanup

	end

	local function onLoad()

		manager.service.proximityPromptService.PromptShown:Connect(function(prompt, inputType)

			if prompt.Style == Enum.ProximityPromptStyle.Default then

				return

			end

			local gui: any = getScreenGui()

			local cleanupFunction: any = createPrompt(prompt, inputType, gui)

			prompt.PromptHidden:Wait()

			cleanupFunction()

		end)
	end

	onLoad()

end

return class