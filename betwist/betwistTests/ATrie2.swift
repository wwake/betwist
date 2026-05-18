import Foundation
import Testing

@testable import betwist

struct ATrie2 {
  @Test
  func empty_trie_finds_no_words() {
    var data = Data()
    data.reserve(quadbytes: 8)

    let sut = Trie2(data: data)

    #expect(!sut.containsAndPrefixes("ANYTHING").isWord)
    #expect(!sut.containsAndPrefixes("ANYTHING").isProperPrefix)
  }
}
