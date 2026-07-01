import model
import SwiftUI

@main
struct betwistApp: App {
  @State private var game = Game(
    5,
    GameGenerator(5).make(),
    Vocabulary(Trie.read("trie"))
  )

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
