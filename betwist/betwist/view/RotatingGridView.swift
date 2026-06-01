import SwiftUI

struct BoardAnimation {
  let animationAngle: Angle
  let animationAxis: Axis

  static let zero = BoardAnimation(Angle.zero, Axis(x: 0.0, y: 0.0, z: 0.0))

  init(_ angle: SwiftUICore.Angle, _ axis: Axis) {
    self.animationAngle = angle
    self.animationAxis = axis
  }
}

struct RotatingGridView: View {
  static var cellSize = 50.0

  @State private var twistBoard: CGAffineTransform = CGAffineTransformIdentity
  @State private var untwistLetter: CGAffineTransform = CGAffineTransformIdentity

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
      )

      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width,
        animationAngle: animationAngle,
        axis: animationAxis,
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
      }
    }
  }
}
