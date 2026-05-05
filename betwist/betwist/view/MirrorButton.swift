import SwiftUI

struct MirrorButton: View {
  var iconName: String
  var label: String

  @Binding var game: Game
  @Binding var yAnimationAngle: Angle
  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform
  var width: CGFloat
  var cellSize: CGFloat

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1.5)) {
        yAnimationAngle = (yAnimationAngle + Angle(degrees: 180)).normalized
      } completion: {
        yAnimationAngle = Angle.zero
        twistBoard = twistBoard.concatenating(
          CGAffineTransformMakeScale(-1, 1)
            .concatenating(
              CGAffineTransformMakeTranslation(CGFloat(game.size) * cellSize, 0)
            )
          //           .concatenating(CGAffineTransformMakeTranslation(3.0 * cellWidth, 0))  // ?? why 3.0?
        )
        untwistLetter =
          CGAffineTransformMakeTranslation(-cellSize, 0)
          .concatenating(CGAffineTransformMakeScale(-1, 1))
          .concatenating(untwistLetter)
      }
    } label: {
      Image(systemName: iconName)
        .accessibilityLabel(Text(label))
    }.circled()
      .padding([.bottom], 6)
  }
}

#Preview {
  MirrorButton(
    iconName: "",
    label: "Mirror Horizontally",
    game: .constant(Game(2, ["A", "D", "O", "N"])),
    yAnimationAngle: .constant(Angle.zero),
    twistBoard: .constant(CGAffineTransformIdentity),
    untwistLetter: .constant(CGAffineTransformIdentity),
    width: 400,
    cellSize: 50
  )
}
