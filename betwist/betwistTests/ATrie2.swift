import Foundation
import Testing

@testable import betwist

struct ATrie2 {
  @Test
  func `finds no words when empty`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 2)

    let sut = Trie2(data: data)

    #expect(!sut.containsAndPrefixes("ANYTHING").isWord)
    #expect(!sut.containsAndPrefixes("ANYTHING").isProperPrefix)
  }

  @Test
  func `matches the last letter`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 1)
    data.append("A", true, 0)
    data.reserve(quadbytes: 1)

    let sut = Trie2(data: data)

    #expect(sut.containsAndPrefixes("A").isWord)
    #expect(!sut.containsAndPrefixes("A").isProperPrefix)
  }

  @Test
  func `tries alternatives for a letter`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 1)
    data.append("A", true, 0)
    data.append("I", true, 0)
    data.reserve(quadbytes: 1)

    let sut = Trie2(data: data)

    #expect(sut.containsAndPrefixes("I").isWord)
    #expect(!sut.containsAndPrefixes("I").isProperPrefix)
  }
}
