for i, v in pairs(game:GetService("ReplicatedStorage").source:GetChildren()) do
    if v:IsA("ModuleScript") then
        delay(0, function() require(v) end)
    end
end