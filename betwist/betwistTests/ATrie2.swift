import Foundation
import Testing

@testable import betwist

struct ATrie2 {
  @Test
  func `finds no words when empty`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 8)

    let sut = Trie2(data: data)

    #expect(!sut.containsAndPrefixes("ANYTHING").isWord)
    #expect(!sut.containsAndPrefixes("ANYTHING").isProperPrefix)
  }

  @Test
  func `matches the last letter`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 8)
    data.overwrite(at: 4, bytes: [0x61, 0, 0, 0])

    let sut = Trie2(data: data)

    #expect(sut.containsAndPrefixes("A").isWord)
    #expect(!sut.containsAndPrefixes("A").isProperPrefix)
  }
}
