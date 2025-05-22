
import SwiftUI

struct SlowRipple: View {
    @State private var time : CGFloat = 0.1
    @State private var noise : CGFloat = 4
    @State private var strength : CGFloat = 1
    @State private var dragp : CGPoint = .zero

    private let timer = Timer.publish(every: 1/120,
                                     on: .main,
                                     in: .common).autoconnect()
    @State private var angle : CGFloat = 0

    
    var body: some View {
        ZStack{
            ZStack{
                LinearGradient(colors: [.brown.mix(with: .black, by: 0.8), .orange, .white], startPoint: .top, endPoint: .bottomTrailing)
                    .frame(width:360,height:300)
                    .blur(radius: 20)
                    .layerEffect(ShaderLibrary.fbp(.boundingRect,.float2(dragp),.float(time), .float(noise), .float(strength)), maxSampleOffset: CGSize(width:200,height: 200))

                Color.black.opacity(0.3)
                VStack{
                    Spacer()
                    HStack{
                        Text("time : \(time, specifier: "%.2f") /")
                        Text("noise : \(noise, specifier: "%.2f") /")
                        Text("strength : \(strength, specifier: "%.2f")")
                        Spacer()
                    }
                    
                }
                .frame(width:330, height: 260)
                .foregroundStyle(.white)
                .font(.system(size: 10, design: .monospaced))
                
            }
            .frame(width:360,height:300)
            .cornerRadius(12)
            .shadow(radius: 8)

            VStack{
                Spacer()
                Slider(value: $time, in:0...1)
                Slider(value: $noise, in:0...8)
                Slider(value: $strength, in:0...10)

            }
            .tint(.primary)
            .padding()
            .onReceive(timer) { _ in
                angle += 0.001

                dragp = CGPoint(
                    x: 5 + cos(angle) * 300,
                    y: 5 + sin(angle) * 300
                )

            }


        }

    }
}
