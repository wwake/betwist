import Foundation
import Testing

@testable import betwist

struct ATrie {
  @Test
  func `matches the last letter`() {
    var data = TrieDataReader(data: Data())
    data.reserve(matchEntries: 1)
    data.append("A", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("A").isWord)
    #expect(!sut.containsAndPrefixes("A").isProperPrefix)
  }

  @Test
  func `tries alternatives for a letter`() {
    var data = TrieDataReader(data: Data())
    data.reserve(matchEntries: 1)
    data.append("A", isWord: true, isLast: false, 0)
    data.append("I", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("I").isWord)
    #expect(!sut.containsAndPrefixes("I").isProperPrefix)
  }

  @Test
  func `moves to next letter if prior letter matches`() {
    var data = TrieDataReader(data: Data())
    data.reserve(matchEntries: 1)
    data.append("A", isWord: true, isLast: true, 2)
    data.append("S", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("AS").isWord)
    #expect(!sut.containsAndPrefixes("AS").isProperPrefix)
  }

  @Test
  func `recognizes when an accepted word could be extended`() {
    var data = TrieDataReader(data: Data())
    data.reserve(matchEntries: 1)
    data.append("B", isWord: false, isLast: true, 2)
    data.append("Y", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(!sut.containsAndPrefixes("B").isWord)
    #expect(sut.containsAndPrefixes("B").isProperPrefix)
  }

  @Test
  func `finds alternatives for the second letter`() {
    var data = TrieDataReader(data: Data())
    data.reserve(matchEntries: 1)
    data.append("B", isWord: false, isLast: true, 2)
    data.append("E", isWord: true, isLast: false, 0)
    data.append("Y", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("BY").isWord)
    #expect(!sut.containsAndPrefixes("BY").isProperPrefix)
  }
}
