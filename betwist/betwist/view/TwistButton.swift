import SwiftUI

struct TwistButton: View {
  @Binding var game: Game

  @Binding var animationAngle: Angle
  @Binding var axis: Axis

  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var twist: Twist

  var body: some View {
    Button {
      axis = twist.rotationAxis
      withAnimation(.easeInOut(duration: 1.5)) {
        animationAngle = twist.rotationAngle
      } completion: {
        animationAngle = Angle.zero
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
