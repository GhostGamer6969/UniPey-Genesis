import SwiftUI

struct EnterPhoneNumber: View {
    @State private var phoneNumber: String = ""
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Please Enter")
                            .font(.custom("Inter", size: 24))
                            .foregroundColor(Color("accent"))
                        
                        Text("Your Phone Number")
                            .font(.custom("Inter", size: 24).bold())
                            .foregroundColor(Color("primary"))
                    }
                    Spacer()
                }
                .padding(.leading, 44)
                
                Spacer().frame(height: 40)
                
                HStack {
                    Text("🇫🇷")
                        .font(.system(size: 30))
                    
                    Text("+33")
                        .font(.custom("Merriweather", size: 18))
                        .foregroundColor(Color.black)
                    
                    TextField("Enter Phone Number", text: $phoneNumber)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .keyboardType(.phonePad)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack {
                    Button(action: {
                        print("Continue button pressed")
                    }) {
                        Text("Continue")
                            .font(.custom("Inter", size: 20).bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: 274, maxHeight: 44)
                            .background(Color("primary"))
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    privacyPolicyText()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,60)
                        .padding(.bottom, 10)
                }
            }
        }
    }
    
    // Split the long text expression into its own function
    private func privacyPolicyText() -> Text {
        Text("By continuing, I agree to Celeriz's ")
            .font(.custom("Inter", size: 13))
            .foregroundColor(.black)
        + Text("Privacy Policy")
            .font(.custom("Inter", size: 13))
            .foregroundColor(Color.blue)
        + Text(", ")
            .font(.custom("Inter", size: 13))
            .foregroundColor(.black)
        + Text("EULA")
            .font(.custom("Inter", size: 13))
            .foregroundColor(Color.blue)
        + Text(" and ")
            .font(.custom("Inter", size: 13))
            .foregroundColor(.black)
        + Text("User Agreement")
            .font(.custom("Inter", size: 13))
            .foregroundColor(Color.blue)
    }
}

struct EnterPhoneNumber_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumber()
    }
}
