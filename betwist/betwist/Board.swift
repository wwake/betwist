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

  func isClose(_ index1: Int, _ index2: Int, wrap: Int) -> Bool {
    let rowDistance = abs(index1 - index2)
    let rowIsClose = rowDistance <= 1 || rowDistance == wrap - 1
    return rowIsClose
  }

  func hasNeighbors(_ location1: Location, _ location2: Location) -> Bool {
    if location1 == location2 {
      return false
    }

    return isClose(location1.row, location2.row, wrap: size) && isClose(location1.column, location2.column, wrap: size)
  }
}
