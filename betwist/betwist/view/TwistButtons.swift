import SwiftUI

struct TwistButtons: View {
  @Binding var game: Game

  @Binding var twistBoard: CGAffineTransform
  @Binding var twistLetter: CGAffineTransform

  @Binding var boardAnimation: BoardAnimation

  var body: some View {
    HStack {
      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.rotateLeft,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.mirrorHorizontally,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twist: Twist.mirrorVertically,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
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
