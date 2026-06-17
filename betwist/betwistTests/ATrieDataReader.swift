@testable import betwist
import Foundation

import Testing

struct ATrieDataReader {
  @Test
  func `knows character at position`() {
    let ignoredAddress = 124
    var sut = TrieDataReader(data: Data())
    sut.appendAddress(1)
    sut.append("B", isWord: false, isLast: false, ignoredAddress)
    sut.append("Z", isWord: true, isLast: true, 0)
    #expect(sut.character(row: 1) == 0x42)
    #expect(sut.character(row: 2) == 0x5A)
  }

  @Test
  func `knows index of trie for given first letter`() {
    var sut = TrieDataReader(data: Data())
    sut.appendAddress(0x010203)
    #expect(sut.jumpAddress("A") == 0x010203)
  }

  @Test
  func `knows whether position completes word`() {
    let ignoredAddress = 124
    var sut = TrieDataReader(data: Data())
    sut.appendAddress(1)
    sut.append("Z", isWord: false, isLast: false, ignoredAddress)
    sut.append("B", isWord: true, isLast: true, ignoredAddress)
    #expect(!sut.completesWord(row: 1))
    #expect(sut.completesWord(row: 2))
  }

  @Test
  func `knows whether word is a valid prefix`() {
    var sut = TrieDataReader(data: Data())
    sut.appendAddress(1)
    sut.append("B", isWord: false, isLast: true, 3)
    sut.append("Y", isWord: true, isLast: true, 0)

    #expect(sut.canExtend(row: 1))
    #expect(!sut.canExtend(row: 2))
  }
}
