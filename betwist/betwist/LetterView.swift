import SwiftUI

struct LetterView: View {
  @Binding var game: Game

  var row: Int
  var column: Int
  var collectWord: () -> ()

  var body: some View {
    Rectangle()
      .frame(width: 50, height: 50)

    Button {
      let location = Location(row, column)
      if game.lastLocationSelected(was: location) {
        collectWord()
      } else {
        game.select(location)
      }
    } label: {
      Text("\(game[row, column])")
    }
    .modifier(GridButtonStyle(game, Location(row, column)))
  }
}
