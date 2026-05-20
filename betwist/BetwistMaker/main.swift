import Foundation

do {
  let words = WordLoader.load(minimumSize: 4)
  let builder = TrieBuilder().add(words)
  let dataBuilder = DataBuilder()
  let _ = dataBuilder.make(trie: builder.root)
  let url = URL.documentsDirectory.appending(path: "trie.dat")
  try dataBuilder.write(url)
  print("Copy \(url) to project's resources folder")
} catch {
  print(error.localizedDescription)
}
