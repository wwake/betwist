import SwiftUI

struct TwistButton: View {
  @Binding var game: Game

  @Binding var boardAnimation: BoardAnimation

  @Binding var twist: Twist
  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var twistSpec: TwistButtonSpec

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1)) {
        boardAnimation = twistSpec.animation
      } completion: {
        boardAnimation = BoardAnimation.zero
        twist = twist.apply(twistSpec.twist)
        twistBoard = twistBoard.concatenating(twistSpec.boardTwist)
        untwistLetter = twistSpec.untwist.concatenating(untwistLetter)
      }
    } label: {
      twistSpec.label
        .labelStyle(.iconOnly)
    }.circled()
      .padding([.bottom], 6)
  }
}
