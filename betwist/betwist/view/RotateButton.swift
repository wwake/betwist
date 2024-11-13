import SwiftUI

struct RotateButton: View {
  var clockwise: Bool
  @Binding var angle: Angle
  @Binding var game: Game

  var body: some View {
    Button {
      withAnimation {
        angle = clockwise ? .degrees(90) : .degrees(-90)
        game.rotate(clockwise: clockwise)
      } completion: {
        angle = .zero
      }
    } label: {
      Image(systemName: clockwise ? "arrow.clockwise" : "arrow.counterclockwise")
        .accessibilityLabel(Text(clockwise ? "Rotate Right" : "Rotate Left"))
    }.circled()
  }
}
