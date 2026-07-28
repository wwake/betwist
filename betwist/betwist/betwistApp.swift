import model
import SwiftUI
import view

@main
struct betwistApp: App {
  @State private var store = Store()
  @State private var monetizer: Monetizer

  @State private var game = Game(
    5,
    GameGenerator(5).make(),
    Vocabulary(Trie.read("trie"))
  )

  init() {
    monetizer = Monetizer()
  }

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
    .environment(monetizer)
  }
}
