import SwiftUI

enum Orientation {
  case landscape, portrait
}

struct ContentView: View {
  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass

  @Binding var game: Game
  @State private var submitIsInProgress = false

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

    game.submit(word)
    submitIsInProgress = false
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(
          colors: [Color(.backgroundStart), Color(.backgroundEnd)],
          startPoint: .top,
          endPoint: .bottom
        )
        .ignoresSafeArea()

        VStack {
          switch (horizontalSizeClass, verticalSizeClass, orientation(geometry)) {
          case (.regular, .regular, .landscape):
            LandscapeView(
              geometry: geometry,
              game: $game,
              collectWord: collectWord,
              handleSelection: handleSelection
            )

          default:
            PortraitView(
              geometry: geometry,
              game: $game,
              collectWord: collectWord,
              handleSelection: handleSelection
            )
          }
        }
        .onChange(of: game.mode) { _, new in
          switch new {
          case .play:
            submitIsInProgress = false
            game.message = ""

          case .review:
            submitIsInProgress = true
            game.over()
          }
        }
      }
    }
  }

  fileprivate func orientation(_ geometry: GeometryProxy) -> Orientation {
    geometry.size.width > geometry.size.height ? .landscape : .portrait
  }
}
