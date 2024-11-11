import SwiftUI

struct ContentView: View {
  static let showMakerView = true
  static var cellSize = 50.0

  @Binding var game: Game
  @State private var progress = 0.0
  @State private var showAnswers = false
  @State private var angle = Angle.zero

  fileprivate func select(_ location: Location) {
    if game.submitIsInProgress { return }
    game.select(location)
  }

  fileprivate func collectWord() {
    if game.submitIsInProgress { return }

    let word = game.answer
    game.validate()
    guard game.hasValidSelection else { return }

    game.startAnimation()

    withAnimation(.easeInOut(duration: 3.75)) {
      progress = 1.0
    }
    completion: {
      progress = 0.0
      game.submit(word)
      game.finishAnimation()
    }
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
          .frame(height: 25)

        if ContentView.showMakerView {
          MakerView(game: game)
        }

        AnswerInProgressView(game: $game, progress: progress, height: 500) {
          collectWord()
        }

        HStack {
          Button {
            withAnimation {
              angle = .degrees(-90)
              game.rotateLeft()
            } completion: {
              angle = .zero
            }
          } label: {
            Image(systemName: "arrow.counterclockwise")
              .accessibilityLabel(Text("Rotate Left"))
          }.circled()

          Text(game.message)
          .foregroundStyle(.red)
          .frame(width: 250, height: 40)
          .opacity(game.message.isEmpty ? 0.0 : 1.0)

          Button {
            withAnimation {
              angle = .degrees(90)
              game.rotateRight()
            } completion: {
              angle = .zero
            }
          } label: {
            Image(systemName: "arrow.clockwise")
              .accessibilityLabel(Text("Rotate Right"))
          }
          .circled()
        }

        InfiniteGrid(game: $game, collectWord: collectWord, select: select, cellSize: Self.cellSize, boardSize: geometry.size.width)
          .rotationEffect(angle)

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
        AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
      }
    }
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
