import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ContentViewModel(hertzModel: HertzModel())

    @ObservedObject var workoutManager: WorkoutManager = .shared

    let dot = Color(red: 1, green: 0, blue: 0)

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    TickFace(model: model)
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.width
                        )
                        .mask(
                            Arc(
                                startAngle: .degrees(312),
                                endAngle: .degrees(47),
                                clockwise: true,
                                radiusOffset: 0
                            )
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [
                                            .clear,
                                            Color.gray.opacity(0.1),
                                            Color.gray.opacity(0.2),
                                            Color.gray.opacity(0.7),
                                            Color.gray.opacity(0.8),
                                            Color.gray.opacity(1),
                                            Color.gray.opacity(0.9),
                                            Color.gray.opacity(0.8),
                                            Color.gray.opacity(0.2),
                                            Color.gray.opacity(0.1),
                                            .clear,
                                        ]
                                    ),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .rotationEffect(model.currentAngle)
                        )

                    Dot(circleRadius: 6, fillColor: dot)
                        .rotationEffect(model.currentAngle)
                        .frame(
                            width: geometry.size.width - 38,
                            height: geometry.size.width - 12
                        )

                    if !model.isRunning {
                        Button {
                            model.start()
                        } label: {
                            Image(systemName: "arrowtriangle.right.circle")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.white)
                        .font(Font.system(size: 50, weight: .ultraLight, design: .default))
                        .transition(
                            AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                        )
                    } else {
                        VStack {
                            Text("\(model.heartRate, specifier: "%.1f") ♥")
                                .font(
                                    Font.system(
                                        size: 20,
                                        weight: .regular,
                                        design: .default
                                    ).monospacedDigit()
                                )
                            
                            Text("\(model.factor, specifier: "%.1f")")
                                .font(
                                    Font.system(
                                        size: 18,
                                        weight: .regular,
                                        design: .default
                                    ).monospacedDigit()
                                )
                        }
                        .transition(
                            AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                        )
                    }
                }
            }
            .background(
                Color(
                    red: 0,
                    green: 0,
                    blue: 0
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
