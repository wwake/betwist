struct Guesses {
  var guesses = [String]()

  mutating func prepend(_ guess: String) {
    guesses.removeAll { $0 == guess }
    guesses.insert(guess, at: 0)
  }

  var isEmpty: Bool {
    guesses.isEmpty
  }

  var wordCount: Int {
    guesses.count
  }

  var letterCount: Int {
    guesses.reduce(0) { soFar, next in
      soFar + next.count
    }
  }

  var mostLetters: Int {
    guesses
      .map { $0.count }
      .max() ?? 0
  }
}

extension Guesses: Equatable { }

extension Guesses: CustomStringConvertible {
  public var description: String {
    String(guesses.joined(by: "\n"))
  }
}
