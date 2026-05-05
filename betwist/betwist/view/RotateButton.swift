import SwiftUI

struct RotateLeftButton: View {
  @Binding var game: Game

  @Binding var zAnimationAngle: Angle
  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var cellSize: CGFloat

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1.5)) {
        zAnimationAngle = .degrees(-90)
      } completion: {
        zAnimationAngle = Angle.zero
        twistBoard = twistBoard.concatenating(
          CGAffineTransformMakeRotation(-.pi / 2.0)
            .concatenating(
              CGAffineTransformMakeTranslation(
                0,
                CGFloat(game.size) * cellSize
              )
            )
        )
        untwistLetter =
          CGAffineTransformMakeRotation(.pi / 2.0)
          .concatenating(
            CGAffineTransformMakeTranslation(
              cellSize,
              0
            )
          )
          .concatenating(untwistLetter)
      }
    } label: {
      Image(systemName: "arrow.counterclockwise")
        .accessibilityLabel(Text("Rotate Left"))
    }.circled()
      .padding([.bottom], 6)
  }
}

struct RotateRightButton: View {
  @Binding var game: Game

  @Binding var zAnimationAngle: Angle
  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var cellSize: CGFloat

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1.5)) {
        zAnimationAngle = .degrees(90)
      } completion: {
        zAnimationAngle = Angle.zero
        twistBoard = twistBoard.concatenating(
          CGAffineTransformMakeRotation(.pi / 2.0)
            .concatenating(
              CGAffineTransformMakeTranslation(
                CGFloat(game.size) * cellSize,
                0
              )
            )
        )
        untwistLetter =
          CGAffineTransformMakeRotation(-.pi / 2.0)
          .concatenating(
            CGAffineTransformMakeTranslation(
              0,
              cellSize
            )
          )
          .concatenating(untwistLetter)
      }
    } label: {
      Image(
        systemName: "arrow.clockwise"
      )
      .accessibilityLabel(Text("Rotate Right"))
    }.circled()
      .padding([.bottom], 6)
  }
}
