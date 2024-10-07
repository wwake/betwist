import SwiftUI

struct GridButtonStyle: ViewModifier {
  var game: Game
  var location: Location

  init(_ game: Game, _ location: Location) {
    self.game = game
    self.location = location
  }

  func foregroundColor(_ type: SelectionType) -> Color {
    switch type {
    case .open:
      return Color(.cellForegroundOpen)

    default:
      return Color(.cellForegroundSelected)
    }
  }

  func backgroundColor(_ type: SelectionType) -> Color {
    switch type {
    case .open:
      return Color(hue: game.hue(at: location), saturation: 0.15, brightness: 1.0)

    default:
      return Color(.cellBackgroundSelected)
    }
  }

  func borderColor(_ type: SelectionType) -> Color {
    switch type {
    case .first:
      return Color(.cellBorderFirst)

    case .middle:
      return Color(.cellBorderMiddle)

    case .last:
      return Color(.cellBorderLast)

    default:
      return Color(.cellBorderDefault)
    }
  }

  func body(content: Content) -> some View {
    let type = game.type(at: location)

    return content
      .font(.largeTitle)
      .frame(width: 48, height: 48)
      .background(backgroundColor(type))
      .foregroundStyle(foregroundColor(type))
      .border(borderColor(type), width: 1)
  }
}
