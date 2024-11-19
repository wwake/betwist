struct GameMaker {
  let size: Int

  let letterDice = [
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

  init(_ size: Int) {
    self.size = size
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
      .map { string in Array(string).randomElement()! }
      .map { String($0) }
  }
}
