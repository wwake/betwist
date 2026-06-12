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
    sut.reserve(quadbytes: 1)
    sut.append("A", isWord: false, isLast: false, 4444)
    #expect(sut.address(row: 1) == 1111)
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
