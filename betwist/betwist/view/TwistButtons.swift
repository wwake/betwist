import SwiftUI

struct TwistButtons: View {
  @Binding var game: Game

  @Binding var twistBoard: CGAffineTransform
  @Binding var twistLetter: CGAffineTransform

  @Binding var animationAngle: Angle
  @Binding var animationAxis: Axis

  var body: some View {
    HStack {
      TwistButton(
        game: $game,
        animationAngle: $animationAngle,
        axis: $animationAxis,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.rotateLeft,
      )

      TwistButton(
        game: $game,
        animationAngle: $animationAngle,
        axis: $animationAxis,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.mirrorHorizontally,
      )

      TwistButton(
        game: $game,
        animationAngle: $animationAngle,
        axis: $animationAxis,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.mirrorVertically,
      )

      TwistButton(
        game: $game,
        animationAngle: $animationAngle,
        axis: $animationAxis,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.rotateRight,
      )
    }
    .padding(.top, 5)
    .padding([.leading, .trailing], 8)
    .background(Capsule().fill(.thinMaterial))
  }
}
