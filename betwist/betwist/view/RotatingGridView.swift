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
          .padding([.leading], 20)

        Spacer()

        RotateButton(clockwise: true, angle: $angle, game: $game)
          .padding([.trailing], 20)
      }
      
      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width
      )
      .rotationEffect(angle)
    }
    .border(.green)
    .zIndex(1)
  }
}
