import SwiftUI

@main
struct betwistApp: App {
  @State private var game = Game(5, GameMaker(5), Vocabulary(Trie.read("trie")))

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
