--!strict

local tweenService = game:GetService("TweenService")

local class: any = {}

local stopAnim: boolean = false

local function setupAnim(introSet: any, mainSet: any)

	stopAnim = false

	introSet.center.Position = UDim2.new(0.5, 0, 1.5, 0)

	introSet.logo.Rotation = -360
	introSet.logo.ImageTransparency = 1

	introSet.gradient.ImageTransparency = 1

	introSet.left.Size = UDim2.new(0, 0, 0, 6)
	introSet.right.Size = UDim2.new(0, 0, 0, 6)

	introSet.left.Visible = false
	introSet.right.Visible = false

	introSet.slide.Position = UDim2.new(0.5, 0, 0.9, 0)
	introSet.text.ImageTransparency = 1

	introSet.back.BackgroundTransparency = 1

	introSet.status.Position = UDim2.new(0.5, 0, 0.3, 0)
	introSet.status.TextTransparency = 1

	introSet.blur.Size = 0
	introSet.blur.Parent = workspace.CurrentCamera

	mainSet.main.Position = UDim2.new(0, 0, 1, 0)

	mainSet.box.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainSet.status.Position = UDim2.new(0.5, 0, 0.755, 0)

	mainSet.dataMid.Position = UDim2.new(0.5, 0, 1.5, 0)
	mainSet.dataLeft.Position = UDim2.new(0.18, 0, 1.5, 0)
	mainSet.dataRight.Position = UDim2.new(0.82, 0, 1.5, 0)

	mainSet.dataMid.render.ImageTransparency = 1
	mainSet.dataLeft.render.ImageTransparency = 1
	mainSet.dataRight.render.ImageTransparency = 1

	mainSet.button.BackgroundTransparency = 1
	mainSet.buttonText.TextTransparency = 1

	mainSet.mainPage.Position = UDim2.new(0, 0, 0, 0)
	mainSet.infoPage.Position = UDim2.new(0, 0, -1, 0)
	mainSet.confirmPage.Position = UDim2.new(0, 0, -1, 0)
	mainSet.passportPage.Position = UDim2.new(0, 0, -1, 0)

end

local function showLogo(introSet: any)

	local logoGoal: any = {}
	logoGoal.Rotation = 0
	logoGoal.ImageTransparency = 0
	logoGoal.Size = UDim2.new(1, 0, 1, 0)

	local backGoal: any = {}
	backGoal.BackgroundTransparency = 0.4

	local centerGoal: any = {}
	centerGoal.Position = UDim2.new(0.5, 0, 0.5, 0)

	local blurGoal: any = {}
	blurGoal.Size = 24

	local logoBigGoal: any = {}
	logoBigGoal.Size = UDim2.new(1.2, 0, 1.2, 0)
	logoBigGoal.Rotation = -30

	local logoNormalGoal: any = {}
	logoNormalGoal.Size = UDim2.new(1, 0, 1, 0)
	logoNormalGoal.Rotation = 0



	local logoGoal_info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local centerGoal_info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local backGoal_info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local logoBigGoal_info = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local logoNormalGoal_info = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)

	local blurGoal_info = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)



	local logoGoal_tween = tweenService:Create(introSet.logo, logoGoal_info, logoGoal)
	local centerGoal_tween = tweenService:Create(introSet.center, centerGoal_info, centerGoal)
	local backGoal_tween = tweenService:Create(introSet.back, backGoal_info, backGoal)
	
	local logoBigGoal_tween = tweenService:Create(introSet.logo, logoBigGoal_info, logoBigGoal)
	local logoNormalGoal_tween = tweenService:Create(introSet.logo, logoNormalGoal_info, logoNormalGoal)
	local blurGoal_tween = tweenService:Create(introSet.blur, blurGoal_info, blurGoal)



	logoGoal_tween:Play()
	centerGoal_tween:Play()
	backGoal_tween:Play()
	blurGoal_tween:Play()

	wait(2)

	if stopAnim then return end

	logoBigGoal_tween:Play()

	wait(0.5)
	
	if stopAnim then return end
	
	logoNormalGoal_tween:Play()

	wait(0.2)

	if stopAnim then return end

end

local function revealIntro(introSet: any)

	local slideGoal: any = {}
	slideGoal.Position = UDim2.new(0.5, 0, 0.75, 0)

	local textGoal: any = {}
	textGoal.ImageTransparency = 0
	
	local gradientGoal: any = {}
	gradientGoal.ImageTransparency = 0.85

	local leftRightGoal: any = {}
	leftRightGoal.Size = UDim2.new(2, 0, 0, 6)
		introSet.left.Visible = true
		introSet.right.Visible = true

	local statusGoal: any = {}
	statusGoal.Position = UDim2.new(0.5, 0, 0.2, 0)
	statusGoal.TextTransparency = 0



	local slideGoal_info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local textGoal_info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)


	local leftRightGoal_info = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local gradientGoal_info = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local statusGoal_info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)



	local slideGoal_tween = tweenService:Create(introSet.slide, slideGoal_info, slideGoal)
	local textGoal_tween = tweenService:Create(introSet.text, textGoal_info, textGoal)

	local leftGoal_tween = tweenService:Create(introSet.left, leftRightGoal_info, leftRightGoal)
	local rightGoal_tween = tweenService:Create(introSet.right, leftRightGoal_info, leftRightGoal)

	local gradientGoal_tween = tweenService:Create(introSet.gradient, gradientGoal_info, gradientGoal)

	local statusGoal_tween = tweenService:Create(introSet.status, statusGoal_info, statusGoal)


	gradientGoal_tween:Play()
	slideGoal_tween:Play()
	textGoal_tween:Play()
	leftGoal_tween:Play()
	rightGoal_tween:Play()

	wait(1)

	if stopAnim then return end

	statusGoal_tween:Play() 

	wait(0.5)

	if stopAnim then return end

end

local function endIntro(introSet: any)

	local introGoal: any = {}
	introGoal.Position = UDim2.new(0, 0, 0.1, 0)

	local frameGoal: any = {}
	frameGoal.BackgroundTransparency = 1

	local imageGoal: any = {}
	imageGoal.ImageTransparency = 1

	local textGoal: any = {}
	textGoal.TextTransparency = 1



	local globalGoal_info = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In)



	local introGoal_tween = tweenService:Create(introSet.intro, globalGoal_info, introGoal)
	local leftGoal_tween = tweenService:Create(introSet.left, globalGoal_info, frameGoal)
	local rightGoal_tween = tweenService:Create(introSet.right, globalGoal_info, frameGoal)
	local logoGoal_tween = tweenService:Create(introSet.logo, globalGoal_info, imageGoal)
	local textGoal_tween = tweenService:Create(introSet.text, globalGoal_info, imageGoal)
	local statusGoal_tween = tweenService:Create(introSet.status, globalGoal_info, textGoal)
	local gradientGoal_tween = tweenService:Create(introSet.gradient, globalGoal_info, imageGoal)

	gradientGoal_tween:Play()
	introGoal_tween:Play()
	leftGoal_tween:Play()
	rightGoal_tween:Play()
	logoGoal_tween:Play()
	textGoal_tween:Play()
	statusGoal_tween:Play()

	wait(0.3)

	if stopAnim then return end

end

local function revealMain(mainSet: any)

	local mainGoal: any = {}
	mainGoal.Position = UDim2.new(0, 0, 0, 0)

		local frameGoal: any = {}
		frameGoal.BackgroundTransparency = 0

		local imageGoal: any = {}
		imageGoal.ImageTransparency = 0

		local textGoal: any = {}
		textGoal.TextTransparency = 0

	local dataMidGoal: any = {}
	dataMidGoal.Position = UDim2.new(0.5, 0, 0.5, 0)
	dataMidGoal.BackgroundTransparency = 0

	local dataLeftGoal: any = {}
	dataLeftGoal.Position = UDim2.new(0.18, 0, 0.5, 0)
	dataLeftGoal.BackgroundTransparency = 0

	local dataRightGoal: any = {}
	dataRightGoal.Position = UDim2.new(0.82, 0, 0.5, 0)
	dataRightGoal.BackgroundTransparency = 0

	local statusGoal: any = {}
	statusGoal.Position = UDim2.new(0.5, 0, 0.825, 0)
	statusGoal.TextTransparency = 0

	local imageGoal: any = {}
	imageGoal.ImageTransparency = 0

	local arrowGoal: any = {}
	arrowGoal.ImageTransparency = 0.3



	local globalGoal_info = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local mainGoal_info = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)



	local globalGoal_tween = tweenService:Create(mainSet.main, globalGoal_info, mainGoal)
	local dataMidGoal_Tween = tweenService:Create(mainSet.dataMid, mainGoal_info, dataMidGoal)
	local dataLeftGoal_Tween = tweenService:Create(mainSet.dataLeft, mainGoal_info, dataLeftGoal)
	local dataRightGoal_Tween = tweenService:Create(mainSet.dataRight, mainGoal_info, dataRightGoal)
	local dataButtonGoal_Tween = tweenService:Create(mainSet.button, mainGoal_info, frameGoal)

	local dataMidImageGoal_Tween = tweenService:Create(mainSet.dataMidImage, mainGoal_info, imageGoal)
	local dataLeftImageGoal_Tween = tweenService:Create(mainSet.dataLeftImage, mainGoal_info, imageGoal)
	local dataRightImageGoal_Tween = tweenService:Create(mainSet.dataRightImage, mainGoal_info, imageGoal)

	local arrowLeftGoal_Tween = tweenService:Create(mainSet.arrowLeft, mainGoal_info, arrowGoal)
	local arrowRightGoal_Tween = tweenService:Create(mainSet.arrowRight, mainGoal_info, arrowGoal)

	local dataButtonTextGoal_Tween = tweenService:Create(mainSet.buttonText, mainGoal_info, textGoal)

	local statusTextGoal_Tween = tweenService:Create(mainSet.status, mainGoal_info, statusGoal)



	globalGoal_tween:Play()

	wait(0.6)

	if stopAnim then return end

	dataMidGoal_Tween:Play()

	wait(0.1)

	if stopAnim then return end

	dataMidImageGoal_Tween:Play()
	dataLeftGoal_Tween:Play()

	wait(0.1)

	if stopAnim then return end

	dataLeftImageGoal_Tween:Play()
	dataRightGoal_Tween:Play()

	wait(0.1)

	if stopAnim then return end
	
	dataRightImageGoal_Tween:Play()

	wait(0.1)

	if stopAnim then return end

	dataButtonGoal_Tween:Play()

	wait(0.2)

	if stopAnim then return end

	arrowLeftGoal_Tween:Play()
	arrowRightGoal_Tween:Play()
	dataButtonTextGoal_Tween:Play()
	statusTextGoal_Tween:Play()

end

class.Main = function(ref: any)

	game:GetService("Players").LocalPlayer.Character.Humanoid.Died:Connect(function() stopAnim = true end)

	local debounce: boolean = false

	-----------------------

	local introSet: any = {}

	introSet.intro = ref.intro

	introSet.logo = ref.intro.center.logo
	introSet.gradient = ref.intro.center.gradient
	introSet.center = ref.intro.center
	introSet.back = ref.back
	introSet.blur = ref.blur

	introSet.left = ref.intro.center.left
	introSet.right = ref.intro.center.right

	introSet.slide = ref.intro.slide
	introSet.text = ref.intro.slide.text

	introSet.status = ref.intro.status

	-----------------------

	local mainSet: any = {}

	mainSet.main = ref.main

	mainSet.box = ref.main.box
	mainSet.status = ref.main.status

	mainSet.dataMid = ref.main.box.frame.main.data.mid
	mainSet.dataLeft = ref.main.box.frame.main.data.left
	mainSet.dataRight = ref.main.box.frame.main.data.right
	
	mainSet.dataMidImage = ref.main.box.frame.main.data.mid.render
	mainSet.dataLeftImage = ref.main.box.frame.main.data.left.render
	mainSet.dataRightImage = ref.main.box.frame.main.data.right.render

	mainSet.button = ref.main.box.frame.main.data.mid.button
	mainSet.buttonText = ref.main.box.frame.main.data.mid.button.select

	mainSet.arrowLeft = ref.main.box.frame.main.arrowL
	mainSet.arrowRight = ref.main.box.frame.main.arrowR

	mainSet.status = ref.main.status

	mainSet.mainPage = ref.main.box.frame.main
	mainSet.infoPage = ref.main.box.frame.info
	mainSet.confirmPage = ref.main.box.frame.confirm
	mainSet.passportPage = ref.main.box.frame.scanPassport


	ref.introSound:Play()

	setupAnim(introSet, mainSet)
	showLogo(introSet)

	if stopAnim then return end

	ref.introImpact:Play()

	wait(0.1)

	if stopAnim then return end

	revealIntro(introSet)

	wait(1)

	if stopAnim then return end

	ref.introSwoosh:Play()

	endIntro(introSet)

	revealMain(mainSet)

end

return class