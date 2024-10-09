class Vocabulary {
  let words: [String]
 // let prefixToWords: [String: [String]]

  init(_ words: [String]) {
    self.words = words
//    self.prefixToWords = Dictionary(grouping: words) {
//      String($0.prefix(1))
//    }
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

  fileprivate func binarySearch(_ target: String, _ words: [String]) -> Int {
    var result = binarySearchIndex(target, words)
    if result >= words.count || words[result] != target {
        result = -1
    }
    return result
  }

  func contains(_ word: String) -> Bool {
  //  binarySearch(word, prefixToWords[String(word.prefix(1))] ?? []) >= 0
    binarySearch(word, words) >= 0
  }

  func hasPrefix(_ prefix: String) -> Bool {
    let index = binarySearchIndex(prefix, words)

    if index >= words.count { return false }

    if words[index] == prefix {
      if index + 1 >= words.count { return false }
      return words[index + 1].starts(with: prefix)
    }

    return words[index].starts(with: prefix)
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
