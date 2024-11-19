import SwiftUI

struct LetterView<S: InsettableShape>: View {
  var shape: S
  var size: Double

  @Binding var game: Game

  var location: Location
  var handleSelection: (Location) -> Void

  var chooser = ColorChooser()

  var body: some View {
    let type = game.type(at: location)

    shape
      .fill(chooser.backgroundColor(type, hue: game.hue(at: location)))
      .strokeBorder(chooser.borderColor(type), lineWidth: chooser.borderWidth(type))
      .frame(width: size, height: size)
      .overlay {
        Text("\(game[location].capitalized)")
          .minimumScaleFactor(0.4)
          .scaleEffect(x: game[location].count == 2 ? 0.85 : 1.0)
          .font(.largeTitle)
          .italic(type == .neighbor)
          .foregroundStyle(chooser.foregroundColor(type))
          .allowsHitTesting(false)
      }
      .onTapGesture {
        handleSelection(location)
      }
      .accessibilityAddTraits(.isButton)
  }
}
