import Foundation
import Testing

@testable import betwist

struct ATrie {
  @Test
  func `matches the last letter`() {
    var data = TrieDataReader(data: Data())
    data.appendAddress(1)
    data.append("D", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("AD").isWord)
    #expect(!sut.containsAndPrefixes("AD").isProperPrefix)
  }

  @Test
  func `moves to next letter if prior letter matches`() {
    var data = TrieDataReader(data: Data())
    data.appendAddress(1)
    data.append("S", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("AS").isWord)
    #expect(!sut.containsAndPrefixes("AS").isProperPrefix)
  }

  @Test
  func `tries alternatives for a letter`() {
    var data = TrieDataReader(data: Data())
    data.appendAddress(0)
    data.appendAddress(2)
    data.append("A", isWord: true, isLast: false, 0)
    data.append("E", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("BE").isWord)
    #expect(!sut.containsAndPrefixes("BE").isProperPrefix)
  }

  @Test
  func `recognizes when an accepted word could be extended`() {
    var data = TrieDataReader(data: Data())
    data.appendAddress(1)
    data.append("Y", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(!sut.containsAndPrefixes("B").isWord)
    #expect(sut.containsAndPrefixes("B").isProperPrefix)
  }

  @Test
  func `finds alternatives for the second letter`() {
    var data = TrieDataReader(data: Data())
    data.appendAddress(0)
    data.appendAddress(2)
    data.append("E", isWord: true, isLast: false, 0)
    data.append("Y", isWord: true, isLast: true, 0)

    let sut = Trie(data: data)

    #expect(sut.containsAndPrefixes("BY").isWord)
    #expect(!sut.containsAndPrefixes("BY").isProperPrefix)
  }

  @Test
  func `one-letter target isn't a word but is a valid prefix`() {
    let data = TrieDataReader(data: Data())
    let sut = Trie(data: data)

    #expect(!sut.containsAndPrefixes("R").isWord)
    #expect(sut.containsAndPrefixes("R").isProperPrefix)
  }
}
