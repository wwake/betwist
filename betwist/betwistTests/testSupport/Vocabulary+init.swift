@testable import betwist
import TrieGenerator

extension Vocabulary {
  convenience init(_ words: [String]) {
    let uppercaseWords = words.map { String($0).uppercased() }
    let root = TrieBuilder().add(uppercaseWords).root
    let data = DataBuilder().make(trie: root)
    self.init(Trie(data: TrieDataReader(data: data)))
  }
}
