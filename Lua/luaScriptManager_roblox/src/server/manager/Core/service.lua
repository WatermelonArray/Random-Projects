--!strict

local core: any = {}

core = {

	players = game:GetService("Players");
	userInputService = game:GetService("UserInputService");
	contextActionService = game:GetService("ContextActionService");
	starterGui = game:GetService("StarterGui");
	replicatedStorage = game:GetService("ReplicatedStorage");
	serverScriptService = game:GetService("ServerScriptService");
	proximityPromptService = game:GetService("ProximityPromptService");
	tweenService = game:GetService("TweenService");
	textService = game:GetService("TextService");
	runService = game:GetService("RunService");
	starterPlayer = game:GetService("StarterPlayer");
	contentProvider = game:GetService("ContentProvider");
}

return core