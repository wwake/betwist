@testable import betwist
import TrieGenerator

extension Vocabulary {
  convenience init(_ words: [String]) {
    let everyLetter = [
      "AZ", "BZ", "CZ", "DZ", "EZ", "FZ", "GZ", "HZ", "IZ", "JZ",
      "KZ", "LZ", "MZ", "NZ", "OZ", "PZ", "QZ", "RZ", "SZ", "TZ", 
      "UZ", "VZ", "WZ", "XZ", "YZ", "ZZ",
    ]

    let dictionary = everyLetter + words
    let uppercaseWords = dictionary.map { String($0).uppercased() }
    let root = TrieBuilder().add(uppercaseWords).root
    let data = DataBuilder().make(trie: root)
    self.init(Trie(data: TrieDataReader(data: data)))
  }
}
