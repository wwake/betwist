import SwiftUI

struct BoardAnimation {
  let angle: Angle
  let axis: Axis

  static let zero = BoardAnimation(Angle.zero, Axis(x: 0.0, y: 0.0, z: 0.0))

  init(_ angle: SwiftUICore.Angle, _ axis: Axis) {
    self.angle = angle
    self.axis = axis
  }

  var axisInverted: Axis {
    invert(axis)
  }
}

struct RotatingGridView: View {
  static var cellSize = 50.0

  @State private var twistBoard: CGAffineTransform = CGAffineTransformIdentity
  @State private var untwistLetter: CGAffineTransform = CGAffineTransformIdentity

  @State private var boardAnimation = BoardAnimation.zero
  @State private var animationAngle = Angle.zero
  @State private var animationAxis = Axis(x: 0.0, y: 0.0, z: 0.0)

  @Binding var game: Game
  var handleSelection: (Location) -> Void
  var width: CGFloat

  var body: some View {
    VStack {
      TwistButtons(
        game: $game,
        twistBoard: $twistBoard,
        twistLetter: $untwistLetter,
        animationAngle: $animationAngle,
        animationAxis: $animationAxis,
        boardAnimation: $boardAnimation,
      )

      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width,
        boardAnimation: boardAnimation,
        twistBoard: $twistBoard,
        untwistLetter: $untwistLetter
      )
      .frame(width: width, height: width)
      .clipped()
      .rotation3DEffect(animationAngle, axis: animationAxis)
    }
    .onChange(of: game.mode) {
      if game.mode == .play {
        twistBoard = CGAffineTransformIdentity
        untwistLetter = CGAffineTransformIdentity
        animationAngle = Angle.zero
        animationAxis = Axis(x: 0.0, y: 0.0, z: 0.0)
        boardAnimation = BoardAnimation.zero
      }
    }
  }
}
