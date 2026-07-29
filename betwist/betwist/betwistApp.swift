import model
import SwiftUI
import view

@main
struct betwistApp: App {
  @State private var monetizer: Monetizer

  @State private var game = Game(
    5,
    GameGenerator(5).make(),
    Vocabulary(Trie.read("trie"))
  )

  init() {
    monetizer = Monetizer(store: MyStore())
    monetizer.startedNewGame()
  }

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
    .environment(monetizer)
  }
}
