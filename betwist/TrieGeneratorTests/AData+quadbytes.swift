import Foundation
import Testing
@testable import TrieGenerator

struct AData_quadbytes {
  @Test
  func `data can provide 4 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])
    #expect(sut[quadbyte: 1] == 0x05060708)
  }

  @Test
  func `data can reserve 4 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01])

    sut.reserve(quadbytes: 2)

    #expect(sut.count == 9)
    #expect(sut[quadbyte: 0] == 0x01000000)
    #expect(sut[quadbyte: 1] == 0x00000000)
    #expect(sut[8] == 0)
  }

  @Test
  func `data can overwrite quadbytes`() {
    var sut = Data()
    sut.append(contentsOf: [0x01])
    sut.reserve(quadbytes: 2)
    sut.append(contentsOf: [0x02, 0x03, 0x04])

    sut.overwriteQuad(index: 1, [0xbe, 0xad, 0xed, 0x99])

    #expect(sut.count == 12)
    #expect(sut[quadbyte: 0] == 0x01beaded)
    #expect(sut[quadbyte: 1] == 0x99000000)
    #expect(sut[quadbyte: 2] == 0x00020304)
  }
}
