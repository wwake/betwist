struct Score: Equatable {
  var wordCount: Int
  var letterCount: Int
  var mostLetters: Int

  init(wordCount: Int, letterCount: Int, mostLetters: Int) {
    self.wordCount = wordCount
    self.letterCount = letterCount
    self.mostLetters = mostLetters
  }
}
