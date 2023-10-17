--Author: gutoggg
--Date: 16/10/2023

export type ServiceTable = {
    Client : {
        string | () -> any
    },
    Name : string
}

--// CONSTANTS
local REMOTE_FOLDER_NAME = "remotes"

local utils = require(game:GetService("ReplicatedStorage"):WaitForChild("utils"))
local packages = utils.Services.ReplicatedStorage.packages
local remoteFolder = utils.Services.ReplicatedStorage:FindFirstChild(REMOTE_FOLDER_NAME)

if not remoteFolder then
    local newRemoteFolder = Instance.new("Folder", utils.Services.ReplicatedStorage)
    newRemoteFolder.Name = REMOTE_FOLDER_NAME
    remoteFolder = newRemoteFolder
end

--// DEPENDENCIES
local comm = require(packages:WaitForChild("comm"))
local serverComm = comm.ServerComm

--// CLASS
local Service = {}
Service.__index = Service

function Service.new(serviceTable : ServiceTable)
    local self = setmetatable({}, Service)

    local newServiceComm = serverComm.new(remoteFolder, serviceTable.Name)
    for endpointIndex, clientEndpointItem in serviceTable.Client do
        if type(clientEndpointItem) == "string" then
            newServiceComm:CreateSignal(clientEndpointItem)
        elseif type(clientEndpointItem) == "function" then
            newServiceComm:BindFunction(endpointIndex, clientEndpointItem)
        end
    end

    return self
end

return Service