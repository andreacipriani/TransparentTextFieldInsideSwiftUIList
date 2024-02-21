import SwiftUI

struct ContentView: View {
    @State private var items = ["Solution 1"]
    @State private var solution2Items = ["Solution 2"]
  
    var body: some View {
        VStack {
            List {
                ForEach(items.indices, id: \.self) { index in
                    EditableRow(text: $items[index])
                    .background(.blue)
                }
                ForEach(solution2Items.indices, id: \.self) { index in
                  CustomTextField(stringValue: solution2Items[index])
                    .frame(minHeight: 50.0)
                    .background(.green)
                }
            }
            .frame(width: 300, height: 200)
          CustomTextField(stringValue: "This is outside the list")
            .frame(minHeight: 50.0)
            .background(.green)
            .frame(maxWidth: 200.0)
        }
        .padding()
    }
}

// Solution 1: using standard TextField

struct EditableRow: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(.plain)
            .background(Color.clear)
            .padding()
      
    }
}

// Solution 1: using a custom textfield (this works outside a list)

struct CustomTextField: NSViewRepresentable {
  private var stringValue: String

  init(
    stringValue: String
  ) {
    self.stringValue = stringValue
  }
  
  func makeNSView(context: Context) -> NSTextField {
    let textField = NSTextField()
    textField.stringValue = stringValue

    // Make the background transparent
    textField.drawsBackground = false
    textField.isBezeled = false // SwiftUI bug: this doesn't work if a TextField is rendered in a list
    return textField
  }
  
  func updateNSView(_ nsView: NSTextField, context: Context) {
    nsView.stringValue = stringValue
  }
}
