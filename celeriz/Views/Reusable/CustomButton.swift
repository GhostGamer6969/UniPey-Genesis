import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.custom("Merriweather", size: 20))
                .foregroundColor(.black) // Text color
                .frame(maxWidth: .infinity, minHeight: 50) // Adjust height and width
                .background(Color("primary"))
                .cornerRadius(20) // Rounded corners
                .padding(.horizontal, 16) // Padding for proper layout
                .frame(width: 374, height: 22) // Fixed width and height
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Preview Button") {
            print("Button pressed")
        }
    }
}
