import SwiftUI

struct TwistButton: View {
  @Binding var game: Game

  @Binding var animationAngle: Angle
  @Binding var axis: Axis
  @Binding var boardAnimation: BoardAnimation

  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var twist: Twist

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1)) {
        axis = twist.rotationAxis
        animationAngle = twist.rotationAngle
        boardAnimation = twist.animation
      } completion: {
        axis = Axis(x: 0, y: 0, z: 0)
        animationAngle = Angle.zero
        boardAnimation = BoardAnimation.zero
        twistBoard = twistBoard.concatenating(twist.twist)
        untwistLetter = twist.untwist.concatenating(untwistLetter)
      }
    } label: {
      twist.label
        .labelStyle(.iconOnly)
    }.circled()
      .padding([.bottom], 6)
  }
}
