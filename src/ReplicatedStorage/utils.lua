--Author: gutoggg
--Date: 16/10/2023

local utils = {}

utils.Services = {}
utils.Math = {}

-- // Services
utils.Services.RunService = game:GetService("RunService")
utils.Services.CollectionService = game:GetService("CollectionService")
utils.Services.Debris = game:GetService("Debris")
utils.Services.ContextActionService = game:GetService("ContextActionService")
utils.Services.ServerScriptService = game:GetService("ServerScriptService")
utils.Services.ServerStorage = game:GetService("ServerStorage")
utils.Services.Players = game:GetService("Players")
utils.Services.ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Math
utils.Math.V1 = Vector3.one
utils.Math.V0 = Vector3.zero
utils.Math.V100 = Vector3.xAxis
utils.Math.V010 = Vector3.yAxis
utils.Math.V001 = Vector3.zAxis
utils.Math.V110 = utils.Math.V100 + utils.Math.V010
utils.Math.V011 = utils.Math.V001 + utils.Math.V010
utils.Math.V101 = utils.Math.V100 + utils.Math.V001
utils.Math.CF = CFrame.new()

return utils