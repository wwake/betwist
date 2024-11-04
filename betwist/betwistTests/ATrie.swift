@testable import betwist
import Testing

struct ATrie {
  @Test
  func returns_isWord_flag_for_empty_string_() async throws {
    #expect(Trie(isWord: true, next: []).contains(""))
    #expect(!Trie(isWord: false, next: []).contains(""))
  }

  @Test
  func doesnt_contain_string_with_mismatched_letter() {
    let wordEnd = Trie(isWord: true, next: [])
    let trie = Trie(isWord: false, next: [("S", wordEnd)])
    #expect(!trie.contains("A"))
  }

  @Test
  func contains_string_with_last_letter_available() {
    let wordEnd = Trie(isWord: true, next: [])
    let trie = Trie(isWord: false, next: [("I", wordEnd), ("A", wordEnd)])
    #expect(trie.contains("A"))
  }
}
