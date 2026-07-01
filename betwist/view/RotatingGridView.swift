import model
import SwiftUI

struct RotatingGridView: View {
  static var cellSize = 50.0

  @State private var boardAnimation = BoardAnimation.zero
  @State private var animationAngle = Angle.zero
  @State private var animationAxis = Axis(x: 0.0, y: 0.0, z: 0.0)

  @State private var twist = Twist()

  var game: Game

  var handleSelection: (Location) -> Void
  var width: CGFloat
  var height: CGFloat

  var body: some View {
    VStack {
      TwistButtons(
        boardAnimation: $boardAnimation,
        twist: $twist,
      )

      InfiniteGrid(
        game: game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardAnimation: boardAnimation,
        twist: $twist,
      )
      .frame(width: width, height: height)
      .contentShape(Rectangle())
      .clipped()
      .rotation3DEffect(boardAnimation.angle, axis: boardAnimation.axis)
    }
    .onChange(of: game.mode) {
      if game.mode == .play {
        boardAnimation = BoardAnimation.zero
        twist = Twist()
      }
    }
  }
}
