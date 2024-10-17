import SwiftUI

struct GridView: View {
  var cellSize: Double
  @Binding var game: Game
  var collectWord: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      ForEach(game.rowIndexes, id: \.self) { row in
        HStack(spacing: 0) {
          ForEach(game.columnIndexes, id: \.self) { column in
            LetterView(
              shape: Rectangle(),
              size: cellSize,
              game: $game,
              location: Location(row, column),
              collectWord: collectWord
            )
          }
        }
      }
    }
  }
}
