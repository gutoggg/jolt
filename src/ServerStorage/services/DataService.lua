--Author: gutoggg
--Date: 16/10/2023

local utils = require(game:GetService("ReplicatedStorage"):WaitForChild("utils"))
local serverClasses = utils.Services.ServerStorage:WaitForChild("classes")

--// DEPENDENCIES
local Service = require(serverClasses:WaitForChild("Service"))

local DataService = {
    Name = "DataService",
    Client = {
        "TestSignal"
    }
}

DataService.__index = DataService

function DataService:Init()
    DataService = Service.new(self)
end

function DataService:Start()
end

--// CLIENT ENDPOINTS METHODS
function DataService.Client:TestFunction(player)
    print(player)
end

return DataService