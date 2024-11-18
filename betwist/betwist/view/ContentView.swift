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
            RegularPortraitView(geometry: geometry, game: $game, collectWord: collectWord, handleSelection: handleSelection)

          case (.regular, .regular, .landscape):
            RegularLandscapeView(geometry: geometry, game: $game, collectWord: collectWord, handleSelection: handleSelection)

          case (.compact, .regular, .portrait):
            CompactPortraitView(geometry: geometry, game: $game, collectWord: collectWord, handleSelection: handleSelection)

          case (.compact, .compact, .landscape):
            CompactLandscapeView(geometry: geometry, game: $game, collectWord: collectWord, handleSelection: handleSelection)

          default:
            CompactPortraitView(geometry: geometry, game: $game, collectWord: collectWord, handleSelection: handleSelection)
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

