--!strict

local tweenService = game:GetService("TweenService")

local class: any = {}

local function reveal(mainSet: any)

	local frameGoal: any = {}
	frameGoal.BackgroundTransparency = 0

	local imageGoal: any = {}
	imageGoal.ImageTransparency = 0

	local textGoal: any = {}
	textGoal.TextTransparency = 0

	local globalGoal_info = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local dataLeftGoal_Tween = tweenService:Create(mainSet.dataLeft.render, globalGoal_info, imageGoal)
	local dataMidGoal_Tween = tweenService:Create(mainSet.dataMid.render, globalGoal_info, imageGoal)
	local dataRightGoal_Tween = tweenService:Create(mainSet.dataRight.render, globalGoal_info, imageGoal)
	
	local dataLeftTextGoal_Tween = tweenService:Create(mainSet.dataLeft.classType, globalGoal_info, textGoal)
	local dataMidTextGoal_Tween = tweenService:Create(mainSet.dataMid.classType, globalGoal_info, textGoal)
	local dataRightTextGoal_Tween = tweenService:Create(mainSet.dataRight.classType, globalGoal_info, textGoal)

	dataLeftGoal_Tween:Play()
	dataMidGoal_Tween:Play()
	dataRightGoal_Tween:Play()
	dataLeftTextGoal_Tween:Play()
	dataMidTextGoal_Tween:Play()
	dataRightTextGoal_Tween:Play()

	wait(0.25)

end

local function remove(mainSet: any)

	local frameGoal: any = {}
	frameGoal.BackgroundTransparency = 1

	local imageGoal: any = {}
	imageGoal.ImageTransparency = 1

	local textGoal: any = {}
	textGoal.TextTransparency = 1

	local globalGoal_info = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

	local dataLeftGoal_Tween = tweenService:Create(mainSet.dataLeft.render, globalGoal_info, imageGoal)
	local dataMidGoal_Tween = tweenService:Create(mainSet.dataMid.render, globalGoal_info, imageGoal)
	local dataRightGoal_Tween = tweenService:Create(mainSet.dataRight.render, globalGoal_info, imageGoal)

	local dataLeftTextGoal_Tween = tweenService:Create(mainSet.dataLeft.classType, globalGoal_info, textGoal)
	local dataMidTextGoal_Tween = tweenService:Create(mainSet.dataMid.classType, globalGoal_info, textGoal)
	local dataRightTextGoal_Tween = tweenService:Create(mainSet.dataRight.classType, globalGoal_info, textGoal)

	dataLeftGoal_Tween:Play()
	dataMidGoal_Tween:Play()
	dataRightGoal_Tween:Play()
	dataLeftTextGoal_Tween:Play()
	dataMidTextGoal_Tween:Play()
	dataRightTextGoal_Tween:Play()

	wait(0.25)

end

local function closeMain(mainSet: any)

	local mainGoal: any = {}
	mainGoal.Position = UDim2.new(0, 0, 1, 0)

	local backGoal: any = {}
	backGoal.BackgroundTransparency = 1

	local blurGoal: any = {}
	blurGoal.Size = 0

	local globalGoal_info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
	local backGoal_info = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
	local blurGoal_info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	local mainGoal_Tween = tweenService:Create(mainSet.main, globalGoal_info, mainGoal)
	local blurGoal_Tween = tweenService:Create(mainSet.blur, blurGoal_info, blurGoal)
	local backGoal_Tween = tweenService:Create(mainSet.back, backGoal_info, backGoal)

	mainGoal_Tween:Play()
	blurGoal_Tween:Play()
	backGoal_Tween:Play()

	wait(0.5)

	--mainSet.main.Parent:Destroy()

	mainSet.blur:Destroy()

end

local function infoAnim(mainSet: any, direction: boolean)

	local mainGoal: any = {}

	if direction then

		mainGoal.Position = UDim2.new(0, 0, 0, 0)

	else

		mainGoal.Position = UDim2.new(0, 0, -1, 0)

	end

	local globalGoal_info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local mainGoal_Tween = tweenService:Create(mainSet.info, globalGoal_info, mainGoal)

	mainGoal_Tween:Play()

	wait(0.4)

end

local function confirmAnim(mainSet: any, direction: boolean)

	local mainGoal: any = {}

	if direction then

		mainGoal.Position = UDim2.new(0, 0, 0, 0)

	else

		mainGoal.Position = UDim2.new(0, 0, -1, 0)

	end

	local globalGoal_info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local mainGoal_Tween = tweenService:Create(mainSet.confirm, globalGoal_info, mainGoal)

	mainGoal_Tween:Play()

	wait(0.4)

end

local function passportAnim(mainSet: any, direction: boolean)

	local mainGoal: any = {}

	if direction then

		mainGoal.Position = UDim2.new(0, 0, 0, 0)

	else

		mainGoal.Position = UDim2.new(0, 0, -1, 0)

	end

	local globalGoal_info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local mainGoal_Tween = tweenService:Create(mainSet.passport, globalGoal_info, mainGoal)

	mainGoal_Tween:Play()

	wait(0.4)

end

local function confirmedTicket(mainSet: any)

	local mainGoal: any = {}
	mainGoal.BackgroundTransparency = 0.25

	local tickGoal: any = {}
	tickGoal.Size = UDim2.new(0.5, 0, 0.5, 0)
	tickGoal.ImageTransparency = 0

	local ringGoal: any = {}
	ringGoal.Size = UDim2.new(2, 0, 2, 0)
	ringGoal.ImageTransparency = 1

	local impactGoal: any = {}
	impactGoal.Size = UDim2.new(2, 0, 2, 0)
	impactGoal.ImageTransparency = 1

	local textGoal: any = {}
	textGoal.TextTransparency = 0


	local globalGoal_info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local mainGoal_Tween = tweenService:Create(mainSet.main, globalGoal_info, mainGoal)
	local tickGoal_Tween = tweenService:Create(mainSet.tick, globalGoal_info, tickGoal)
	local ringGoal_Tween = tweenService:Create(mainSet.ring, globalGoal_info, ringGoal)
	local impactGoal_Tween = tweenService:Create(mainSet.impact, globalGoal_info, impactGoal)

	local congractGoal_Tween = tweenService:Create(mainSet.congrats, globalGoal_info, textGoal)
	local ticketGoal_Tween = tweenService:Create(mainSet.ticket, globalGoal_info, textGoal)

	mainGoal_Tween:Play()

	wait(0.2)

	tickGoal_Tween:Play()
	ringGoal_Tween:Play()

	wait(0.1)

	impactGoal_Tween:Play()

	wait(1)

	congractGoal_Tween:Play()
	ticketGoal_Tween:Play()

	wait(2)

end

class.changeClass = function(ref: any, data: any)

	local mainSet: any = {}

	mainSet.dataMid = ref.main.box.frame.main.data.mid
	mainSet.dataLeft = ref.main.box.frame.main.data.left
	mainSet.dataRight = ref.main.box.frame.main.data.right

	ref.navigateSound:Play()

	remove(mainSet)

	mainSet.dataMid.classType.Text = data.mid.text
	mainSet.dataLeft.classType.Text = data.left.text
	mainSet.dataRight.classType.Text = data.right.text
	
	mainSet.dataMid.render.Image = data.mid.image
	mainSet.dataLeft.render.Image = data.left.image
	mainSet.dataRight.render.Image = data.right.image

	reveal(mainSet)

end

class.info = function(ref: any, direction: boolean)

	local mainSet: any = {}

	mainSet.info = ref.main.box.frame.info

	if direction then

		ref.clickSound:Play()

	else

		ref.backSound:Play()

	end

	infoAnim(mainSet, direction)

end

class.confirm = function(ref: any, direction: boolean)

	local mainSet: any = {}

	mainSet.confirm = ref.main.box.frame.confirm

	if direction then

		ref.clickSound:Play()

	else

		ref.backSound:Play()

	end

	confirmAnim(mainSet, direction)

end

class.passport = function(ref: any, direction: boolean)

	local mainSet: any = {}

	mainSet.passport = ref.main.box.frame.scanPassport

	if direction then

		ref.clickSound:Play()

	else

		ref.backSound:Play()

	end

	passportAnim(mainSet, direction)

end

class.confirmTicket = function(ref: any)

	local mainSet: any = {}

	mainSet.main = ref.main.box.frame.scanPassport.confirmed
	mainSet.tick = ref.main.box.frame.scanPassport.confirmed.tick
	mainSet.ring = ref.main.box.frame.scanPassport.confirmed.effectCircle
	mainSet.impact = ref.main.box.frame.scanPassport.confirmed.effectImpact

	mainSet.congrats = ref.main.box.frame.scanPassport.confirmed.congrats
	mainSet.ticket = ref.main.box.frame.scanPassport.confirmed.ticket

	ref.activateSound:Play()

	confirmedTicket(mainSet)

	ref.introSwoosh:Play()

end

class.close = function(ref: any)

	local mainSet: any = {}

	mainSet.main = ref.main
	mainSet.blur = workspace.CurrentCamera:FindFirstChild("blur")
	mainSet.back = ref.back

	--ref.backSound:Play()

	closeMain(mainSet)

end

return class