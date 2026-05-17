## ✨ Features

- **Object-Oriented Programming (OOP):** Instantiate multiple decoupled instances safely via `Aimbot.new()`.
- **Custom UI Library Integration:** Built-in UI bindings dynamically generate switches, sliders, dropdowns, and color pickers.
- **Smart Target Selection:** Scans `workspace.CharacterMeshes`, automatically applies structural visibility checking (Raycasting), and factors in team validation.
- **Native FOV Rendering:** Utilizes the executor `Drawing` API to draw a scalable, customizable field-of-view peripheral element centering your viewport.
- **Natural Mouse Tracking:** Uses `mousemoverel` relative positioning offset calculations alongside smooth step interpolation.

---

## 🚀 Installation

Load the module via an external URL string directly within your code hub wrapper:

```lua
local AimbotModule = loadstring(game:HttpGet("[https://raw.githubusercontent.com/RbxCheats/AimbotLIB/main/aimbot_module.lua](https://raw.githubusercontent.com/RbxCheats/AimbotLIB/main/aimbot_module.lua)"))()
local AimbotInstance = AimbotModule.new()
⚙️ Configuration StructureThe active runtime values can be mapped directly onto the AimbotInstance.Config dictionary layer:PropertyTypeDefault ValueDescriptionEnabledbooleanfalseMaster runtime check to authorize crosshair tracking actions.VisibilityCheckbooleanfalseEnables Raycasting to ensure targets aren't obstructed.TargetPartstring"head_only"Primary string key tracked within character models.HoldKeyEnum.UserInputTypeMouseButton2Activates target lock while this user input is sustained.Smoothnessnumber1Input delta mouse divisor. Higher numbers slow cursor speed.FOVEnabledbooleanfalseToggles rendering state for the peripheral screen guide ring.FOVSizenumber100Vector scale bounds check for targeting exclusions.FOVColorColor3255, 123, 37RGB structural value applied onto the vector layer.FOVThicknessnumber1Stroke pixel width styling of the drawing overlay.FOVTransparencynumber1Opacity value applied across the drawing boundary.📋 API Implementation DocumentationAimbot.new()Instantiates a new structural instance of the aimbot framework class, clones base properties, and binds input hooks.Aimbot:Start()Initializes active updates by hooking target logic directly into RunService.RenderStepped.Aimbot:Stop()Safely disconnects rendering pipelines and clears any existing Drawing elements.Aimbot:SetConfig(newConfig)Accepts an updated dictionary to mutate current target options safely.LuaAimbotInstance:SetConfig({
    Smoothness = 5,
    TargetPart = "HumanoidRootPart"
})
Aimbot:GetConfig()Returns the existing configurations table map.💻 Integration ExamplesSimple Implementation WorkflowLualocal AimbotModule = loadstring(game:HttpGet("[https://raw.githubusercontent.com/RbxCheats/AimbotLIB/main/aimbot_module.lua](https://raw.githubusercontent.com/RbxCheats/AimbotLIB/main/aimbot_module.lua)"))()
local Aimbot = AimbotModule.new()

-- Configure active options
Aimbot.Config.Enabled = true
Aimbot.Config.VisibilityCheck = true
Aimbot.Config.FOVEnabled = true
Aimbot.Config.FOVSize = 150

-- Fire operational loop
Aimbot:Start()
UI Library Automated Binding ExampleYou can pass your UI script framework instances directly to let the library auto-build control interfaces natively:Lualocal AimbotModule = loadstring(game:HttpGet("[https://raw.githubusercontent.com/RbxCheats/AimbotLIB/main/aimbot_module.lua](https://raw.githubusercontent.com/RbxCheats/AimbotLIB/main/aimbot_module.lua)"))()
local AimbotInstance = AimbotModule.new()

-- Standard UI Library Generation Structure Example
local Window = UILibrary:CreateWindow("Cheat Hub")
local Tab = Window:CreateTab("Combat")
local Section = Tab:CreateSection("Aimbot Tweaks")

-- Pass UI parent components directly into the module helper
AimbotInstance:CreateUIElements(Tab, Section)
```
📜 LicenseDistributed under the terms of the MIT License agreement.
