import SwiftUI

struct TwistButtons: View {
  @Binding var boardAnimation: BoardAnimation

  @Binding var twist: Twist

  var body: some View {
    HStack {
      TwistButton(
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.rotateLeft,
      )

      TwistButton(
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.mirrorHorizontally,
      )

      TwistButton(
        boardAnimation: $boardAnimation,
        twist: $twist,
        twistSpec: TwistButtonSpec.mirrorVertically,
      )

      TwistButton(
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
