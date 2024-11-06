import Foundation
struct SearchResult: Equatable {
  let isWord: Bool
  let isProperPrefix: Bool
}

class Vocabulary {
  let trie: Trie

  init(_ words: [String]) {
//    trie = TrieBuilder().add(words).make()
//  }
//
//  init() {
    do {
      if let path = Bundle.main.path(forResource: "trie", ofType: "json") {
        let data = try String(contentsOfFile: path, encoding: .utf8).data(using: .utf8)
        trie = try JSONDecoder().decode(Trie.self, from: data!)
        print("done loading trie")
        return
      }
    } catch {
      print(error)
    }
    trie = Trie(false, [])
  }

  func contains(_ word: String) -> Bool {
    containsAndPrefixes(word).isWord
  }

  func containsAndPrefixes(_ target: String) -> SearchResult {
    trie.containsAndPrefixes(target)
  }
}

class Vocabulary2 {
  let words: [String]

  init(_ words: [String]) {
    self.words = words
  }

  fileprivate func binarySearchIndex(_ target: String, _ words: [String]) -> Int {
    var lower = -1
    var upper = words.count
    while lower + 1 != upper {
      let mid = (lower + upper) / 2
      if words[mid] < target {
        lower = mid
      } else {
        upper = mid
      }
    }
    return upper
  }

  // This is for a plain "contains" search (using the
  // "Programming Pearls" binary search - but we no longer use it.
  fileprivate func binarySearch(_ target: String, _ words: [String]) -> Int {
    var result = binarySearchIndex(target, words)
    if result >= words.count || words[result] != target {
      result = -1
    }
    return result
  }

  func contains(_ word: String) -> Bool {
    containsAndPrefixes(word).isWord
  }

  func containsAndPrefixes(_ target: String) -> SearchResult {
    let index = binarySearchIndex(target, words)

    if index >= words.count {
      return SearchResult(isWord: false, isProperPrefix: false)
    }

    if words[index] == target {
      if index + 1 >= words.count {
        return SearchResult(isWord: true, isProperPrefix: false)
      }
      return SearchResult(isWord: true, isProperPrefix: words[index + 1].starts(with: target))
    }

    return SearchResult(isWord: false, isProperPrefix: words[index].starts(with: target))
  }
}

class NullVocabulary: Vocabulary {
  init() {
    super.init([])
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
