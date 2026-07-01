infix operator %% : MultiplicationPrecedence

extension Int {
  static func %% (index: Int, size: Int) -> Int {
    var wrappedIndex = index
    while wrappedIndex < 0 {
      wrappedIndex += size
    }
    return wrappedIndex % size
  }
}
