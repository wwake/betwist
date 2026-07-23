import Combine
import model
internal import Shimmer
import SwiftUI

struct RotatingGridView: View {
  static var cellSize = 50.0

  var game: Game

  var handleSelection: (Location) -> Void
  var width: CGFloat
  var height: CGFloat

  @State private var boardAnimation = BoardAnimation.zero
  @State private var animationAngle = Angle.zero
  @State private var animationAxis = Axis(x: 0.0, y: 0.0, z: 0.0)

  @State private var twist = Twist()

  @State private var timer = Timer.publish(every: 90, on: .main, in: .common).autoconnect()

  @State private var opacity = 1.0
  @State private var shimmerActive = false

  init(game: Game, handleSelection: @escaping (Location) -> Void, width: CGFloat, height: CGFloat) {
    self.game = game
    self.handleSelection = handleSelection
    self.width = width
    self.height = height
  }

  var body: some View {
    VStack {
      TwistButtons(
        boardAnimation: $boardAnimation,
        twist: $twist,
      )
      .shimmering(
        active: shimmerActive,
        animation: Animation.easeInOut(duration: 1.5),
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
    .onReceive(timer) { _ in
      shimmerActive = true

      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        shimmerActive = false
      }
    }
  }
}
