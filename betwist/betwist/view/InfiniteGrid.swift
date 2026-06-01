import SwiftUI

struct InfiniteGrid: View {
  let maxGrids = 5

  @Binding var game: Game
  var handleSelection: (Location) -> Void

  var cellSize: Double
  var boardSize: Double

  var animationAngle: Angle
  var axis: Axis
  var boardAnimation: BoardAnimation

  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  @State private var offset = CGSize.zero

  var body: some View {
    let gridView = GridView(
      cellSize: cellSize,
      game: $game,
      handleSelection: handleSelection,
      animationAngle: animationAngle,
      axis: axis,
      boardAnimation: boardAnimation,
      twistBoard: twistBoard,
      twistLetter: untwistLetter
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
            twistBoard = twistBoard.translatedBy(x: offset.width, y: offset.height)
            offset = CGSize.zero
          }
      )
    }
  }
}
