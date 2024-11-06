@testable import betwist
import Testing

struct ATrie {
  let wordEnd = Trie(true, [])

  @Test
  func returns_isWord_flag_for_empty_string_() async throws {
    #expect(Trie(true, []).containsAndPrefixes("") == SearchResult(isWord: true, isProperPrefix: false))
    #expect(Trie(false, []).containsAndPrefixes("") == SearchResult(isWord: false, isProperPrefix: false))
  }

  @Test
  func doesnt_contain_string_with_mismatched_letter() {
    let trie = Trie(false, [TrieMatch("S", wordEnd)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: false, isProperPrefix: false))
  }

  @Test
  func contains_string_with_last_letter_available() {
    let wordEnd = Trie(true, [])
    let trie = Trie(false, [TrieMatch("I", wordEnd), TrieMatch("A", wordEnd)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: true, isProperPrefix: false))
  }

  @Test
  func is_prefix_when_more_letters_after_found_word() {
    let wordEnd = Trie(true, [])
    let allowsS = Trie(true, [TrieMatch("S", wordEnd)])
    let trie = Trie(false, [TrieMatch("A", allowsS)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: true, isProperPrefix: true))
  }

  @Test
  func is_prefix_when_more_letters_after_unfound_word() {
    let wordEnd = Trie(true, [])
    let allowsS = Trie(false, [TrieMatch("S", wordEnd)])
    let trie = Trie(false, [TrieMatch("I", wordEnd), TrieMatch("A", allowsS)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: false, isProperPrefix: true))
  }

  @Test
  func convert_empty_word_list_to_empty_trie() {
    let trie = TrieBuilder().make()
    #expect(!trie.isWord)
    #expect(trie.next.isEmpty)
  }

  @Test
  func built_from_one_letter() {
    let trie = TrieBuilder().add(["A"]).make()
    #expect(!trie.isWord)
    #expect(trie.next.count == 1)
    #expect(trie.next[0].char == "A")
    #expect(trie.next[0].trie.isWord)
    #expect(trie.next[0].trie.next.isEmpty)
  }

  @Test
  func built_from_two_letters() {
    let trie = TrieBuilder().add(["AS"]).make()
    #expect(!trie.isWord)
    #expect(trie.next.count == 1)
    #expect(trie.next[0].char == "A")
    #expect(!trie.next[0].trie.isWord)
    #expect(trie.next[0].trie.next[0].char == "S")
    #expect(trie.next[0].trie.next[0].trie.isWord)
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
