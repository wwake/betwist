@testable import betwist
import Testing

struct ATrie {
  let wordEnd = Trie(isWord: true, next: [])

  @Test
  func returns_isWord_flag_for_empty_string_() async throws {
    #expect(Trie(isWord: true, next: []).containsAndPrefixes("") == SearchResult(isWord: true, isProperPrefix: false))
    #expect(Trie(isWord: false, next: []).containsAndPrefixes("") == SearchResult(isWord: false, isProperPrefix: false))
  }

  @Test
  func doesnt_contain_string_with_mismatched_letter() {
    let trie = Trie(isWord: false, next: [("S", wordEnd)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: false, isProperPrefix: false))
  }

  @Test
  func contains_string_with_last_letter_available() {
    let wordEnd = Trie(isWord: true, next: [])
    let trie = Trie(isWord: false, next: [("I", wordEnd), ("A", wordEnd)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: true, isProperPrefix: false))
  }

  @Test
  func is_prefix_when_more_letters_after_found_word() {
    let wordEnd = Trie(isWord: true, next: [])
    let allowsS = Trie(isWord: true, next: [("S", wordEnd)])
    let trie = Trie(isWord: false, next: [("A", allowsS)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: true, isProperPrefix: true))
  }

  @Test
  func is_prefix_when_more_letters_after_unfound_word() {
    let wordEnd = Trie(isWord: true, next: [])
    let allowsS = Trie(isWord: false, next: [("S", wordEnd)])
    let trie = Trie(isWord: false, next: [("I", wordEnd), ("A", allowsS)])
    #expect(trie.containsAndPrefixes("A") == SearchResult(isWord: false, isProperPrefix: true))
  }
}
