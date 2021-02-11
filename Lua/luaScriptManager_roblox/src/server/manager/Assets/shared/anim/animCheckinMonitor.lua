--!strict

local tweenService = game:GetService("TweenService")

local class = {}

local function setupAnim(introSet, statusSet)

	introSet.logo.ImageTransparency = 1
	introSet.logo.Position = UDim2.new(0.5, 0, 1.5, 0)

	introSet.logoText.ImageTransparency = 1
	introSet.slide.Size = UDim2.new(0, 350, 0, 100)
	introSet.slide.Position = UDim2.new(0.5, 0, 0.5, 250)

	introSet.gradient.ImageTransparency = 1
	introSet.gradient.Size = UDim2.new(0, 300, 0, 300)
	introSet.gradient.Position = UDim2.new(0.5, 0, 0.5, 0)

	statusSet.status.TextTransparency = 1
	statusSet.text.TextTransparency = 1

end

local function logoApear(introSet, statusSet)

	local logoGoal: any = {}
	logoGoal.Position = UDim2.new(0.5, 0, 0.5, 0)
	logoGoal.Size = UDim2.new(0, 300, 0, 300)
	logoGoal.Rotation = 0
	logoGoal.ImageTransparency = 0

		local logoOffsetGoal: any = {}
		logoOffsetGoal.Size = UDim2.new(0, 400, 0, 400)
		logoOffsetGoal.Rotation = -30


	local logoTextGoal: any = {}
	logoTextGoal.ImageTransparency = 0

	local slideGoal: any = {}
	slideGoal.Size = UDim2.new(0, 350, 0, 100)

	local gradientGoal: any = {}
	gradientGoal.Size = UDim2.new(0, 800, 0, 800)
	gradientGoal.ImageTransparency = 0.7

	local logoGoal_info: any = TweenInfo.new(1, Enum.EasingStyle.Quad)
		local logoOffsetGoal_info: any = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local logoOffsetEndGoal_info: any = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	local logoTextGoal_info: any = TweenInfo.new(1, Enum.EasingStyle.Quad)
	local slideGoal_info: any = TweenInfo.new(.3, Enum.EasingStyle.Quad)
	local gradientGoal_info: any = TweenInfo.new(.2, Enum.EasingStyle.Quad)


	local logoGoal_tween: any = tweenService:Create(introSet.logo, logoGoal_info, logoGoal)
		local logoOffsetGoal_tween: any = tweenService:Create(introSet.logo, logoOffsetGoal_info, logoOffsetGoal)
		local logoOffsetEndGoal_tween: any = tweenService:Create(introSet.logo, logoOffsetEndGoal_info, logoGoal)

	local logoTextGoal_tween: any = tweenService:Create(introSet.logoText, logoTextGoal_info, logoTextGoal)
	local slideGoal_tween: any = tweenService:Create(introSet.slide, slideGoal_info, slideGoal)
	local gradientGoal_tween: any = tweenService:Create(introSet.gradient, gradientGoal_info, gradientGoal)

	logoGoal_tween:Play()
	wait(1.5)
	logoOffsetGoal_tween:Play()
	wait(0.3)
	logoOffsetEndGoal_tween:Play()
	wait(0.3)
	gradientGoal_tween:Play()
	slideGoal_tween:Play()
	logoTextGoal_tween:Play()

	wait(1)

end

local function statusApear(introSet, statusSet)

	local logoGoal: any = {}
	logoGoal.Position = UDim2.new(0.5, 0, 0.5, -200)

	local slideGoal: any = {}
	slideGoal.Position = UDim2.new(0.5, 0, 0.5, 50)

	local statusGoal: any = {}
	statusGoal.TextTransparency = 0

	local statusTextGoal: any = {}
	statusTextGoal.TextTransparency = 0



	local logoGoal_info: any = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local slideGoal_info: any = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local statusGoal_info: any = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local statusTextGoal_info: any = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)



	local logoGoal_tween: any = tweenService:Create(introSet.logo, logoGoal_info, logoGoal)
	local gradientGoal_tween: any = tweenService:Create(introSet.gradient, logoGoal_info, logoGoal)
	local slideGoal_tween: any = tweenService:Create(introSet.slide, slideGoal_info, slideGoal)
	local statusGoal_tween: any = tweenService:Create(statusSet.status, statusGoal_info, statusGoal)
	local statusTextGoal_tween: any = tweenService:Create(statusSet.text, statusTextGoal_info, statusTextGoal)



	logoGoal_tween:Play()
	slideGoal_tween:Play()
	gradientGoal_tween:Play()
	wait(.5)
	statusTextGoal_tween:Play()
	wait(1)
	statusGoal_tween:Play()

	wait(5)

end

local function animEnd(introSet, statusSet)

	local logoGoal: any = {}
	logoGoal.ImageTransparency = 1

	local logoTextGoal: any = {}
	logoTextGoal.ImageTransparency = 1

	local gradientGoal: any = {}
	gradientGoal.ImageTransparency = 1

	local statusGoal: any = {}
	statusGoal.TextTransparency = 1

	local statusTextGoal: any = {}
	statusTextGoal.TextTransparency = 1



	local endGoal_info: any = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)



	local logoGoal_tween: any = tweenService:Create(introSet.logo, endGoal_info, logoGoal)
	local logoTextGoal_tween: any = tweenService:Create(introSet.logoText, endGoal_info, logoTextGoal)
	local gradientGoal_tween: any = tweenService:Create(introSet.gradient, endGoal_info, gradientGoal)
	local statusGoal_tween: any = tweenService:Create(statusSet.status, endGoal_info, statusGoal)
	local statusTextGoal_tween: any = tweenService:Create(statusSet.text, endGoal_info, statusTextGoal)



	logoGoal_tween:Play()
	logoTextGoal_tween:Play()
	gradientGoal_tween:Play()
	statusGoal_tween:Play()
	statusTextGoal_tween:Play()
end



class.Main = function(ref: any)

	local debounce: boolean = false

	for index, value in pairs(ref:GetChildren()) do

		local introSet: any = {}

		local statusSet: any = {}

		introSet.logo = value.logo
		introSet.logoText = value.slide.text
		introSet.gradient = value.gradient
		introSet.slide = value.slide

		statusSet.status = value.status
		statusSet.text = value.statusText

		local cor: any = coroutine.create(function()

			while wait(10) do

				setupAnim(introSet, statusSet)

				logoApear(introSet, statusSet)

				statusApear(introSet, statusSet)

				animEnd(introSet, statusSet)
			end
		end)

		coroutine.resume(cor)

	end
end

return class