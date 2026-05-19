import SwiftUI

@main
struct betwistApp: App {
  @State private var game = Game(
    5,
    GameMaker(5).make(),
    Vocabulary(Trie2.read("trie"))
  )

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
