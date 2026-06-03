import SwiftUI

struct TwistButton: View {
  @Binding var game: Game

  @Binding var boardAnimation: BoardAnimation

  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var twist: Twist

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1)) {
        boardAnimation = twist.animation
      } completion: {
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
