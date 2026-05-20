import Foundation
import Testing

@testable import betwist

struct ATrie2 {
  @Test
  func `finds no words when empty`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 2)

    let sut = Trie(data: data)

    #expect(!sut.containsAndPrefixes("ANYTHING").isWord)
    #expect(!sut.containsAndPrefixes("ANYTHING").isProperPrefix)
  }

  @Test
  func `matches the last letter`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 1)
    data.append("A", true, 0)
    data.reserve(quadbytes: 1)

    let sut = Trie(data: data)

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

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("I").isWord)
    #expect(!sut.containsAndPrefixes("I").isProperPrefix)
  }

  @Test
  func `moves to next letter if prior letter matches`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 1)
    data.append("A", true, 12)
    data.reserve(quadbytes: 1)
    data.append("S", true, 0)
    data.reserve(quadbytes: 1)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("AS").isWord)
    #expect(!sut.containsAndPrefixes("AS").isProperPrefix)
  }

  @Test
  func `recognizes when an accepted word could be extended`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 1)
    data.append("B", false, 12)
    data.reserve(quadbytes: 1)
    data.append("Y", true, 0)
    data.reserve(quadbytes: 1)

    let sut = Trie(data: data)

    #expect(!sut.containsAndPrefixes("B").isWord)
    #expect(sut.containsAndPrefixes("B").isProperPrefix)
  }

  @Test
  func `finds alternatives for the second letter`() {
    var data = TrieData(data: Data())
    data.reserve(quadbytes: 1)
    data.append("B", false, 12)
    data.reserve(quadbytes: 1)
    data.append("E", true, 0)
    data.append("Y", true, 0)
    data.reserve(quadbytes: 1)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("BY").isWord)
    #expect(!sut.containsAndPrefixes("BY").isProperPrefix)
  }
}
