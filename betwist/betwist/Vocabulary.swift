class Vocabulary {
  let words: [String]
  //let wordSet: Set<String>
  var containsCount = 0
  var prefixCount = 0

  init(_ words: [String]) {
    self.words = words
//    self.wordSet = Set(words)
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
    let (contained, _) = containsAndPrefixes(word)
    return contained
//    containsCount += 1
//    return wordSet.contains(word)
  //  binarySearch(word, words) >= 0
  }

  func hasPrefix(_ prefix: String) -> Bool {
    prefixCount += 1
    let index = binarySearchIndex(prefix, words)

    if index >= words.count { return false }

    if words[index] == prefix {
      if index + 1 >= words.count { return false }
      return words[index + 1].starts(with: prefix)
    }

    return words[index].starts(with: prefix)
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
