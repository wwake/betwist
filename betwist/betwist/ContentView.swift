import SwiftUI

struct GridButton: ViewModifier {
  var game: Game
  var location: Location

  init(_ game: Game, _ location: Location) {
    self.game = game
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
      return Color(white: 1.0, opacity: 0.85)

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
    let type = game.type(at: location)

    return content
      .font(.largeTitle)
      .padding(20)
      .background(backgroundColor(type))
      .foregroundStyle(foregroundColor(type))
      .border(borderColor(type), width: 2)
  }
}

struct MotionControls: View {
  @Binding var game: Game

  var body: some View {
    VStack {
      Button {
        withAnimation {
          game.twist(.up)
        }
      } label: {
        Image(systemName: "arrow.up.circle")
          .imageScale(.large)
      }
      .buttonStyle(.bordered)
      .tint(.mint)

      HStack {
        Button {
          withAnimation {
            game.twist(.left)
          }
        } label: {
          Image(systemName: "arrow.left.circle")
            .imageScale(.large)
        }
        .buttonStyle(.bordered)
        .tint(.mint)

        Button {
          withAnimation {
            game.twist(.right)
          }
        } label: {
          Image(systemName: "arrow.right.circle")
            .imageScale(.large)
        }
      }
      .buttonStyle(.bordered)
      .tint(.mint)

      Button {
        withAnimation {
          game.twist(.down)
        }
      } label: {
        Image(systemName: "arrow.down.circle")
          .imageScale(.large)
      }
      .buttonStyle(.bordered)
      .tint(.mint)

    }
  }
}
struct ContentView: View {
  @Binding var game: Game
  @State private var guessOffset: CGFloat = 0

  var body: some View {
    ZStack {
      VStack {
        Text(game.guess)
          .font(.largeTitle)
          .padding(8)
          .frame(minWidth: 200)
          .frame(height: 50)
          .border(.white)
          .accessibilityAddTraits(.isButton)
          .offset(y: guessOffset)
          .zIndex(1)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
              guessOffset = 350
            }
            completion: {
              guessOffset = 0
              game.collect()
              game.deselectAll()
            }
          }

        ForEach(game.rowIndexes, id: \.self) { row in
          HStack {
            ForEach(game.columnIndexes, id: \.self) { column in
              Button("\(game[row, column])") {
                game.select(Location(row, column))
              }
              .frame(width: 30, height: 30)
              .modifier(GridButton(game, Location(row, column)))
            }
          }
        }

        MotionControls(game: $game)

        ScrollView {
          Text(verbatim: String(game.guesses.joined(by: "\n")))
            .font(.title)
        }

        Spacer()
      }
      .padding()
      .containerRelativeFrame([.horizontal, .vertical])
      .background(Gradient(colors: [.gray, .black]).opacity(0.5))
    }
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
