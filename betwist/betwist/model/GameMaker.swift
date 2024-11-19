struct GameMaker {
  let size: Int
  var count = 0

  let candidates =
"AAAAAABBCCDDDEEEEEEEEEEEFFGGHHHHHIIIIIIJKLLLLMMNNNNNNOOOOOOOPPQRRRRSSSSSSTTTTTTTTTUUUVVWWWXYYYZ"

  init(_ size: Int) {
    self.size = size
  }

  mutating func next() -> String? {
    if count + 1 > size * size { return nil }
    count += 1
    return String(candidates.randomElement()!)
  }

  func make() -> [String] {
    var result = [String]()

    (1...(size * size)).forEach { _ in
      result.append(String(candidates.randomElement()!))
    }

    return result
  }
}
