//
//  MakerTrie.swift
//  betwist
//
//  Created by Bill Wake on 5/20/26.
//


class MakerTrie {
  var next: [MakerMatch]

  init(next: [MakerMatch]) {
    self.next = next
  }
}

struct MakerMatch {
  let char: Character
  var isWord: Bool
  let trie: MakerTrie

  init(_ char: Character, _ trie: MakerTrie) {
    self.char = char
    self.isWord = false
    self.trie = trie
  }
}
