import Algorithms
import Foundation

struct Board {
  let size: Int
  let board: [[String]]

  init(_ size: Int, _ source: any Sequence<String>) {
    self.size = size

    self.board = Array(source).chunks(ofCount: size).map(Array.init)
  }

  subscript(_ row: Int, _ column: Int) -> String {
    board[row %% size][column %% size]
  }
}
