import Testing

@testable import TrieGenerator

struct ADataBuilder {
  @Test
  func `convert single word to buffer`() {
    let trie = TrieBuilder().add(["A"]).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[matchEntry: 0] == 0x000000)
  }

  @Test
  func `jump address uses 3 bytes`() {
    let sut = DataBuilder()
    let bytes = sut.asJumpAddress(0x010203)
    #expect(bytes == [0x01, 0x02, 0x03])
  }

  @Test
  func `convert multiple words to buffer`() {
    let words = ["BE", "BED", "BET", "AS"].sorted()
    let trie = TrieBuilder().add(words).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[matchEntry: 0] == 0x000002)    // 'A'
    #expect(data[matchEntry: 1] == 0x000003)    // 'B', last match

    #expect(data[matchEntry: 2] == 0xF30000)    // 's', last match

    #expect(data[matchEntry: 3] == 0xE50001)    // 'e', last match

    #expect(data[matchEntry: 4] == 0x640000)    // 'd'
    #expect(data[matchEntry: 5] == 0xF40000)    // 't', last match
  }
}
