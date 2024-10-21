import SwiftUI

struct LetterView<S: Shape>: View {
  var shape: S
  var size: Double

  @Binding var game: Game

  var location: Location
  var collectWord: () -> Void

  var chooser = ColorChooser()

  var body: some View {
    let type = game.type(at: location)

    shape
      .stroke(chooser.borderColor(type), lineWidth: type == .last ? 6.0 : 2.0)
      .fill(chooser.backgroundColor(type, hue: game.hue(at: location)))
      .frame(width: size, height: size)
      .overlay {
        Text("\(game[location])")
          .font(.largeTitle)
          .italic(type == .neighbor)
          .foregroundStyle(chooser.foregroundColor(type))
          .allowsHitTesting(false)
      }
      .onTapGesture {
        if game.lastLocationSelected(was: location) {
          collectWord()
        } else {
          game.select(location)
        }
      }
      .accessibilityAddTraits(.isButton)
      .zIndex(type == .last ? 2 : 1)
  }
}
