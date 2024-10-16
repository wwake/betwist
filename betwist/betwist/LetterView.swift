import SwiftUI

struct LetterView<S: Shape>: View {
  var shape: S
  var size: Double

  @Binding var game: Game

  var location: Location
  var collectWord: () -> Void

  var chooser = ColorChooser()

  var body: some View {
    shape
      .stroke(chooser.borderColor(game.type(at: location)), lineWidth: 4.0)
      .fill(chooser.backgroundColor(game.type(at: location), hue: game.hue(at: location)))
      .frame(width: size, height: size)
      .overlay {
        Text("\(game[location])")
          .font(.largeTitle)
          .italic(game.type(at: location) == .neighbor)
          .foregroundStyle(chooser.foregroundColor(game.type(at: location)))
          .allowsHitTesting(false)
      }
      .onTapGesture {
        if game.lastLocationSelected(was: location) {
          collectWord()
        } else {
          game.select(location)
        }
      }
  }
}
