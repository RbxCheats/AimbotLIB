# Targeting Module

A lightweight, configurable targeting and UI-integration module for Roblox projects.

## Overview

This module provides a reusable framework for selecting on-screen targets, rendering an optional FOV indicator, and connecting settings to a UI library.

It is designed for easy integration, simple configuration, and clear separation between targeting logic and interface controls.

## Features

- Configurable target selection.
- Optional visibility checking.
- Optional FOV circle rendering.
- Adjustable smoothing behavior.
- Hold-to-activate input support.
- UI helper methods for toggles, sliders, dropdowns, and color pickers.

## Requirements

- Roblox Studio.
- A compatible UI library.
- A local player context.

## Installation

1. Place the module in your project.
2. Require it from your client-side script.
3. Create an instance with `Aimbot.new()`.
4. Apply settings using `SetConfig()`.
5. Call `Start()` to begin updates.

## Configuration

| Setting | Type | Description |
|---|---:|---|
| `Enabled` | boolean | Enables the module. |
| `VisibilityCheck` | boolean | Requires a clear line of sight to the target. |
| `FOVEnabled` | boolean | Shows the FOV indicator. |
| `FOVSize` | number | Radius of the targeting area. |
| `Smoothness` | number | Controls how quickly the view moves. |
| `TargetPart` | string | Body part or marker used for targeting. |
| `HoldKey` | input | Input used to activate the module. |
| `FOVColor` | Color3 | Color of the FOV indicator. |
| `FOVThickness` | number | Outline thickness of the circle. |
| `FOVTransparency` | number | Transparency of the circle. |

## Example Usage

```lua
local Targeting = require(path.To.Module)
local module = Targeting.new()

module:SetConfig({
    Enabled = true,
    VisibilityCheck = true,
    FOVEnabled = true,
    FOVSize = 120,
    Smoothness = 8,
    TargetPart = "HumanoidRootPart",
})

module:Start()
```

## UI Integration

The module includes helper methods for building UI controls:
- Toggle controls for enable/disable options.
- Dropdowns for target selection.
- Sliders for numeric settings.
- Color picker support for visual customization.

## Lifecycle

- `Start()` begins the update loop.
- `Stop()` disconnects active updates and clears visuals.
- `GetConfig()` returns the current configuration.
- `SetConfig()` updates supported configuration fields.

## Notes

The module is intended for client-side projects where target selection and smoothing are part of a legitimate gameplay or training experience.

## License

Choose a license that matches your project requirements.
