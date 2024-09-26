import SwiftUI

struct ContentView: View {
  @Binding var selection: Selection

  var body: some View {
    VStack {
      Text(selection.guess)

      ForEach(0..<selection.board.size, id: \.self) { row in
        HStack {
          ForEach(0..<selection.board.size, id: \.self) { column in
            Button("\(selection.board[row, column])") {
              selection.select(Location(row, column))
            }
          }
        }
      }
    }
    .padding()
  }
}

#Preview {
  @Previewable @State var selection = Selection(Board(2, ["A", "B", "C", "D"]))

  ContentView(selection: $selection)
}
