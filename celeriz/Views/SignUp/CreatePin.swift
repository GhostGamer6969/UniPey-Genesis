import SwiftUI

struct CreatePin: View {
    @State private var enterPin = Array(repeating: "", count: 6) // For Enter Pin (6 digits)
    @State private var confirmPin = Array(repeating: "", count: 6) // For Confirm Pin (6 digits)
    
    var body: some View {
        VStack {
            Spacer()
            
            // Create your Transaction Pin Text
            Text("Create your Transaction Pin")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.bottom, 40)
            
            // Enter Pin Section
            VStack(alignment: .leading) {
                Text("Enter Pin")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                PinTextField(pinDigits: $enterPin)
            }
            .padding(.bottom, 20)
            
            // Confirm Pin Section
            VStack(alignment: .leading) {
                Text("Confirm Pin")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                PinTextField(pinDigits: $confirmPin)
            }
            .padding(.bottom, 40)
            
            // Create Pin Button
            Button(action: {
                // Handle Create Pin logic
                if enterPin == confirmPin {
                    print("Pin Created: \(enterPin.joined())")
                } else {
                    print("Pins do not match")
                }
            }) {
                Text("Create Pin")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

// Reusable component for Pin Entry
struct PinTextField: View {
    @Binding var pinDigits: [String]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: $pinDigits[index])
                    .frame(width: 40, height: 50)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onReceive(pinDigits[index].publisher.collect()) {
                        let value = String($0.prefix(1)) // Limit to 1 character
                        pinDigits[index] = value
                    }
            }
        }
    }
}

struct CreatePin_Previews: PreviewProvider {
    static var previews: some View {
        CreatePin()
    }
}
