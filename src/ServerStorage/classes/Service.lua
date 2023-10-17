--Author: gutoggg
--Date: 16/10/2023

export type ServiceTable = {
    Client : {
        string | () -> any
    },
    Name : string
}

--// CONSTANTS
local ROOT_REMOTE_FOLDER_NAME = "remotes"

local utils = require(game:GetService("ReplicatedStorage"):WaitForChild("utils"))
local packages = utils.Services.ReplicatedStorage.packages

--// DEPENDENCIES
local comm = require(packages:WaitForChild("comm"))
local serverComm = comm.ServerComm

--// CLASS
local Service = {}
Service.__index = Service

function Service.new(serviceTable : ServiceTable)
    local self = setmetatable({}, Service)

    local rootRemoteFolder = utils.Services.ReplicatedStorage:FindFirstChild(ROOT_REMOTE_FOLDER_NAME)
    if not rootRemoteFolder then
        local newRemoteFolder = Instance.new("Folder", utils.Services.ReplicatedStorage)
        newRemoteFolder.Name = ROOT_REMOTE_FOLDER_NAME
        rootRemoteFolder = newRemoteFolder
    end

    local serviceComm = serverComm.new(rootRemoteFolder, serviceTable.Name)
    local serviceRemoteTable = {}
    for endpointIndex, clientEndpointItem in serviceTable.Client do
        if type(clientEndpointItem) == "string" then
           local remoteEvent = serviceComm:CreateSignal(clientEndpointItem)
           serviceRemoteTable[clientEndpointItem] = remoteEvent
        elseif type(clientEndpointItem) == "function" then
           local remoteFunction =  serviceComm:BindFunction(endpointIndex, clientEndpointItem)
           serviceRemoteTable[endpointIndex] = remoteFunction
        end
    end

    serviceTable.Client = serviceRemoteTable
    serviceTable.Init = nil
    return self
end

function Service:IsService(service)
    return Service == getmetatable(service)
end

return Service