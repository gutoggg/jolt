--Author: gutoggg
--Date: 16/10/2023

--// ROBLOX SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// UTILS IMPORT
local utils = require(ReplicatedStorage:WaitForChild("utils"))
local packages = utils.Services.ReplicatedStorage.packages

--// DEPENDENCIES
local signal = require(packages:WaitForChild("signal"))

--// CONSTANTS
local SERVICE_FOLDER = utils.Services.ServerStorage:WaitForChild("services")

local servicesToStart  = {
    "DataService"
}

local startAllServicesSignal = signal.new()

for i, serviceName in servicesToStart do
    local required = require(SERVICE_FOLDER:WaitForChild(serviceName))
    required:Init()

    startAllServicesSignal:Once(function()
        required:Start()
    end)
end

startAllServicesSignal:Fire()
