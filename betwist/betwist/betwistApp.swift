import SwiftUI

fileprivate enum VocabularyLoader {
  static func load() -> Vocabulary {
    let path = Bundle.main.path(forResource: "words", ofType: "list")!
    let words = try! String(contentsOfFile: path, encoding: .utf8)
      .split(separator: "\n")
      .map { String($0).uppercased() }
    return Vocabulary(words)
  }
}

@main
struct betwistApp: App {
  @State private var game = Game(5, GameMaker(5), VocabularyLoader.load())

  var body: some Scene {
    WindowGroup {
      ContentView(game: $game)
    }
  }
}
