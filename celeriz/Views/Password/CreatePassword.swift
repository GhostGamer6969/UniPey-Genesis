import SwiftUI

struct CreatePassword: View {
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
                    Text("Create your password")
                        .font(.custom("Inter", size: 24).bold())
                        .foregroundColor(Color("primary"))
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 20) // Pushed towards the top
               
                
                Spacer().frame(height: 20)
                
                
                
                // Input Fields with reduced padding
                Group {
                    CustomTextField(text: $firstName, placeholder: "Password")
                        .padding(.horizontal, 20)
                    
                    CustomTextField(text: $lastName, placeholder: "Confirm Password")
                        .padding(.horizontal, 10)
                    
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

struct CreatePassword_Previews: PreviewProvider {
    static var previews: some View {
        CreatePassword()
    }
}
