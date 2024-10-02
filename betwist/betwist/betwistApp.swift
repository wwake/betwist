import SwiftUI

@main
struct betwistApp: App {
  @State private var game = Game(5, GameMaker(5))

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
