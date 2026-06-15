import Foundation
import Testing
@testable import TrieGenerator

struct AData_matchEntries {
  @Test
  func `data can provide 4 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])
    #expect(sut[matchEntry: 1] == 0x05060708)
  }

  @Test
  func `data can reserve 4 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01])

    sut.reserve(matchEntries: 2)

    #expect(sut.count == 9)
    #expect(sut[matchEntry: 0] == 0x01000000)
    #expect(sut[matchEntry: 1] == 0x00000000)
    #expect(sut[8] == 0)
  }

  @Test
  func `data can overwrite bytes`() {
    var sut = Data()
    sut.append(contentsOf: [0x01])
    sut.reserve(matchEntries: 2)
    sut.append(contentsOf: [0x02, 0x03, 0x04])

    sut.overwriteBytes(matchEntry: 1, [0xbe, 0xad, 0xed, 0x99])

    #expect(sut.count == 12)
    #expect(sut[matchEntry: 0] == 0x01000000)
    #expect(sut[matchEntry: 1] == 0xbeaded99)
    #expect(sut[matchEntry: 2] == 0x00020304)
  }
}
