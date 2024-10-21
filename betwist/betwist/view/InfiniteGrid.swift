import SwiftUI

struct InfiniteGrid: View {
  @Binding var game: Game
  var collectWord: () -> Void
  var cellSize: Double
  var boardSize: Double

  @State private var offset = CGSize.zero
  @State private var priorOffset = CGSize.zero

  var body: some View {
    VStack {
      VStack(spacing: 0) {
        ForEach(1...3, id: \.self) { _ in
          HStack(spacing: 0) {
            ForEach(1...3, id: \.self) { _ in
              GridView(cellSize: cellSize, game: $game, collectWord: collectWord)
            }
          }
        }
      }
      .offset(offset)
      .frame(minWidth: boardSize, maxWidth: boardSize, minHeight: boardSize, maxHeight: boardSize)
      .clipped()
      .gesture(
        DragGesture(minimumDistance: 4)
          .onChanged { dragInfo in
            offset.width = priorOffset.width + dragInfo.translation.width
            offset.height = priorOffset.height + dragInfo.translation.height

            offset = offset.wrap(Double(game.size) * cellSize)
          }
          .onEnded { _ in
            priorOffset = offset
          }
      )
    }
  }
}
