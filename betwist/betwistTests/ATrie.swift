@testable import betwist
import Foundation
import Testing

struct ATrie {
  let wordEnd = Trie([])

  @Test
  func returns_isWord_flag_for_empty_string_() async throws {
    #expect(Trie([]).containsAndPrefixes("") == SearchResult(isWord: false, isProperPrefix: false))
  }

  @Test
  func doesnt_contain_string_with_mismatched_letter() {
    let trie = Trie([TrieMatch("S", true, wordEnd)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: false, isProperPrefix: false))
  }

  @Test
  func contains_string_with_last_letter_available() {
    let trie = Trie([TrieMatch("I", true, wordEnd), TrieMatch("A", true, wordEnd)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: true, isProperPrefix: false))
  }

  @Test
  func is_prefix_when_more_letters_after_found_word() {
    let allowsS = Trie([TrieMatch("S", true, wordEnd)])
    let trie = Trie([TrieMatch("A", true, allowsS)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: true, isProperPrefix: true))
  }

  @Test
  func is_prefix_when_more_letters_after_unfound_word() {
    let allowsS = Trie([TrieMatch("S", true, wordEnd)])
    let trie = Trie([TrieMatch("I", false, wordEnd), TrieMatch("A", false, allowsS)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: false, isProperPrefix: true))
  }

  @Test
  func `data can provide 4 bytes at a time`() {
    var sut = Data()
    sut.append(contentsOf: [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])
    #expect(sut[quadbyte: 1] == 0x05060708)
  }

  @Test
  func convert_empty_word_list_to_buffer() {
    let data = TrieBuilder().makeData()
    #expect(data[quadbyte: 0] == 0x00ffffff)
  }

  @Test
  func convert_single_word_to_buffer() {
    let data = TrieBuilder().add(["A"]).makeData()
    #expect(data[quadbyte: 0] == 0x00ffffff)
    #expect(data[quadbyte: 1] == 0x61000000)   // lowercase 'a' => end of word
    #expect(data[quadbyte: 2] == 0x00ffffff)
  }

  @Test
  func convert_multiple_words_to_buffer() {
    let words = ["BE", "BED", "BET", "AS"]
    let data = TrieBuilder().add(words).makeData()

    #expect(data[quadbyte: 0] == 0x00ffffff)
    #expect(data[quadbyte: 1] == 0x42000010)    // 'B'
    #expect(data[quadbyte: 2] == 0x41000024)    // 'A'
    #expect(data[quadbyte: 3] == 0x00ffffff)    // fail

    #expect(data[quadbyte: 4] == 0x65000018)    // 'e'
    #expect(data[quadbyte: 5] == 0x00ffffff)    // fail

    #expect(data[quadbyte: 6] == 0x64000000)    // 'd'
    #expect(data[quadbyte: 7] == 0x74000000)    // 't'
    #expect(data[quadbyte: 8] == 0x00ffffff)    // fail

    #expect(data[quadbyte: 9] == 0x73000000)    // 's'
    #expect(data[quadbyte: 10] == 0x00ffffff)    // fail
  }

  @Test
  func convert_empty_word_list_to_empty_trie() {
    let trie = TrieBuilder().make()
    #expect(trie.next.isEmpty)
  }

  @Test
  func built_from_one_letter() {
    let trie = TrieBuilder().add(["A"]).make()
    #expect(trie.next.count == 1)
    #expect(trie.next[0].char == "A")
    #expect(trie.next[0].isWord)
    #expect(trie.next[0].trie.next.isEmpty)
  }

  @Test
  func built_from_two_letters() {
    let trie = TrieBuilder().add(["AS"]).make()
    #expect(trie.next.count == 1)
    #expect(trie.next[0].char == "A")
    #expect(!trie.next[0].isWord)
    #expect(trie.next[0].trie.next[0].char == "S")
    #expect(trie.next[0].trie.next[0].isWord)
  }

  @Test
  func handles_a_large_word() {
    let trie = TrieBuilder().add(["ASKING"]).make()
    let searchResult1 = trie.containsAndPrefixes("ASKING")
    #expect(searchResult1.isWord)
    #expect(!searchResult1.isProperPrefix)

    let searchResult2 = trie.containsAndPrefixes("ASK")
    #expect(!searchResult2.isWord)
    #expect(searchResult2.isProperPrefix)

    let searchResult3 = trie.containsAndPrefixes("ANSWER")
    #expect(!searchResult3.isWord)
    #expect(!searchResult3.isProperPrefix)
  }

  @Test
  func builds_with_two_nonoverlapping_words() {
    let trie = TrieBuilder().add(["ASKING", "BET"]).make()
    let searchResult1 = trie.containsAndPrefixes("ASKING")
    #expect(searchResult1.isWord)
    #expect(!searchResult1.isProperPrefix)

    let searchResult2 = trie.containsAndPrefixes("BET")
    #expect(searchResult2.isWord)
    #expect(!searchResult2.isProperPrefix)

    let searchResult3 = trie.containsAndPrefixes("OCTOBER")
    #expect(!searchResult3.isWord)
    #expect(!searchResult3.isProperPrefix)
  }

  @Test
  func builds_with_two_overlapping_words_longest_first() {
    let trie = TrieBuilder().add(["ASKING", "ASK"]).make()
    let searchResult1 = trie.containsAndPrefixes("ASKING")
    #expect(searchResult1.isWord)
    #expect(!searchResult1.isProperPrefix)

    let searchResult2 = trie.containsAndPrefixes("ASK")
    #expect(searchResult2.isWord)
    #expect(searchResult2.isProperPrefix)

    let searchResult3 = trie.containsAndPrefixes("ASKIN")
    #expect(!searchResult3.isWord)
    #expect(searchResult3.isProperPrefix)
  }

  @Test
  func builds_with_two_overlapping_words_shortest_first() {
    let trie = TrieBuilder().add(["ASK", "ASKING"]).make()
    let searchResult1 = trie.containsAndPrefixes("ASKING")
    #expect(searchResult1.isWord)
    #expect(!searchResult1.isProperPrefix)

    let searchResult2 = trie.containsAndPrefixes("ASK")
    #expect(searchResult2.isWord)
    #expect(searchResult2.isProperPrefix)

    let searchResult3 = trie.containsAndPrefixes("ASKIN")
    #expect(!searchResult3.isWord)
    #expect(searchResult3.isProperPrefix)
  }

  @Test
  func convert_word_list_to_trie() {
    let words = ["BE", "BED", "BET", "AS"]
    let trie = TrieBuilder().add(words).make()

    words.forEach { word in
      let result = trie.containsAndPrefixes(word)
      #expect(result.isWord)
    }
  }
}
