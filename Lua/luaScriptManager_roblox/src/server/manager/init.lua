--!strict

local system: any = {}

--// Setup core components
system.print = function(...) print("// JESM : ", ... or "Print") end
system.modulePrint = function(...) print("// JESM : Module ", ... or "(unknown)" .. " compiled.") end
system.warn = function(...) warn("// JESM : ", ... or "Warn") end
system.error = function(...) warn("// JESM :: Crit : ", ... or "Error") end
system.shutdown = function(...) error("// JESM :: shutdown : ", ... or "Error") end -- SHOULD ONLY BE USED IN EXTREME CASES

local loadOrder: any = { -- used for MODULES, not CORE modules

	"checkinSystem";
	"radioChannelSetup";
	"giveRadiotoStaff";

}

local clientOrder: any = {

	"checkinClientNEW";
	"proximityCustom";
	"radioClient";
	--"playerGuiPrint";

}

system.core = script.Core

system.workspaceAssets = workspace:FindFirstChild("scriptableAssets")

local function loadModules(order: any, ref: any)

	for index: number, module: any in pairs(order) do

		local failsafe = pcall(function() return ref:FindFirstChild(module) and ref:FindFirstChild(module):IsA("ModuleScript") or error(nil) end)

		if failsafe then

			local compiled: boolean, output: string? = pcall(function()

				spawn(function()

					require(ref:FindFirstChild(module)).Run(system)

				end)

			end)

			if not compiled then

				system.error(module .. " - " .. output)

				system.warn("THIS IS AN ERROR OUTPUT")

			else

				system.modulePrint(module)

			end
		end
	end

	system.warn("Compile Successful")

end

function setupEnviroment()

	if game:GetService("RunService"):IsServer() then

		system.assets = script.Assets

		system.modules = script.Modules

		loadModules(loadOrder, system.modules)

	elseif game:GetService("RunService"):IsClient() then

		system.client = script.Client

		loadModules(clientOrder, system.client)

	end

	for index, value in pairs(system.core:GetChildren()) do

		if value:IsA("ModuleScript") then

			system[value.Name] = require(value) -- no need to yeild, core modules are dependancies

		end

	end

end

function system.Initialize()

	system.warn("Initializing")

	setupEnviroment()

end

return system