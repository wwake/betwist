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
          game: $game
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
        boardSize: width
      )
      .rotationEffect(angle)
    }
    .frame(width: width)
    .zIndex(1)
  }
}
