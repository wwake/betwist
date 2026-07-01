import Foundation
@testable import model

class NullVocabulary: Vocabulary {
  init() {
    super.init(Trie(data: TrieDataReader(data: Data())))
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
