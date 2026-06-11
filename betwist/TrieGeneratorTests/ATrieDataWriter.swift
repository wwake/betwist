import Foundation
import Testing
@testable import TrieGenerator

struct ATrieDataWriter {
  @Test
  func `creates a match entry`() {
    var sut = TrieDataWriter(data: Data())
    sut.append("A", true, 0x1234)

    #expect(sut[quadbyte: 0] == 0x61001234)
  }

  @Test
  func `accesses byte at position`() {
    var sut = TrieDataWriter(data: Data())
    sut.append(bytes: [0x01, 0x02])

    #expect(sut[byte: 0] == 0x01)
    #expect(sut[byte: 1] == 0x02)
  }

  @Test
  func `accesses quadbyte at position`() {
    var sut = TrieDataWriter(data: Data())
    sut.append(bytes: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

    #expect(sut[quadbyte: 0] == 0x01020304)
    #expect(sut[quadbyte: 4] == 0x05060708)
  }

  func `reserves quadbytes by filling with 0s`() {
    var sut = TrieDataWriter(data: Data())
    sut.append(bytes: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

    sut.reserve(quadbytes: 2)

    #expect(sut[quadbyte: 0] == 0x01020304)
    #expect(sut[quadbyte: 1] == 0x05060708)
    #expect(sut[quadbyte: 2] == 0)
    #expect(sut[quadbyte: 3] == 0)
  }

  @Test
  func `overwrites bytes at position`() {
    var sut = TrieDataWriter(data: Data())
    sut.append(bytes: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

    sut.overwrite(at: 4, bytes: [0x0a, 0x0b])
    #expect(sut[quadbyte: 4] == 0x0a0b0708)
  }
}
