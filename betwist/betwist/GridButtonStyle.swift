import SwiftUI

extension Text {
  func italic(enabled: Bool) -> Text {
    if enabled {
      return self.italic()
    }
    return self
  }
}

struct ColorChooser {
  func foregroundColor(_ type: SelectionType) -> Color {
    switch type {
    case .open, .neighbor:
      return Color(.cellForegroundOpen)

    default:
      return Color(.cellForegroundSelected)
    }
  }

  func backgroundColor(_ type: SelectionType, hue: Double) -> Color {
    switch type {
    case .open, .neighbor:
      return Color(hue: hue, saturation: 0.15, brightness: 1.0)

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

    case .neighbor:
      return Color(.cellBorderNeighbor)

    default:
      return Color(.cellBorderDefault)
    }
  }
}

struct GridButtonStyle: ViewModifier {
  var game: Game
  var location: Location

  var chooser = ColorChooser()

  init(_ game: Game, _ location: Location) {
    self.game = game
    self.location = location
  }

  func body(content: Content) -> some View {
    let type = game.type(at: location)

    return content
      .font(.largeTitle)
      .frame(width: 48, height: 48)
      .background(chooser.backgroundColor(type, hue: game.hue(at: location)))
      .foregroundStyle(chooser.foregroundColor(type))
      .border(chooser.borderColor(type), width: 1)
      .italic(type == .neighbor)
  }
}
