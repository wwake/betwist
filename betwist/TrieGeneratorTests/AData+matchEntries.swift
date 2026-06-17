import Foundation
import Testing
@testable import TrieGenerator

struct AData_matchEntries {
  @Test
  func `data can provide 3 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])
    #expect(sut[matchEntry: 1] == 0x040506)
  }

  @Test
  func `data can reserve 3 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01])

    sut.reserve(matchEntries: 2)

    #expect(sut.count == 7)
    #expect(sut[matchEntry: 0] == 0x010000)
    #expect(sut[matchEntry: 1] == 0x000000)
    #expect(sut[6] == 0)
  }

  @Test
  func `data can overwrite bytes`() {
    var sut = Data()
    sut.append(contentsOf: [0x01])
    sut.reserve(matchEntries: 1)
    sut.append(contentsOf: [0x02, 0x03, 0x04, 05, 06])
        // 01 00 00, 00 02 03, 04 05 06

    sut.overwriteBytes(matchEntry: 1, [0xbe, 0xad, 0xed])

    #expect(sut.count == 9)
    #expect(sut[matchEntry: 0] == 0x010000)
    #expect(sut[matchEntry: 1] == 0xbeaded)
    #expect(sut[matchEntry: 2] == 0x040506)
  }
}
