struct Guesses {
  var guesses = [String]()

  mutating func prepend(_ guess: String) {
    guesses.removeAll { $0 == guess }
    guesses.insert(guess, at: 0)
  }

  var isEmpty: Bool {
    guesses.isEmpty
  }
}

extension Guesses: CustomStringConvertible {
  public var description: String {
    String(guesses.joined(by: "\n"))
  }
}
