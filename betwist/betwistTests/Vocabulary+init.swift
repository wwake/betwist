@testable import betwist

extension Vocabulary {
  convenience init(_ words: [String]) {
    self.init(TrieBuilder().add(words).make())
  }
}
