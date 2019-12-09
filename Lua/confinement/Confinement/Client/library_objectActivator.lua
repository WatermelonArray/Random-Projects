local _s = require(game:GetService("ReplicatedStorage"):FindFirstChild("services"))


local baseid = "rbxassetid://"
local LocalPlayer = _s.Players.LocalPlayer

local animM = nil
local anim = nil
local model = nil

local mouse = LocalPlayer:GetMouse()

local function setup()
	_s.UserInputService.InputBegan:Connect(function(input, process)
		if input.KeyCode == Enum.KeyCode.E then
			print(1)
			local module = coroutine.wrap(function()
				print(2)
				if not anim then
					print(3)
					local char = LocalPlayer.Character
					if (char.PrimaryPart.CFrame.p - mouse.Target.CFrame.p).magnitude < 5 and script:FindFirstChild(mouse.Target.Parent.Name) then
						print(4)
						model = mouse.Target.Parent
						animM = script.Parent.animData:FindFirstChild(model.Name .. "Animation")
						anim = script:FindFirstChild(model.Name)

						if model.debounce.Value == false and model.active.Value == false then
							require(anim)(model, animM)
						end
					end
				else
					if model.debounce.Value == false then
						require(anim)(model, animM)
						anim = nil
						animM = nil
						model = nil
					end
				end
				
			end)
			module()
		end
	end)
end

return setup