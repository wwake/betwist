import SwiftUI

enum Orientation {
  case landscape, portrait
}

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

  fileprivate func regularPortraitView(_ geometry: GeometryProxy) -> some View {
    return VStack {
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
        .offset(y: 50)

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

  fileprivate func regularLandscapeView(_ geometry: GeometryProxy) -> some View {
    HStack(alignment: .top) {
      VStack {
        AnswerInProgressView(game: $game, progress: progress, height: 500) {
          collectWord()
        }

        VStack(spacing: 8) {
          MessageView(message: game.message)
            .font(.title)
            .frame(width: 250, height: 40)
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
    .ignoresSafeArea()
    .background(Gradient(colors: [.gray, .black]).opacity(0.5))
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }


  var body: some View {
    GeometryReader { geometry in
      if ContentView.showMakerView {
        MakerView(game: game)
      }

      switch (verticalSizeClass, orientation(geometry)) {
      case (.regular, .portrait):
        regularPortraitView(geometry)

      case (.regular, .landscape):
        regularLandscapeView(geometry)

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

  fileprivate func orientation(_ geometry: GeometryProxy) -> Orientation {
    geometry.size.width > geometry.size.height ? .landscape : .portrait
  }
}

#Preview {
  @Previewable @State var game = Game(2, ["A", "B", "C", "D"])

  ContentView(game: $game)
}
