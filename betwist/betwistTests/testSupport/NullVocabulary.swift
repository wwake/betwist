@testable import betwist
import Foundation

class NullVocabulary: Vocabulary {
  init() {
    super.init(Trie(data: TrieDataReader(data: Data())))
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
