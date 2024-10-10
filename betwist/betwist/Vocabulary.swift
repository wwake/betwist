class Vocabulary {
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
    let (contained, _) = containsAndPrefixes(word)
    return contained
  }

  func hasPrefix(_ prefix: String) -> Bool {
    let (_, prefixed) = containsAndPrefixes(prefix)
    return prefixed
  }

  func containsAndPrefixes(_ target: String) -> (Bool, Bool) {
    let index = binarySearchIndex(target, words)

    if index >= words.count { return (false, false) }

    if words[index] == target {
      if index + 1 >= words.count { return (true, false) }
      return (true, words[index + 1].starts(with: target))
    }

    return (false, words[index].starts(with: target))
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
