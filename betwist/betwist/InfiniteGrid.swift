import SwiftUI

struct InfiniteGrid: View {
  var cellSize: Double
  @Binding var game: Game
  var collectWord: () -> Void

  @State private var offset = CGSize.zero
  @State private var priorOffset = CGSize.zero

  var body: some View {
    VStack(spacing: 0) {
      ForEach(1...3, id: \.self) { _ in
        HStack(spacing: 0) {
          ForEach(1...3, id: \.self) { _ in
            GridView(cellSize: cellSize, game: $game, collectWord: collectWord)
          }
        }
      }
    }
    .frame(width: (Double(game.size) + 0.5) * cellSize , height: (Double(game.size)  + 0.5) * cellSize)
    .offset(offset)
    .clipShape(Rectangle())
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
