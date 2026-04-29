import SwiftUI

struct RotatingGridView: View {
  static var cellSize = 50.0

  @State private var angle = Angle.zero

  @Binding var game: Game
  var handleSelection: (Location) -> Void
  var width: CGFloat

  var body: some View {
    VStack {
      HStack {
        RotateButton(clockwise: false, angle: $angle, game: $game)

        MirrorButton(
          iconName: "arrow.left.arrow.right",
          label: "Mirror Horizontally",
          transformFn: Location.flipHorizontal,
          game: $game,
          angle: $angle
        )

        RotateButton(clockwise: true, angle: $angle, game: $game)
      }
      .padding(.top, 5)
      .padding([.leading, .trailing], 8)
      .background(Capsule().fill(.thinMaterial))

      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width,
        angle: angle
      )
//      .rotationEffect(angle)
      .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
    }
    .frame(width: width)
    .zIndex(1)
  }
}
