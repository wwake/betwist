import SwiftUI

struct ContentView: View {
  static let showMakerView = false

  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  @Binding var game: Game
  @State private var submitIsInProgress = false

  @State private var progress = 0.0
  @State private var showAnswers = false

  fileprivate func handleSelection(_ location: Location) {
    if !game.lastLocationSelected(was: location) {
      select(location)
    } else if game.selection.count == 1 {
      game.deselectAll()
    } else {
      collectWord()
    }
  }

  fileprivate func select(_ location: Location) {
    if submitIsInProgress { return }
    game.select(location)
  }

  fileprivate func collectWord() {
    let word = game.answer

    if submitIsInProgress { return }
    if word.isEmpty { return }

    game.validate()
    guard game.hasValidSelection else { return }

    submitIsInProgress = true

    withAnimation(.easeInOut(duration: 0.75)) {
      progress = 1.0
    }
    completion: {
      progress = 0.0
      game.submit(word)
      submitIsInProgress = false
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

        HStack {
          Spacer()
          AnswerInProgressView(game: $game, progress: progress, height: 500) {
            collectWord()
          }
          Spacer()
          if verticalSizeClass == .regular {
            HStack {
              ScoreView(score: game.score)
              NewGameButton(game: $game)
            }
            Spacer()
          }
        }
        .zIndex(5)
        MessageView(message: game.message)
          .frame(width: 250, height: 40)

        RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.width)

        HStack(alignment: .top) {
          if verticalSizeClass == .compact {
            VStack {
              ScoreView(score: game.score)
              NewGameButton(game: $game)
            }
          }
          AnswersSummaryView(game: $game) {
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
    .onChange(of: game.mode) { _, new in
      switch new {
      case .play:
        submitIsInProgress = false
        game.message = ""

      case .review:
        submitIsInProgress = true
        game.message = "Game Over"
      }
    }
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
