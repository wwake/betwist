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
  internal var values = [Answer]()
  fileprivate var answersByLength = [Int: [Answer]]()

  mutating func submit(_ word: String, isPrefix: Bool) {
    if contains(word) {
      return
    }

    let answer = Answer(word: word, enteredByUser: !isPrefix)
    values.insert(answer, at: 0)

    var priorAnswers = answersByLength[word.count] ?? []
    priorAnswers.append(answer)
    answersByLength.updateValue(priorAnswers, forKey: word.count)
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
    answersByLength.keys.sorted().reversed()
  }

  func words(ofSize: Int) -> [Answer] {
    let words = answersByLength[ofSize]
    if words == nil { return [] }

    return words!.sorted { $0.word < $1.word }
  }
}

extension Answers: Equatable { }
