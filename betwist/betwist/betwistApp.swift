import SwiftUI

@main
struct betwistApp: App {
  @State private var game = Game(5, GameMaker(5), Vocabulary(Trie.load("trie")))

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
