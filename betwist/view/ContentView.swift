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

  @AppStorage("priorVersion")
  var priorVersion: String = ""

  @Binding var game: Game

  @State private var showAnswers = false

  @State private var showOnboarding = false

  static let onboardImages: [(ImageResource, String)] = [
    (.onboardTitle, "Betwist - Finding words with a twist. The letters are in a repeating grid."),
    (.onboardFormWord, "Tap neighbors to build a word"),
    (.onboardUndo, "Tap an earlier letter to undo"),
    (.onboardScore, "Tap the last letter twice to score. You get credit for shorter words too!"),
    (.onboardTwist, "Tap a twist button if you get stuck"),
    (.onboardReveal, "'Reveal' shows words you and the system found"),
    (.onboardDefinition, "Tap the magnifying glass to see a definition (if we have it)"),
  ]

  public init(game: Binding<Game>) {
    self._game = game
  }

  fileprivate func getVersion() -> String {
    Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
  }

  func onboard() {
    showOnboarding = true
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
          startPoint: .topLeading,
          endPoint: .bottomTrailing
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
              showOnboarding: onboard,
            )

          default:
            PortraitView(
              geometry: geometry,
              game: $game,
              collectWord: collectWord,
              handleSelection: handleSelection,
              showOnboarding: onboard,
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
        OnboardingView(images: Self.onboardImages)
          .presentationBackground(Color.accent.opacity(0.5))
      }
      .onAppear {
        let currentVersion = getVersion()
        showOnboarding = priorVersion != currentVersion
        priorVersion = currentVersion
      }
    }
  }

  fileprivate func orientation(_ geometry: GeometryProxy) -> Orientation {
    geometry.size.width > geometry.size.height ? .landscape : .portrait
  }
}
