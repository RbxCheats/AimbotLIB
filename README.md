# Roblox Aimbot Module

A standalone, easy-to-integrate aimbot module originally extracted from Riotfall script. Designed to work with any UI library. Features a fully functional FOV circle, visibility checks, smooth aiming, and more.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Integration Examples](#integration-examples)
- [API Reference](#api-reference)
- [Configuration Options](#configuration-options)
- [UI Library Compatibility](#ui-library-compatibility)
- [Requirements](#requirements)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)
- [License](#license)

## Features

- ✅ **Silent Aimbot** - Smooth mouse movement to target
- ✅ **FOV Circle** - Customizable size, color, and transparency
- ✅ **Visibility Check** - Raycast-based obstruction detection
- ✅ **Configurable Target Parts** - Head, helmet, shirt, pants, HumanoidRootPart
- ✅ **Team Check** - Automatically ignores teammates
- ✅ **Hold-to-Aim** - Configurable activation key (default: right mouse button)
- ✅ **Easy Integration** - Works with any UI library
- ✅ **Auto-Generated UI** - One-line UI element creation
- ✅ **Lightweight** - Minimal performance impact

## Installation

### Method 1: Raw GitHub URL (Recommended)
```lua
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/aimbot_module.lua"))()
Method 2: Local Script
Download aimbot_module.lua

Place it in your script's folder

Load it locally:

lua
local Aimbot = loadfile("aimbot_module.lua")()
Method 3: Direct Copy
Copy the entire module code into your script.

Quick Start
Minimal Setup (No UI)
lua
-- Create aimbot instance
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/aimbot_module.lua"))()
local MyAimbot = Aimbot.new()

-- Configure (optional)
MyAimbot:SetConfig({
    Enabled = true,
    Smoothness = 3,
    FOVSize = 150,
    FOVEnabled = true
})

-- Start the aimbot
MyAimbot:Start()
With UI Integration
lua
-- Load your UI library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxCheats/UiLib2/main/Library.lua"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/aimbot_module.lua"))()

-- Create instances
local MyAimbot = Aimbot.new()
local Window = Library:CreateWindow({
    Title = "My Script",
    Subtitle = "With Aimbot",
    Width = 780,
    Height = 520
})

-- Create tab and section
local AimbotTab = Window:CreateTab("Aimbot")
local AimbotSection = AimbotTab:CreateSection("Aimbot Settings", "left")

-- Auto-generate all UI elements (toggles, sliders, dropdowns, color picker)
MyAimbot:CreateUIElements(Window, AimbotSection)

-- Start the aimbot (UI can also control this)
MyAimbot:Start()
Integration Examples
Example 1: Using with Different UI Libraries
Kavo UI Library:

lua
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/xxx"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/aimbot_module.lua"))()

local MyAimbot = Aimbot.new()
local Window = Library:CreateWindow("My Script")
local AimbotTab = Window:CreateTab("Aimbot")

-- Manual UI creation (if auto-generate doesn't match your library)
local Toggle = AimbotTab:CreateToggle({
    Name = "Enable Aimbot",
    CurrentValue = false,
    Callback = function(state)
        MyAimbot.Config.Enabled = state
        if state then MyAimbot:Start() else MyAimbot:Stop() end
    end
})

local Slider = AimbotTab:CreateSlider({
    Name = "Smoothness",
    Min = 1,
    Max = 20,
    Default = 1,
    Callback = function(value)
        MyAimbot.Config.Smoothness = value
    end
})
Simple UI Library (Custom):

lua
local MyAimbot = Aimbot.new()

-- Create simple GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")

-- Manual configuration via GUI buttons
local ToggleButton = Instance.new("TextButton")
ToggleButton.Text = "Toggle Aimbot"
ToggleButton.MouseButton1Click:Connect(function()
    MyAimbot.Config.Enabled = not MyAimbot.Config.Enabled
    if MyAimbot.Config.Enabled then
        MyAimbot:Start()
        ToggleButton.Text = "Aimbot: ON"
    else
        MyAimbot:Stop()
        ToggleButton.Text = "Aimbot: OFF"
    end
end)
Example 2: Advanced Configuration
lua
local MyAimbot = Aimbot.new()

-- Custom keybind (Middle mouse button)
MyAimbot:SetConfig({
    Enabled = true,
    HoldKey = Enum.UserInputType.MouseButton3,
    VisibilityCheck = true,
    FOVEnabled = true,
    FOVSize = 200,
    FOVColor = Color3.fromRGB(0, 255, 0), -- Green FOV
    Smoothness = 5,
    TargetPart = "HumanoidRootPart"
})

MyAimbot:Start()

-- Change settings on the fly
wait(5)
MyAimbot.Config.FOVSize = 300  -- Increase FOV
MyAimbot.Config.Smoothness = 10 -- Make it smoother
Example 3: Multiple Aimbot Instances (Not Recommended)
lua
-- You can create multiple instances if needed
local Aimbot1 = Aimbot.new()
local Aimbot2 = Aimbot.new()

-- Different configurations for different scenarios
Aimbot1:SetConfig({ TargetPart = "head_only", Smoothness = 1 })
Aimbot2:SetConfig({ TargetPart = "HumanoidRootPart", Smoothness = 10 })

-- Only run one at a time
Aimbot1:Start()
-- Aimbot2:Start() -- Don't run both simultaneously
API Reference
Constructor
Method	Description	Returns
Aimbot.new()	Creates a new aimbot instance	Aimbot object
Methods
Method	Parameters	Description
:Start()	None	Starts the aimbot loop and FOV circle rendering
:Stop()	None	Stops the aimbot loop and removes FOV circle
:SetConfig(table)	Config table with settings	Updates aimbot configuration
:GetConfig()	None	Returns current configuration table
:CreateUIElements(parent, section)	Parent window, section object	Auto-generates UI elements for the aimbot
:UpdateFOVCircle()	None	Manually updates FOV circle position/size
:GetClosestTarget()	None	Returns the current best target (for debugging)
Internal Methods (Advanced)
Method	Description
:SetupInput()	Sets up input detection for hold key
:CreateFOVCircle()	Creates the FOV circle drawing object
:IsVisible(part)	Checks if a part is visible via raycast
:DoAimbot()	Performs the aimbot calculation and movement
Configuration Options
Complete Configuration Table
lua
{
    -- Master Settings
    Enabled = false,              -- Master aimbot toggle
    
    -- Target Settings
    TargetPart = "head_only",    -- Body part to aim at
    VisibilityCheck = false,      -- Check if target is visible
    HoldKey = Enum.UserInputType.MouseButton2,  -- Activation key
    
    -- FOV Settings
    FOVEnabled = false,           -- Show FOV circle
    FOVSize = 100,                -- Radius of FOV circle (pixels)
    FOVColor = Color3.fromRGB(255, 123, 37),  -- Orange color
    FOVThickness = 1,             -- Circle line thickness
    FOVTransparency = 1,          -- Circle transparency (0-1)
    
    -- Aim Settings
    Smoothness = 1,               -- Aim smoothing (1-20, lower = faster)
}
Option Details
Option	Type	Range/Values	Default	Description
Enabled	boolean	true/false	false	Master toggle for aimbot functionality
TargetPart	string	See list below	"head_only"	Which body part to lock onto
VisibilityCheck	boolean	true/false	false	Only aim if target is not behind walls
HoldKey	Enum	See key list	MouseButton2	Key that must be held for aiming
FOVEnabled	boolean	true/false	false	Display FOV circle on screen
FOVSize	number	0-800	100	Radius of FOV circle in pixels
FOVColor	Color3	Any RGB color	Orange	Color of the FOV circle
FOVThickness	number	1-10	1	Thickness of FOV circle border
FOVTransparency	number	0-1	1	Circle transparency (1 = solid, 0 = invisible)
Smoothness	number	1-20	1	Mouse movement smoothing (higher = smoother)
Supported Target Parts
Target Part	Description
"head_only"	Head hitbox (most common)
"helmet"	Helmet/head accessory
"shirt"	Torso area
"pants"	Legs area
"HumanoidRootPart"	Center of character
Supported Hold Keys
Enum Value	Description
Enum.UserInputType.MouseButton1	Left mouse button
Enum.UserInputType.MouseButton2	Right mouse button (default)
Enum.UserInputType.MouseButton3	Middle mouse button
Enum.KeyCode.LeftShift	Left Shift key
Enum.KeyCode.LeftControl	Left Control key
Enum.KeyCode.Q	Q key
Enum.KeyCode.E	E key
Any Enum.KeyCode value	Any keyboard key
UI Library Compatibility
The module's CreateUIElements method expects your UI library to have these methods:

Required UI Methods
lua
section:AddToggle({
    Label = "string",      -- Display text
    Default = boolean,     -- Initial state
    Callback = function(state) end  -- Called when toggled
})

section:AddSlider({
    Label = "string",      -- Display text
    Min = number,          -- Minimum value
    Max = number,          -- Maximum value
    Default = number,      -- Initial value
    Step = number,         -- Increment step
    Callback = function(value) end  -- Called when changed
})

section:AddDropdown({
    Label = "string",      -- Display text
    Items = table,         -- List of options
    Default = string,      -- Initial selection
    Callback = function(selected) end  -- Called when selected
})

section:AddColorPicker({
    Label = "string",      -- Display text
    Default = Color3,      -- Initial color
    Callback = function(color) end  -- Called when color changes
})
```
Compatible UI Libraries
✅ RbxCheats UI Library

✅ Kavo UI Library

✅ Linoria UI Library

✅ Aero UI Library

✅ Any custom library with similar methods

Manual UI Creation (If library is incompatible)
If your UI library doesn't match the required format, you can manually create the UI elements:

lua
-- Example with any UI library
local MyAimbot = Aimbot.new()

-- Manually create toggle
MyButton.OnClick = function()
    MyAimbot.Config.Enabled = not MyAimbot.Config.Enabled
    if MyAimbot.Config.Enabled then 
        MyAimbot:Start() 
    else 
        MyAimbot:Stop() 
    end
end

-- Manually create slider
MySlider.OnChanged = function(value)
    MyAimbot.Config.Smoothness = value
end

-- Manually create dropdown
MyDropdown.OnSelected = function(option)
    MyAimbot.Config.TargetPart = option
end
Requirements
Roblox Environment
Roblox executor with Drawing library support (Synapse X, Krnl, ScriptWare, etc.)

Workspace must contain CharacterMeshes folder structure

Mouse movement support (mousemoverel function)

Game Structure
The aimbot expects characters to be located in:

text
workspace
└── CharacterMeshes
    ├── [PlayerName1]
    │   ├── head_only
    │   ├── helmet (optional)
    │   └── ...
    └── [PlayerName2]
        └── ...
Executor Compatibility
Executor	Drawing Support	mousemoverel Support
Synapse X	✅ Yes	✅ Yes
Krnl	✅ Yes	✅ Yes
ScriptWare	✅ Yes	✅ Yes
Electron	✅ Yes	✅ Yes
Oxygen U	✅ Yes	✅ Yes
Fluxus	⚠️ Limited	⚠️ Limited
Troubleshooting
Common Issues and Solutions
❌ Aimbot not working at all
Solutions:

Check if CharacterMeshes exists in workspace

Verify you're holding the aim key (right click by default)

Ensure Enabled is set to true

Check if target parts exist (look for "head_only" in characters)

Make sure you're not on the same team as enemies

❌ FOV circle not showing
Solutions:

Enable FOVEnabled in config

Verify your executor supports Drawing library

Check if FOVCircle is being created (run MyAimbot:CreateFOVCircle() manually)

Ensure FOVTransparency isn't set to 0 (0 = invisible)

❌ Aimbot too snappy or too slow
Solutions:

Increase Smoothness value for smoother movement (10-20)

Decrease Smoothness value for faster aiming (1-3)

❌ Aiming at wrong body part
Solutions:

Change TargetPart to the correct bone name

Check available parts using:

lua
local meshes = workspace:FindFirstChild("CharacterMeshes")
if meshes then
    local char = meshes:GetChildren()[1]
    for _, part in pairs(char:GetChildren()) do
        print(part.Name) -- Lists all available parts
    end
end
❌ Aiming through walls
Solutions:

Enable VisibilityCheck to prevent wall shooting

Note: This may reduce performance slightly

❌ Performance issues
Solutions:

Disable VisibilityCheck if not needed

Reduce FOV circle updates (but not recommended)

Make sure you're not running multiple aimbot instances

❌ "mousemoverel is not a function" error
Solutions:

Your executor doesn't support mouse movement

Use a different executor (Synapse X, Krnl, etc.)

❌ FOV circle not centered
Solutions:

The circle auto-centers based on camera viewport

If camera changes, it will update automatically

Manual update: MyAimbot:UpdateFOVCircle()

Debugging
Add this debug code to check if the aimbot is detecting targets:

lua
-- Debug function to see what the aimbot sees
function DebugAimbot()
    local MyAimbot = Aimbot.new()
    
    -- Override GetClosestTarget for debugging
    local original = MyAimbot.GetClosestTarget
    MyAimbot.GetClosestTarget = function(...)
        local target = original(...)
        if target then
            print("Target found:", target.Name, "at position:", target.Position)
        else
            print("No target found")
        end
        return target
    end
    
    MyAimbot:Start()
end

-- Run debug
DebugAimbot()
Getting Help
If you encounter issues not listed here:

Check your executor's console for errors

Verify all requirements are met

Test with a fresh Roblox instance

Contact support with your error message

Credits
Original Script: Riotfall (RbxCheats.xyz)

Extracted and Modularized: Community contribution

Testing: Various Roblox exploit communities

Version History
v1.0.0
Initial release

Full aimbot functionality

FOV circle support

UI integration methods

Complete documentation
