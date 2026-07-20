import model
import SwiftUI

enum Orientation {
  case landscape, portrait
}

public struct ContentView: View {
  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass

  @Binding var game: Game

  @State private var showAnswers = false
  @State private var showOnboarding = false

  public init(game: Binding<Game>) {
    self._game = game
  }

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
    game.select(location)
  }

  fileprivate func collectWord() {
    game.collectWord()
  }

  public var body: some View {
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
              handleSelection: handleSelection,
              showOnboarding: { showOnboarding = true },
            )

          default:
            PortraitView(
              geometry: geometry,
              game: $game,
              collectWord: collectWord,
              handleSelection: handleSelection,
              showOnboarding: { showOnboarding = true },
            )
          }
        }
        .onChange(of: game.mode) { _, new in
          switch new {
          case .play:
            game.start()

          case .review:
            game.over()

          @unknown default:
            fatalError("Unknown game mode \(game.mode)")
          }
        }
      }
      .sheet(isPresented: $showOnboarding) {
        OnboardingView()
      }
    }
  }

  fileprivate func orientation(_ geometry: GeometryProxy) -> Orientation {
    geometry.size.width > geometry.size.height ? .landscape : .portrait
  }
}
