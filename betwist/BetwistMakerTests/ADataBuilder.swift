import Testing

@testable import BetwistMaker

struct ADataBuilder {
  @Test
  func convert_empty_word_list_to_buffer() {
    let data = DataBuilder().make(trie: MakerTrie(next: []))
    #expect(data[quadbyte: 0] == 0x00ffffff)
  }

  @Test
  func convert_single_word_to_buffer() {
    let trie = TrieBuilder().add(["A"]).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[quadbyte: 0] == 0x00ffffff)
    #expect(data[quadbyte: 1] == 0xC1000000)   // end of list = true, lowercase 'a', isWord
    #expect(data[quadbyte: 2] == 0x00ffffff)
  }

  @Test
  func convert_multiple_words_to_buffer() {
    let words = ["BE", "BED", "BET", "AS"]
    let trie = TrieBuilder().add(words).root
    let sut = DataBuilder()

    let data = sut.make(trie: trie)

    #expect(data[quadbyte: 0] == 0x00ffffff)
    #expect(data[quadbyte: 1] == 0x42000010)    // 'B'
    #expect(data[quadbyte: 2] == 0xA1000024)    // 'A', last match
    #expect(data[quadbyte: 3] == 0x00ffffff)    // fail

    #expect(data[quadbyte: 4] == 0xC5000018)    // 'e', last match
    #expect(data[quadbyte: 5] == 0x00ffffff)    // fail

    #expect(data[quadbyte: 6] == 0x64000000)    // 'd'
    #expect(data[quadbyte: 7] == 0xD4000000)    // 't', last match
    #expect(data[quadbyte: 8] == 0x00ffffff)    // fail

    #expect(data[quadbyte: 9] == 0xD3000000)    // 's', last match
    #expect(data[quadbyte: 10] == 0x00ffffff)    // fail
  }
}
