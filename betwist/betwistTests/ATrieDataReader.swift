@testable import betwist
import Foundation

import Testing

struct ATrieDataReader {
  @Test
  func `creates a match entry`() {
    var sut = TrieDataReader(data: Data())
    sut.append("A", true, 0x1234)

    #expect(sut[quadbyte: 0] == 0x61001234)
  }

  @Test
  func `accesses byte at position`() {
    var sut = TrieDataReader(data: Data())
    sut.append(bytes: [0x01, 0x02])

    #expect(sut[byte: 0] == 0x01)
    #expect(sut[byte: 1] == 0x02)
  }

  @Test
  func `accesses quadbyte at position`() {
    var sut = TrieDataReader(data: Data())
    sut.append(bytes: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

    #expect(sut[quadbyte: 0] == 0x01020304)
    #expect(sut[quadbyte: 4] == 0x05060708)
  }

  func `reserves quadbytes by filling with 0s`() {
    var sut = TrieDataReader(data: Data())
    sut.append(bytes: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

    sut.reserve(quadbytes: 2)

    #expect(sut[quadbyte: 0] == 0x01020304)
    #expect(sut[quadbyte: 1] == 0x05060708)
    #expect(sut[quadbyte: 2] == 0)
    #expect(sut[quadbyte: 3] == 0)
  }

  @Test
  func `overwrites bytes at position`() {
    var sut = TrieDataReader(data: Data())
    sut.append(bytes: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

    sut.overwrite(at: 4, bytes: [0x0a, 0x0b])
    #expect(sut[quadbyte: 4] == 0x0a0b0708)
  }

  @Test
  func `recognizes an end mark`() {
    var sut = TrieDataReader(data: Data())
    sut.reserve(quadbytes: 1)
    sut.append("A", false, 0x654321)
    #expect(sut.isEndMark(at: 0))
    #expect(!sut.isEndMark(at: 4))
  }

  @Test
  func `knows character at position`() {
    var sut = TrieDataReader(data: Data())
    sut.reserve(quadbytes: 1)
    sut.append("A", false, 0x654321)
    sut.append("Z", true, 0x654321)
    #expect(sut.character(at: 0) == 0)
    #expect(sut.character(at: 4) == 0x41)
    #expect(sut.character(at: 8) == 0x5A)
  }

  @Test
  func `knows whether position completes word`() {
    var sut = TrieDataReader(data: Data())
    sut.reserve(quadbytes: 1)
    sut.append("A", false, 0x654321)
    sut.append("Z", true, 0x654321)
    #expect(!sut.completesWord(at: 0))
    #expect(!sut.completesWord(at: 4))
    #expect(sut.completesWord(at: 8))
  }

  @Test
  func `knows address at position`() {
    var sut = TrieDataReader(data: Data())
    sut.reserve(quadbytes: 1)
    sut.append("A", false, 0x654321)
    #expect(sut.address(at: 4) == 0x654321)
  }

  @Test
  func `knows whether word is a valid prefix`() {
    var sut = TrieDataReader(data: Data())
    sut.reserve(quadbytes: 1)
    sut.append("A", true, 0)
    sut.append("B", false, 16)
    sut.reserve(quadbytes: 1)
    sut.append("Y", true, 0)
    sut.reserve(quadbytes: 1)

    #expect(!sut.canExtend(at: 4))
    #expect(sut.canExtend(at: 8))
  }
}
