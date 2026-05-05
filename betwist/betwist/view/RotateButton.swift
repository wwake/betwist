import SwiftUI

struct RotateButton: View {
  var clockwise: Bool
  @Binding var game: Game

  @Binding var zAnimationAngle: Angle
  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var cellWidth: CGFloat

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1.5)) {
        zAnimationAngle = clockwise ? .degrees(90) : .degrees(-90)
      } completion: {
        zAnimationAngle = Angle.zero
        twistBoard = twistBoard.concatenating(
          CGAffineTransformMakeRotation(clockwise ? .pi / 2.0 : -.pi / 2.0)
            .concatenating(
              CGAffineTransformMakeTranslation(
                clockwise ? CGFloat(game.size) * cellWidth : 0,
                clockwise ? 0 : CGFloat(game.size) * cellWidth
              )
            )
        )
        untwistLetter =
          CGAffineTransformMakeRotation(clockwise ? -.pi / 2.0 : .pi / 2.0)
          .concatenating(
            CGAffineTransformMakeTranslation(
              clockwise ? 0 : cellWidth,
              clockwise ? cellWidth : 0
            )
          )
          .concatenating(untwistLetter)
      }
    } label: {
      Image(
        systemName: clockwise ? "arrow.clockwise" : "arrow.counterclockwise"
      )
      .accessibilityLabel(Text(clockwise ? "Rotate Right" : "Rotate Left"))
    }.circled()
      .padding([.bottom], 6)
  }
}
