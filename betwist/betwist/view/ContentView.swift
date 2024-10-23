import SwiftUI

struct ContentView: View {
  static var cellSize = 50.0

  @Binding var game: Game
  @State private var progress = 0.0
  @State private var showAnswers = false

  fileprivate func collectWord() {
    if game.answer.isEmpty { return }

    game.validate()
    if !game.message.isEmpty { return }

    game.blockSelection()
    withAnimation(.easeInOut(duration: 0.75)) {
      progress = 1.0
    }
    completion: {
      progress = 0.0
      game.collect()
      game.deselectAll()
    }
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
        AnswerInProgressView(game: $game, progress: progress, height: 500) {
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
            game.rotateRight()
          } label: {
            Image(systemName: "arrow.clockwise")
              .accessibilityLabel(Text("Rotate Right"))
          }
          .circled()
        }

        InfiniteGrid(game: $game, collectWord: collectWord, cellSize: Self.cellSize, boardSize: geometry.size.width)

        HStack(alignment: .top) {
          VStack {
            ScoreView(score: game.score)
            Button("New Game") {
              game = Game(game.size, GameMaker(game.size), game.vocabulary)
            }
            .capsuled()
          }
          AnswersView(game: $game) {
            showAnswers.toggle()
          }
        }
        Spacer()
      }
      .padding(.top, 40)
      .ignoresSafeArea()
      .background(Gradient(colors: [.gray, .black]).opacity(0.5))
      .sheet(isPresented: $showAnswers) {
        AnswerDetailsView(answers: game.answers)
      }
    }
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
