import SwiftUI

struct GridButton: ViewModifier {
  var selection: Selection
  var location: Location

  init(_ selection: Selection, _ location: Location) {
    self.selection = selection
    self.location = location
  }

  func foregroundColor(_ type: SelectionType) -> Color {
    switch type {
    case .open:
      return .black

    default:
      return .white
    }
  }

  func backgroundColor(_ type: SelectionType) -> Color {
    switch type {
    case .open:
      return Color(white: 1.0, opacity: 0.75)

    default:
      return .black
    }
  }

  func borderColor(_ type: SelectionType) -> Color {
    switch type {
    case .last:
      return .red

    default:
      return .black
    }
  }

  func body(content: Content) -> some View {
    let type = selection.type(location)

    return content
      .font(.largeTitle)
      .padding(20)
      .background(backgroundColor(type))
      .foregroundStyle(foregroundColor(type))
      .border(borderColor(type), width: 2)
  }
}

struct ContentView: View {
  @Binding var game: Game
  @Binding var selection: Selection

  var body: some View {
    VStack {
      Text(game.selection.guess)
        .font(.largeTitle)
        .padding(8)
        .frame(minWidth: 200)
        .frame(height: 50)
        .border(.white)
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
          game.selection.clear()
        }

      ForEach(0..<game.selection.board.size, id: \.self) { row in
        HStack {
          ForEach(0..<game.selection.board.size, id: \.self) { column in
            Button("\(game.selection.board[row, column])") {
              let location = Location(row, column)
              game.selection.select(location)
            }
            .frame(width: 30, height: 30)
            .modifier(GridButton(game.selection, Location(row, column)))
          }
        }
      }
    }
    .padding()
    .containerRelativeFrame([.horizontal, .vertical])
    .background(Gradient(colors: [.gray, .black]).opacity(0.5))
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])
  @Previewable @State var selection = Selection(Board(2, ["A", "B", "C", "D"]))

  ContentView(game: $game, selection: $selection)
}
