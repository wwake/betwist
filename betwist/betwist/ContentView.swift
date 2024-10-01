import SwiftUI

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
              .modifier(GridButtonStyle(game, Location(row, column)))
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
