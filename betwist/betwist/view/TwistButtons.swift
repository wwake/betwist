import SwiftUI

struct TwistButtons: View {
  @Binding var game: Game

  @Binding var boardAnimation: BoardAnimation

  @Binding var twist: Twist
  @Binding var twistBoard: CGAffineTransform
  @Binding var twistLetter: CGAffineTransform

  var body: some View {
    HStack {
      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twistSpec: TwistButtonSpec.rotateLeft,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twistSpec: TwistButtonSpec.mirrorHorizontally,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twistSpec: TwistButtonSpec.mirrorVertically,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistBoard: $twistBoard,
        untwistLetter: $twistLetter,
        twistSpec: TwistButtonSpec.rotateRight,
      )
    }
    .padding(.top, 5)
    .padding([.leading, .trailing], 8)
    .background(Capsule().fill(.thinMaterial))
  }
}
