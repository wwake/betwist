import Foundation

struct Answer: Identifiable, Equatable {
  let id = UUID()
  let word: String
  let enteredByUser: Bool

  var count: Int {
    word.count
  }
}

struct Answers {
  var values = [Answer]()

  mutating func submit(_ word: String) {
    submit(word, enteredByUser: true)
  }

  mutating func submitPrefix(_ word: String) {
    submit(word, enteredByUser: false)
  }

  fileprivate mutating func submit(_ word: String, enteredByUser: Bool) {
    if contains(word) {
      return
    }

    let guess = Answer(word: word, enteredByUser: enteredByUser)
    values.insert(guess, at: 0)
  }

  var isEmpty: Bool {
    values.isEmpty
  }

  var wordCount: Int {
    values.count
  }

  var letterCount: Int {
    values.reduce(0) { soFar, answer in
      soFar + answer.count
    }
  }

  var mostLetters: Int {
    values
      .map { $0.count }
      .max() ?? 0
  }

  var preview: String {
    String(
      values
      .prefix(3)
      .map { $0.word }
      .joined(by: "\n")
    )
  }

  func contains(_ word: String) -> Bool {
    values.contains { $0.word == word }
  }

  var wordSizes: [Int] {
    values.grouped(by: \.count).keys.sorted().reversed()
  }

  func words(ofSize: Int) -> [Answer] {
    let words = values.grouped(by: \.count)[ofSize]
    if words == nil { return [] }

    return words!.sorted { $0.word < $1.word }
  }
}

extension Answers: Equatable { }
