import SwiftUI

struct RotatingGridView: View {
  static var cellSize = 50.0

  @State private var twistBoard: CGAffineTransform = CGAffineTransformIdentity
  @State private var twistLetter: CGAffineTransform = CGAffineTransformIdentity

  @State private var animationAngle = Angle.zero
  @State private var animationAxis = Axis(x: 0.0, y: 0.0, z: 0.0)

  @Binding var game: Game
  var handleSelection: (Location) -> Void
  var width: CGFloat

  var body: some View {
    VStack {
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

      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width,
        animationAngle: animationAngle,
        axis: animationAxis,
        twistBoard: twistBoard,
        twistLetter: twistLetter
      )
      .rotation3DEffect(animationAngle, axis: animationAxis)
    }
    .frame(width: width)
    .zIndex(1)
  }
}
