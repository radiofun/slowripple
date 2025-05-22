//
//  Metal.metal
//  SwiftMay21
//
//  Created by Minsang Choi on 5/21/25.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

float random(float2 st) {
    return fract(sin(dot(st.xy, float2(12.9898, 78.233))) * 43758.5453123);
}


float value_noise(float2 st) {
    float2 i = floor(st);
    float2 f = fract(st);

    float a = random(i);
    float b = random(i + float2(1.0, 0.0));
    float c = random(i + float2(0.0, 1.0));
    float d = random(i + float2(1.0, 1.0));


    float2 u = f * f * f * (f * (f * 6.0 - 15.0) + 10.0);


    return mix(mix(a, b, u.x),
               mix(c, d, u.x), u.y);
}


[[ stitchable ]] half4 fbp(float2 pos, SwiftUI::Layer l, float4 boundingBox, float2 dragp, float time, float noise, float strength) {
    
    float2 size = float2(boundingBox[2],boundingBox[3]);
    float2 uv = pos / size;
    float2 c = dragp / size;
    
    
    float noiseScale = noise;
    float rippleFrequency = 16.0;
    float rippleSpeed = 3.0;
    float noisePerturbation = strength;
    float displacementStrength = 0.3;

    float baseNoise = value_noise(uv * noiseScale);

     float2 rippleCenter = c; // Moving center

    float dist = distance(uv, rippleCenter);
    float rippleWave = sin(
        dist * rippleFrequency        // Wavefronts based on distance
        - time * rippleSpeed          // Animation over time
        + baseNoise * noisePerturbation // Noise perturbs the phase
    );
    float2 direction = normalize(uv - rippleCenter + 1e-5);
    float2 displacement = direction * rippleWave * displacementStrength;
    float2 displacedUv = uv + displacement;

    float finalPattern = value_noise(displacedUv * noiseScale * 1.2 + float2(time * 0.1, 0.0)); // Slightly different scale/animation for the sampled pattern
    float shading = smoothstep(0.0, 0.8, rippleWave) * 0.5 + 0.5;
    
    
    float2 newpos = uv;
    newpos *= finalPattern * shading;
    half4 color = l.sample(newpos * size);
    
    return color;
}
