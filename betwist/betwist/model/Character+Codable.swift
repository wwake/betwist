extension Character: @retroactive Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let s = try container.decode(String.self)
    // if it's not a single character, use code FFFF to indicate illegal value
    self = s.count == 1 ? s.first! : "\u{FFFF}"
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(String(describing: self))
  }
}
