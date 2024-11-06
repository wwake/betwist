import SwiftUI

struct MakerView: View {
  var game: Game

  var body: some View {
    VStack {
      Button("Generate Trie") {
        do {
          let words = VocabularyLoader.loadStrings()
          let trie = TrieBuilder().add(words).make()

          let data = try JSONEncoder().encode(trie)
          let url = URL.documentsDirectory.appending(path: "trie.json")
          try data.write(to: url, options: [.atomic, .completeFileProtection])
          print("Copy \(url) to project's resources folder")
        } catch {
            print(error.localizedDescription)
        }
      }
      .capsuled()
    }
  }
}

#Preview {
  MakerView(game: Game(2, ["A", "B", "E", "D"]))
}
