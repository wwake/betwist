import SwiftUI

@main
struct betwistApp: App {
  @State private var game = Game(4, "ABCDEFGHIJKLMNOP".map { String($0) })

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
