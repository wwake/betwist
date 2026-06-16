@testable import betwist
import Foundation

import Testing

struct ATrieDataReader {
  @Test
  func `knows character at position`() {
    let ignoredAddress = 124
    var sut = TrieDataReader(data: Data())
    sut.append("A", isWord: false, isLast: false, ignoredAddress)
    sut.append("Z", isWord: true, isLast: true, ignoredAddress)
    #expect(sut.character(row: 0) == 0x41)
    #expect(sut.character(row: 1) == 0x5A)
  }

  @Test
  func `knows index of trie for given first letter`() {
    var sut = TrieDataReader(data: Data())
    sut.append("A", isWord: false, isLast: false, 2)
    sut.append("B", isWord: false, isLast: true, 3)
    // omit C-Z; won't affect test
    sut.append("T", isWord: true, isLast: true, 0)
    sut.append("A", isWord: true, isLast: true, 0)

    #expect(sut.base("A") == 2)
    #expect(sut.base("B") == 3)
  }

  @Test
  func `knows whether position completes word`() {
    let ignoredAddress = 124
    var sut = TrieDataReader(data: Data())
    sut.append("A", isWord: false, isLast: false, ignoredAddress)
    sut.append("Z", isWord: true, isLast: true, ignoredAddress)
    #expect(!sut.completesWord(row: 0))
    #expect(sut.completesWord(row: 1))
  }

  @Test
  func `knows address at position`() {
    var sut = TrieDataReader(data: Data())
    sut.reserve(matchEntries: 1)
    sut.append("A", isWord: false, isLast: false, 4444)
    #expect(sut.address(row: 1) == 4444)
  }

  @Test
  func `knows whether word is a valid prefix`() {
    var sut = TrieDataReader(data: Data())
    sut.append("A", isWord: true, isLast: false, 0)
    sut.append("B", isWord: false, isLast: true, 8)
    sut.append("Y", isWord: true, isLast: true, 0)

    #expect(!sut.canExtend(row: 0))
    #expect(sut.canExtend(row: 1))
  }
}
