local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))
local LocalPlayer = game:GetService("Players").LocalPlayer

LocalPlayer.CharacterAdded:Connect(function(char)
    local part = Instance.new("Part")
    part.Name = "anchor"
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.CanCollide = false
    part.Anchored = true
    part.Parent = char

    local weld = Instance.new("Weld")
    weld.part0 = char.HumanoidRootPart
    weld.part1 = part
    
    part.Anchore = false
end)

return function ()
    repeat wait() until LocalPlayer.Character
    local char = LocalPlayer.Character

    local part = Instance.new("Part")
    part.Name = "anchor"
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.CanCollide = false
    part.Anchored = true
    part.Parent = char

    local weld = Instance.new("Weld")
    weld.part0 = char.HumanoidRootPart
    weld.part1 = part
    
    part.Anchore = false
end