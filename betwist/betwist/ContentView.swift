import SwiftUI

struct ContentView: View {
  @Binding var game: Game
  @State private var guessOffset: CGFloat = 0
  @State private var showGuesses = false

  fileprivate func collectWord() {
    if game.guess.isEmpty { return }

    game.validate()
    if !game.message.isEmpty { return }

    game.blockSelection()
    withAnimation(.easeInOut(duration: 1)) {
      guessOffset = 350
    }
    completion: {
      guessOffset = 0
      game.collect()
      game.deselectAll()
    }
  }

  var body: some View {
    ZStack {
      VStack {
        HStack {
          Image("TheIcon")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 128, maxHeight: 128)
            .accessibilityLabel(Text("Betwist"))
          Text(game.guess)
            .font(.largeTitle)
            .foregroundStyle(game.message.isEmpty ? Color.black : Color.red)
            .frame(minWidth: 230)
            .frame(height: 40)
            .padding(4)
            .background(Color(white: 1.0, opacity: 0.85))
            .border(.black, width: 2)
            .accessibilityAddTraits(.isButton)
            .offset(y: guessOffset)
            .onTapGesture {
              collectWord()
            }
          Button {
            collectWord()
          } label: {
            Image(systemName: "checkmark.circle.fill")
              .accessibilityLabel(Text("Enter"))
              .font(.largeTitle)
              .foregroundStyle(.green)
          }
        }
        .zIndex(1)

        Text(game.message)
          .foregroundStyle(.red)
          .frame(height: 20)

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
        }.gesture(
          DragGesture(minimumDistance: 50)
          .onEnded { dragInfo in
            withAnimation {
              game.twist(dragInfo.startLocation.direction(to: dragInfo.location))
            }
          }
        )

       // MotionControls(game: $game)

        HStack {
          Button {
            showGuesses.toggle()
          } label: {
            Image(systemName: "doc.text.magnifyingglass")
              .accessibilityLabel(Text("View Guesses"))
          }
          .opacity(game.guesses.isEmpty ? 0 : 1)

          ScrollView {
            Text(verbatim: String(game.guesses.joined(by: "\n")))
              .font(.title2)
              .frame(width: 300)
          }
        }

        Spacer()
      }
      .padding()
      .containerRelativeFrame([.horizontal, .vertical])
      .background(Gradient(colors: [.gray, .black]).opacity(0.5))
      .sheet(isPresented: $showGuesses) {
        GuessesView(guesses: game.guesses)
      }
    }
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
