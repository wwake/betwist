import SwiftUI

struct TwistButtons: View {
  @Binding var game: Game

  @Binding var boardAnimation: BoardAnimation

  @Binding var twist: Twist

  var body: some View {
    HStack {
      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.rotateLeft,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.mirrorHorizontally,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.mirrorVertically,
      )

      TwistButton(
        game: $game,
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.rotateRight,
      )
    }
    .padding(.top, 5)
    .padding([.leading, .trailing], 8)
    .background(Capsule().fill(.thinMaterial))
  }
}
