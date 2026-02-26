# slowripple

A SwiftUI + Metal ripple distortion effect driven by a slowly orbiting point. A gradient layer is warped in real time using noise-perturbed radial waves rendered entirely in a Metal shader.

## What it does

An animated ripple originates from a point that orbits the view continuously. The distortion is layered with value noise to break the perfect symmetry of the waves, producing an organic, slow-moving warp effect on a blurred gradient background.

## Features

- Real-time ripple displacement via a Metal `layerEffect` shader
- Value noise (quintic-interpolated) for organic wave perturbation
- Interactive sliders to adjust **time**, **noise scale**, and **strength** at runtime
- 120 fps timer-driven animation loop

## Tech Stack

- **SwiftUI** — view layout and live parameter sliders
- **Metal** — `stitchable` fragment shader (`fbp`) for ripple displacement
- **SwiftUI Shader API** — `layerEffect` to apply the Metal shader to a SwiftUI layer

## Requirements

- Xcode 15+
- iOS 17+ / macOS 14+ (requires SwiftUI shader API)

## How to Run

1. Open the `.swift` and `.metal` files in an Xcode project (or Swift Playground).
2. Add `SlowRipple()` as the root view.
3. Build and run on a simulator or device.
4. Use the sliders at the bottom to tweak noise, time speed, and ripple strength.
