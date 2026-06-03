import SwiftUI

struct InfiniteGrid: View {
  let maxGrids = 5

  @Binding var game: Game
  var handleSelection: (Location) -> Void

  var cellSize: Double
  var boardSize: Double

  var boardAnimation: BoardAnimation

  @Binding var twist: Twist

  @State private var offset = CGSize.zero

  var body: some View {
    let gridView = GridView(
      cellSize: cellSize,
      game: $game,
      handleSelection: handleSelection,
      boardAnimation: boardAnimation,
      twist: twist,
    )

    return VStack {
      VStack(spacing: 0) {
        ForEach(1...maxGrids, id: \.self) { _ in
          HStack(spacing: 0) {
            ForEach(1...maxGrids, id: \.self) { _ in
              gridView
            }
          }
        }
      }
      .offset(offset)
      .frame(minWidth: boardSize, maxWidth: boardSize, minHeight: boardSize, maxHeight: boardSize)
      .contentShape(Rectangle())
      .gesture(
        DragGesture(minimumDistance: 4)
          .onChanged { dragInfo in
            offset.width = dragInfo.translation.width
            offset.height = dragInfo.translation.height

            offset = offset.wrap(Double(game.size) * cellSize)
          }
          .onEnded { _ in
            let translation = CGAffineTransformMakeTranslation(offset.width, offset.height)

            twist = twist.apply(
              Twist(
                board: translation,
                letter: CGAffineTransformIdentity
              )
            )
            offset = CGSize.zero
          }
      )
    }
  }
}
