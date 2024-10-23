import SwiftUI

struct LetterView<S: InsettableShape>: View {
  var shape: S
  var size: Double

  @Binding var game: Game

  var location: Location
  var collectWord: () -> Void

  var chooser = ColorChooser()

  var body: some View {
    let type = game.type(at: location)

    shape
      .fill(chooser.backgroundColor(type, hue: game.hue(at: location)))
      .strokeBorder(chooser.borderColor(type), lineWidth: chooser.borderWidth(type))
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
  }
}
