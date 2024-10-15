import SwiftUI

struct LetterView: View {
  @Binding var game: Game

  var location: Location
  var collectWord: () -> ()

  var chooser = ColorChooser()

  var body: some View {
//    Rectangle()
//      .strokeBorder(chooser.borderColor(game.type(at: Location(row, column))), lineWidth: 2)
//      .fill(chooser.backgroundColor(game.type(at: Location(row, column)), hue: game.hue(at: Location(row, column))))
//      .foregroundStyle(chooser.foregroundColor(game.type(at: Location(row, column))))
//      .frame(width: 50, height: 50)

    Button {
      if game.lastLocationSelected(was: location) {
        collectWord()
      } else {
        game.select(location)
      }
    } label: {
      Text("\(game[location])")
    }
    .modifier(GridButtonStyle(game, location))
  }
}
