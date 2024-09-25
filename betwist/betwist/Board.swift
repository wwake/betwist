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

  func hasNeighbors(_ location1: Location, _ location2: Location) -> Bool {
    abs(location1.row - location2.row) <= 1
      &&
    abs(location1.column - location2.column) <= 1
  }
}
