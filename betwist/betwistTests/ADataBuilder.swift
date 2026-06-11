import Testing

@testable import betwist

struct ADataBuilder {
  @Test
  func convert_single_word_to_buffer() {
    let trie = TrieBuilder().add(["A"]).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[quadbyte: 0] == 0x00ffffff)
    #expect(data[quadbyte: 1] == 0xE1000000)   // lowercase 'a', last match
  }

  @Test
  func convert_multiple_words_to_buffer() {
    let words = ["BE", "BED", "BET", "AS"]
    let trie = TrieBuilder().add(words).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[quadbyte: 0] == 0x00ffffff)
    #expect(data[quadbyte: 1] == 0x4200000C)    // 'B'
    #expect(data[quadbyte: 2] == 0xC1000018)    // 'A'

    #expect(data[quadbyte: 3] == 0xE5000010)    // 'e'

    #expect(data[quadbyte: 4] == 0x64000000)    // 'd'
    #expect(data[quadbyte: 5] == 0xF4000000)    // 't'

    #expect(data[quadbyte: 6] == 0xF3000000)    // 's'
  }
}
