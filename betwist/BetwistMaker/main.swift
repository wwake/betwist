import Foundation
import TrieGenerator

// Instructions:
// Copy words.list from the resources folder to the downloads directory
// Run this script
// Copy trie.dat from the downloads directory to the resources folder

do {
  let folderURL = try FileManager.default.url(
    for: .downloadsDirectory,
    in: .userDomainMask,
    appropriateFor: nil,
    create: false
  )

  let fileURL = folderURL
    .appendingPathComponent("words.list")

  let words = WordLoader.load(path: fileURL.path(), minimumSize: 4)

  let builder = TrieBuilder().add(words)

  let dataBuilder = DataBuilder()
  _ = dataBuilder.make(trie: builder.root)
  let url = URL.downloadsDirectory.appending(path: "trie.dat")
  try dataBuilder.write(url)
  print("Copy \(url) to project's resources folder")
} catch {
  print("main: Couldn't write trie due to \(error.localizedDescription)")
}
