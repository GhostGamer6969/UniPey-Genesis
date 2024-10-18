import SwiftUI

struct CreateAccount: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var dateOfBirth: String = ""

    var body: some View {
        ZStack {
            Color("bgColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title Text at the top
                HStack {
                    Text("Create an account")
                        .font(.custom("Inter", size: 24).bold())
                        .foregroundColor(Color("primary"))
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 20) // Pushed towards the top
                .padding(.bottom, 40)
                
                Spacer().frame(height: 20)
                
                // Profile image with country flag
                ZStack(alignment: .bottomTrailing) {
                    Image("profile") // Placeholder for user profile image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                    
                    // Country flag at the bottom right of profile image
                    Image("France") // Replace with your flag image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle()) // Optional, depending on the flag shape
                        .offset(x: -10, y: -25) // Adjust position as needed
                }
                .padding(.bottom, 20)
                
                // Input Fields with reduced padding
                Group {
                    CustomTextField(text: $firstName, placeholder: "First Name")
                        .padding(.horizontal, 20)
                    
                    CustomTextField(text: $lastName, placeholder: "Last Name")
                        .padding(.horizontal, 20)
                    
                    CustomTextField(text: $email, placeholder: "E-mail ID")
                        .padding(.horizontal, 20)
                    
                    CustomTextField(text: $dateOfBirth, placeholder: "Date of Birth")
                        .padding(.horizontal, 20)
                }
                .padding(.vertical, 10) // Reduced vertical padding between fields
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 30)
                
                // Continue button directly below the last text field
                Button(action: {
                    print("Continue button pressed")
                }) {
                    Text("Continue")
                        .font(.custom("Merriweather", size: 20).bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: 274, maxHeight: 44)
                        .background(Color("primary"))
                        .cornerRadius(25)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 50) // Slight padding above the button
                
                Spacer() // Pushes content up if needed
            }
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
