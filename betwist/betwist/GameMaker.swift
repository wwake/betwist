struct GameMaker: Sequence, IteratorProtocol {
  let size: Int
  var count = 0

  let candidates =
"AAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOOPPQRRRRRSSSSTTTTTTUUUUVVWWXYZ"

  init(_ size: Int) {
    self.size = size
  }

  mutating func next() -> String? {
    if count + 1 > size * size { return nil }
    count += 1
    return String(candidates.randomElement()!)
  }
}
