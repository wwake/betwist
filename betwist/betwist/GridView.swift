import SwiftUI

struct GridView: View {
  @Binding var game: Game
  var collectWord: () -> ()

  var body: some View {
    VStack(spacing: 0) {
      ForEach(game.rowIndexes, id: \.self) { row in
        HStack(spacing: 0) {
          ForEach(game.columnIndexes, id: \.self) { column in
            LetterView(shape: Rectangle(), game: $game, location: Location(row, column), collectWord: collectWord)
          }
        }
      }
    }
  }
}
