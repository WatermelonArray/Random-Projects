wait(1)
for i, v in pairs(script:GetChildren()) do
	if v:IsA("ModuleScript") then
		delay(0, function() require(v)() end)
	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	workspace.fan.CFrame = workspace.fan.CFrame * CFrame.fromEulerAnglesXYZ(0, -math.rad(0.5), 0)
end)