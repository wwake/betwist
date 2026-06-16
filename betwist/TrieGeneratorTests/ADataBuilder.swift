import Testing

@testable import TrieGenerator

struct ADataBuilder {
  @Test
  func `convert single word to buffer`() {
    let trie = TrieBuilder().add(["A"]).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[matchEntry: 0] == 0x00000000)   // end of list = true, lowercase 'a', isWord
  }

  @Test
  func `convert multiple words to buffer`() {
    let words = ["BE", "BED", "BET", "AS"].sorted()
    let trie = TrieBuilder().add(words).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[matchEntry: 0] == 0x00000002)    // 'A'
    #expect(data[matchEntry: 1] == 0x00000003)    // 'B', last match

    #expect(data[matchEntry: 2] == 0xF3000000)    // 's', last match

    #expect(data[matchEntry: 3] == 0xE5000001)    // 'e', last match

    #expect(data[matchEntry: 4] == 0x64000000)    // 'd'
    #expect(data[matchEntry: 5] == 0xF4000000)    // 't', last match

  }
}
