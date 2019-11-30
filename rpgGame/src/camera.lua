local src = game:GetService("ReplicatedStorage").source
local service = require(src.services)


-- Variables
local localPlayer = service.players.LocalPlayer
local mouse = localPlayer:GetMouse()
local camera = workspace.CurrentCamera

local psudoCam = Instance.new("Part")

local rotVec = Vector2.new(0, 0)

local shift = 0

-- Data
local inFirst = true
local maxAngle = 179
local cameraRotLock = false
local cameraSmoothening = 1
local cameraBobbing = 0
local cameraActive = true
local sensitivity = Vector2.new(4, 4)


-- tweenCam firstToThird

local goalOut = {CFrame = CFrame.new(0, 2.5, 10)}

local tweenCamOut = service.tweenService:Create(
    psudoCam,
    TweenInfo.new(
        1,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out
    ),
    goalOut

)

local goalIn = {CFrame = CFrame.new(0, 2, 0)}
local tweenCamIn = service.tweenService:Create(
    psudoCam,
    TweenInfo.new(
        1,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out
    ),
    goalIn

)

--// Initialize

service.userInputService.InputBegan:Connect(function(input, process)
    if process then
        if input.KeyCode == Enum.KeyCode.G then
            inFirst = not inFirst
            if inFirst then
                tweenCamIn:Play()
            else
                tweenCamOut:Play()
            end

        end
    end
end)

wait(1)

camera.CameraType = Enum.CameraType.Scriptable
service.userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

service.runService:BindToRenderStep("camera", 1, function(deltaTime)
    local delta = service.userInputService:GetMouseDelta()

    -- set rotVector
    rotVec = Vector2.new(
        delta.x + rotVec.x,
        delta.y + rotVec.y
    )

    if rotVec.y < -maxAngle then
        rotVec = Vector2.new(rotVec.x, -maxAngle)
    elseif rotVec.y > maxAngle then
        rotVec = Vector2.new(rotVec.x, maxAngle)
    end

 --// First Person Rotation

    if inFirst then
        -- set base Position
        camera.CFrame = CFrame.new(localPlayer.Character.PrimaryPart.CFrame.p) * CFrame.new(0, 2 + shift, 0)

    end

    -- set rot Angle in X axis
    camera.CFrame = camera.CFrame * CFrame.fromEulerAnglesXYZ(
        0,
        -math.rad(rotVec.x) / sensitivity.x,
        0
    )



    -- set rot Angle in Y axis
    camera.CFrame = camera.CFrame * CFrame.fromEulerAnglesXYZ(
        -math.rad(rotVec.y) / sensitivity.y,
        0,
        0
    )


end)

return true