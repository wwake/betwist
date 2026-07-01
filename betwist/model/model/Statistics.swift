public struct Statistics: Equatable {
  public var wordCount: Int
  public var letterCount: Int
  public var mostLetters: Int

  public init(wordCount: Int, letterCount: Int, mostLetters: Int) {
    self.wordCount = wordCount
    self.letterCount = letterCount
    self.mostLetters = mostLetters
  }
}
