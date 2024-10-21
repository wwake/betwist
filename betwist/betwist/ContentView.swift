import SwiftUI

struct ContentView: View {
  static var cellSize = 50.0

  @Binding var game: Game
  @State private var guessOffset: CGFloat = 0
  @State private var showGuesses = false

  fileprivate func collectWord() {
    if game.guess.isEmpty { return }

    game.validate()
    if !game.message.isEmpty { return }

    game.blockSelection()
    withAnimation(.easeInOut(duration: 1)) {
      guessOffset = 375
    }
    completion: {
      guessOffset = 0
      game.collect()
      game.deselectAll()
    }
  }

  var body: some View {
    GeometryReader { proxy in
      VStack {
        GuessView(game: $game, offset: guessOffset) {
          collectWord()
        }

        Text(game.message)
          .foregroundStyle(.red)
          .frame(height: 20)

        InfiniteGrid(game: $game, collectWord: collectWord, cellSize: Self.cellSize, boardSize: proxy.size.width)

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
