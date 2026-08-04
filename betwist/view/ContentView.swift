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
    (
      .onboardTitle,
      "Betwist - Finding words with a twist. The letters are in a repeating grid."
    ),
    (.onboardFormWord, "Tap neighbors to build a word"),
    (
      .onboardScore,
      "Tap the last letter twice to score. You get credit for shorter words too!"
    ),
    (.onboardTwist, "Tap a twist button if you get stuck"),
    (.onboardReveal, "'Reveal' shows words you and the system found"),
    (
      .onboardDefinition,
      "Tap the magnifying glass to see a definition (if we have it)"
    ),
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

  fileprivate func boardView(_ geometry: GeometryProxy) -> some View {
    VStack {
      switch (horizontalSizeClass, verticalSizeClass, orientation(geometry)) {
      case (.regular, .regular, .landscape):
        LandscapeView(
          geometry: geometry,
          game: $game,
          collectWord: collectWord,
          handleSelection: handleSelection,
          showOnboarding: onboard,
          showAnswers: $showAnswers,
        )

      default:
        PortraitView(
          geometry: geometry,
          game: $game,
          collectWord: collectWord,
          handleSelection: handleSelection,
          showOnboarding: onboard,
          showAnswers: $showAnswers,
        )
      }
    }
  }

  fileprivate func answerView() -> some View {
    AnswerDetailsView(
      closeAction: {
        withAnimation {
          showAnswers = false
        }
      },
      showAnswers: $showAnswers,
      statistics: game.statistics,
      userAnswers: game.answers,
      systemAnswers: game.systemAnswers,
    )
    .transition(
      .asymmetric(
        insertion: .push(from: .trailing),
        removal: .push(from: .leading)
      )
    )
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

        if showAnswers {
          answerView()
        } else {
          boardView(geometry)
        }
      }
      .onChange(of: game.mode) {
        if game.mode == .review {
          showAnswers = true
        }
      }

      .sheet(isPresented: $showOnboarding) {
        OnboardingView(images: Self.onboardImages)
          .presentationBackground(Color.accent)
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
