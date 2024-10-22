import SwiftUI

struct ContentView: View {
  static var cellSize = 50.0

  @Binding var game: Game
  @State private var guessProgress = 0.0
  @State private var showGuesses = false

  fileprivate func collectWord() {
    if game.guess.isEmpty { return }

    game.validate()
    if !game.message.isEmpty { return }

    game.blockSelection()
    withAnimation(.easeInOut(duration: 0.75)) {
      guessProgress = 1.0
    }
    completion: {
      guessProgress = 0.0
      game.collect()
      game.deselectAll()
    }
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
        GuessView(game: $game, guessProgress: guessProgress, height: 500) {
          collectWord()
        }

        HStack {
          Button {
            game.rotateLeft()
          } label: {
            Image(systemName: "arrow.counterclockwise")
              .accessibilityLabel(Text("Rotate Left"))
          }.circled()

          Text(game.message)
          .foregroundStyle(.red)
          .frame(width: 250, height: 40)
          .opacity(game.message.isEmpty ? 0.0 : 1.0)

          Button {
            // rotateRight()
          } label: {
            Image(systemName: "arrow.clockwise")
              .accessibilityLabel(Text("Rotate Right"))
          }
          .circled()
        }

        InfiniteGrid(game: $game, collectWord: collectWord, cellSize: Self.cellSize, boardSize: geometry.size.width)

        HStack(alignment: .top) {
          ScoreView(score: game.score)
          AnswersView(game: $game) {
            showGuesses.toggle()
          }
        }
        Spacer()
      }
      .padding(.top, 40)
      .ignoresSafeArea()
      .background(Gradient(colors: [.gray, .black]).opacity(0.5))
      .sheet(isPresented: $showGuesses) {
        AnswerDetailsView(guesses: game.guesses)
      }
    }
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
