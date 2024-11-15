import SwiftUI

enum Orientation {
  case landscape, portrait
}

struct ContentView: View {
  static let showMakerView = false

  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass

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

  fileprivate func regularPortraitView(_ geometry: GeometryProxy) -> some View {
    VStack {
      if ContentView.showMakerView {
        MakerView(game: game)
      }

      HStack {
        Spacer()
        AnswerInProgressView(game: $game, progress: progress, height: 500) {
          collectWord()
        }
        Spacer()

        HStack {
          ScoreView(score: game.score)

          VStack {
            NewGameButton(game: $game)

            AnswersSummaryView(game: $game) {
              showAnswers.toggle()
            }
          }
        }
        Spacer()
      }
      .zIndex(5)

      MessageView(message: game.message)
        .frame(width: 250, height: 40)
        .offset(y: 50)

      RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.width)

      HStack(alignment: .top) {
        AnswersSummaryView(game: $game) {
          showAnswers.toggle()
        }
      }

      Spacer()
    }
    .padding(.top, 40)
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }

  fileprivate func compactPortraitView(_ geometry: GeometryProxy) -> some View {
    VStack {
      if ContentView.showMakerView {
        MakerView(game: game)
      }

      AnswerInProgressView(game: $game, progress: progress, height: 500) {
        collectWord()
      }
      .zIndex(5)

      MessageView(message: game.message)
        .frame(height: 24)
        .frame(maxWidth: .infinity)
        .font(.title)

      RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.width)

      HStack(alignment: .top) {
        VStack {
          ScoreView(score: game.score)
            .font(.title3)

          NewGameButton(game: $game)
        }

        AnswersSummaryView(game: $game) {
          showAnswers.toggle()
        }
      }
      .padding([.top], 12)

      Spacer()
    }
    .padding(.top, 1)
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }

  fileprivate func regularLandscapeView(_ geometry: GeometryProxy) -> some View {
    HStack(alignment: .top) {
      VStack {
        AnswerInProgressView(game: $game, progress: progress, height: 500) {
          collectWord()
        }

        VStack(spacing: 8) {
          MessageView(message: game.message)
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding([.bottom], 20)

          ScoreView(score: game.score)
            .font(.title)
            .padding([.bottom], 20)

          NewGameButton(game: $game)
            .font(.title)
            .padding([.bottom], 20)

          YouFoundView(answers: game.answers)
            .font(.title)
            .frame(width: 250)

          Button("More...") {
            showAnswers.toggle()
          }
          .capsuled()
          .font(.title)
          .padding(12)
        }
      }
      .zIndex(5)

      RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.height)
    }
    .padding(.top, 40)
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }


  var body: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(
          colors: [Color(.backgroundStart), Color(.backgroundEnd)],
            startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()

        VStack {
          if Self.showMakerView {
            MakerView(game: game)
          }

          switch (horizontalSizeClass, verticalSizeClass, orientation(geometry)) {
          case (.regular, .regular, .portrait):
            regularPortraitView(geometry)

          case (.regular, .regular, .landscape):
            regularLandscapeView(geometry)

          case (.compact, .regular, .portrait):
            compactPortraitView(geometry)

          case (.regular, .compact, .landscape):
            Text("iPhone landscape")

          default:
            Text("Not yet")
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
  }

  fileprivate func orientation(_ geometry: GeometryProxy) -> Orientation {
    geometry.size.width > geometry.size.height ? .landscape : .portrait
  }
}

#Preview(traits: .portrait) {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])
    ContentView(game: $game)
}

#Preview(traits: .landscapeLeft) {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])
    ContentView(game: $game)
}

