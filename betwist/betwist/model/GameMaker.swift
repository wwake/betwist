struct GameMaker {
  let size: Int

  var letterDice = [
    "AAEEGN",
    "ABBJOO",
    "ACHOPS",
    "AFFKPS",
    "AOOTTW",
    "CIMOTU",
    "DEILRX",
    "DELRVY",
    "DISTTY",
    "EEGHNW",
    "EEINSU",
    "EHRTVW",
    "EIOSST",
    "ELRTTY",
    "HIMNUQ",
    "HLNNRZ",
  ]

  let candidates =
  "AAAAAABBCCDDDEEEEEEEEEEEFFGGHHHHHIIIIIIJKLLLLMMNNNNNNOOOOOOOPPQRRRRSSSSSSTTTTTTTTTUUUVVWWWXYYYZ"

  init(_ size: Int, _ dice: [String]? = nil) {
    self.size = size
    if dice != nil {
      self.letterDice = dice!
    }
  }

  func makeRandom() -> String {
    String(candidates.randomElement()!)
  }

  func make() -> [String] {
    var dice = [String]()
    let square = size * size

    for _ in 0..<(square / letterDice.count) {
      dice.append(contentsOf: letterDice)
    }

    for _ in 0..<(square % letterDice.count) {
      dice.append(letterDice.randomElement()!)
    }

    return dice
      .shuffled()
      .map { die in Array(die).randomElement()! }
      .map { $0 == "Q" ? "QU" : String($0) }
  }
}
