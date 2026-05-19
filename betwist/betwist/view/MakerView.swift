import Foundation
import SwiftUI

struct MakerView: View {
  var game: Game

  var body: some View {
    VStack {
      Button("Generate Trie") {
        do {
          let words = WordLoader.load()
          let builder = TrieBuilder().add(words)
          let trie = builder.make()

          let url = URL.documentsDirectory.appending(path: "trie.json-compressed")
          try trie.write(url)
          print("Copy \(url) to project's resources folder")

          let dataBuilder = DataBuilder()
          let data = dataBuilder.make(trie: builder.root)
          let url2 = URL.documentsDirectory.appending(path: "trie.dat")
          try Trie2.write(url2, data)
          print("Copy \(url2) to project's resources folder")
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
