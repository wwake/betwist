import Testing

@testable import TrieGenerator

struct ADataBuilder {
  @Test
  func convert_single_word_to_buffer() {
    let trie = TrieBuilder().add(["A"]).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[quadbyte: 0] == 0xE1000000)   // end of list = true, lowercase 'a', isWord
  }

  @Test
  func convert_multiple_words_to_buffer() {
    let words = ["BE", "BED", "BET", "AS"]
    let trie = TrieBuilder().add(words).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[quadbyte: 0] == 0x42000002)    // 'B'
    #expect(data[quadbyte: 1] == 0xC1000005)    // 'A', last match

    #expect(data[quadbyte: 2] == 0xE5000003)    // 'e', last match

    #expect(data[quadbyte: 3] == 0x64000000)    // 'd'
    #expect(data[quadbyte: 4] == 0xF4000000)    // 't', last match

    #expect(data[quadbyte: 5] == 0xF3000000)    // 's', last match
  }
}
