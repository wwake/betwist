import SwiftUI

struct TwistButton: View {
  @Binding var boardAnimation: BoardAnimation

  @Binding var twist: Twist

  var twistSpec: TwistButtonSpec

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1)) {
        boardAnimation = twistSpec.animation
      } completion: {
        boardAnimation = BoardAnimation.zero
        twist = twist.apply(twistSpec.twist)
      }
    } label: {
      twistSpec.label
        .labelStyle(.iconOnly)
    }.circled()
      .padding([.bottom], 6)
  }
}
