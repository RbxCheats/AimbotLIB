--[[
    Aimbot Module for Roblox
    Made for easy integration with any UI library
]]

local Aimbot = {}
Aimbot.__index = Aimbot

-- Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Default configuration
local DefaultConfig = {
    Enabled = false,
    VisibilityCheck = false,
    FOVEnabled = false,
    FOVSize = 100,
    Smoothness = 1,
    TargetPart = "head_only",
    HoldKey = Enum.UserInputType.MouseButton2, -- Right mouse button by default
    FOVColor = Color3.fromRGB(255, 123, 37),
    FOVThickness = 1,
    FOVTransparency = 1,
}

function Aimbot.new()
    local self = setmetatable({}, Aimbot)
    self.Config = {}
    self.KeyDown = false
    self.FOVCircle = nil
    self.Connection = nil
    
    -- Copy default config
    for k, v in pairs(DefaultConfig) do
        self.Config[k] = v
    end
    
    self:SetupInput()
    return self
end

function Aimbot:SetupInput()
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == self.Config.HoldKey then
            self.KeyDown = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == self.Config.HoldKey then
            self.KeyDown = false
        end
    end)
end

function Aimbot:CreateFOVCircle()
    if self.FOVCircle then
        self.FOVCircle:Remove()
    end
    
    self.FOVCircle = Drawing.new("Circle")
    self.FOVCircle.Thickness = self.Config.FOVThickness
    self.FOVCircle.Color = self.Config.FOVColor
    self.FOVCircle.Filled = false
    self.FOVCircle.Transparency = self.Config.FOVTransparency
    self.FOVCircle.Visible = self.Config.FOVEnabled
    self.FOVCircle.Radius = self.Config.FOVSize
    self.FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

function Aimbot:UpdateFOVCircle()
    if not self.FOVCircle then
        self:CreateFOVCircle()
    end
    
    self.FOVCircle.Visible = self.Config.FOVEnabled
    self.FOVCircle.Radius = self.Config.FOVSize
    self.FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    self.FOVCircle.Color = self.Config.FOVColor
    self.FOVCircle.Thickness = self.Config.FOVThickness
    self.FOVCircle.Transparency = self.Config.FOVTransparency
end

function Aimbot:IsVisible(part)
    if not self.Config.VisibilityCheck then 
        return true 
    end
    
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {
        LocalPlayer.Character, 
        workspace:FindFirstChild("Characters"), 
        workspace:FindFirstChild("CharacterMeshes"), 
        Camera
    }
    
    local raycast = workspace:Raycast(
        Camera.CFrame.Position, 
        (part.Position - Camera.CFrame.Position), 
        params
    )
    
    return raycast == nil
end

function Aimbot:GetClosestTarget()
    local target = nil
    local closestDistance = math.huge
    local meshes = workspace:FindFirstChild("CharacterMeshes")
    
    if not meshes then 
        return nil 
    end
    
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, character in pairs(meshes:GetChildren()) do
        if character.Name == LocalPlayer.Name then
            continue
        end
        
        local player = Players:FindFirstChild(character.Name)
        
        -- Skip if same team
        if player and player.Team == LocalPlayer.Team then
            continue
        end
        
        -- Get target part
        local targetPart = character:FindFirstChild(self.Config.TargetPart)
        if not targetPart then
            targetPart = character:FindFirstChild("head_only")
        end
        
        if not targetPart or targetPart.Transparency >= 0.9 then
            continue
        end
        
        if not self:IsVisible(targetPart) then
            continue
        end
        
        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
        
        if not onScreen then
            continue
        end
        
        local distance = (Vector2.new(screenPos.X, screenPos.Y) - centerScreen).Magnitude
        
        if self.Config.FOVEnabled and distance > self.Config.FOVSize then
            continue
        end
        
        if distance < closestDistance then
            closestDistance = distance
            target = targetPart
        end
    end
    
    return target
end

function Aimbot:DoAimbot()
    if not self.Config.Enabled or not self.KeyDown then
        return
    end
    
    local target = self:GetClosestTarget()
    
    if not target then
        return
    end
    
    local screenPos = Camera:WorldToViewportPoint(target.Position)
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    local deltaX = (screenPos.X - centerScreen.X) / self.Config.Smoothness
    local deltaY = (screenPos.Y - centerScreen.Y) / self.Config.Smoothness
    
    mousemoverel(deltaX, deltaY)
end

function Aimbot:Start()
    if self.Connection then
        return
    end
    
    self.Connection = RunService.RenderStepped:Connect(function()
        self:UpdateFOVCircle()
        self:DoAimbot()
    end)
end

function Aimbot:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
    
    if self.FOVCircle then
        self.FOVCircle:Remove()
        self.FOVCircle = nil
    end
end

-- UI Integration Methods
function Aimbot:CreateUIElements(parent, section)
    -- Toggle: Enable Aimbot
    section:AddToggle({
        Label = "Enable Aimbot", 
        Default = self.Config.Enabled, 
        Callback = function(state) 
            self.Config.Enabled = state 
            if state then 
                self:Start() 
            else 
                self:Stop() 
            end
        end
    })
    
    -- Toggle: Visibility Check
    section:AddToggle({
        Label = "Visibility Check", 
        Default = self.Config.VisibilityCheck, 
        Callback = function(state) 
            self.Config.VisibilityCheck = state 
        end
    })
    
    -- Dropdown: Target Part
    section:AddDropdown({
        Label = "Target Part", 
        Items = {"head_only", "helmet", "shirt", "pants", "HumanoidRootPart"}, 
        Default = self.Config.TargetPart, 
        Callback = function(v) 
            self.Config.TargetPart = v 
        end
    })
    
    -- Toggle: Enable FOV
    section:AddToggle({
        Label = "Enable FOV Circle", 
        Default = self.Config.FOVEnabled, 
        Callback = function(state) 
            self.Config.FOVEnabled = state 
        end
    })
    
    -- Slider: FOV Size
    section:AddSlider({
        Label = "FOV Size", 
        Min = 0, 
        Max = 800, 
        Default = self.Config.FOVSize, 
        Step = 1, 
        Callback = function(value) 
            self.Config.FOVSize = value 
        end
    })
    
    -- Slider: Smoothness
    section:AddSlider({
        Label = "Smoothness", 
        Min = 1, 
        Max = 20, 
        Default = self.Config.Smoothness, 
        Step = 1, 
        Callback = function(value) 
            self.Config.Smoothness = value 
        end
    })
    
    -- Color Picker: FOV Color
    section:AddColorPicker({
        Label = "FOV Color", 
        Default = self.Config.FOVColor, 
        Callback = function(color) 
            self.Config.FOVColor = color 
        end
    })
end

function Aimbot:SetConfig(newConfig)
    for k, v in pairs(newConfig) do
        if self.Config[k] ~= nil then
            self.Config[k] = v
        end
    end
end

function Aimbot:GetConfig()
    return self.Config
end

return Aimbot
