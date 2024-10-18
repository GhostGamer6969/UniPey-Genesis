import SwiftUI

struct OTPVerificationView: View {
    @State private var smsOTP = Array(repeating: "", count: 6) // For SMS OTP (6 digits)
    @State private var emailOTP = Array(repeating: "", count: 6) // For Email OTP (6 digits)
    
    var body: some View {
        VStack {
            Spacer()
            
            // SMS OTP Section
            VStack(alignment: .leading) {
                Text("Enter the SMS OTP sent to ******7777")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                OTPTextField(otpDigits: $smsOTP)
                
                // Resend OTP Text
                Text("Resend OTP (in x sec)")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 4)
            }
            .padding(.bottom, 20)
            
            // Email OTP Section
            VStack(alignment: .leading) {
                Text("Enter the OTP sent to ********raza1@gmail.com")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                OTPTextField(otpDigits: $emailOTP)
                
                // Resend OTP Text
                Text("Resend OTP (in x sec)")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 4)
            }
            .padding(.bottom, 40)
            
            // Verify Button
            Button(action: {
                // Handle OTP verification logic
                print("SMS OTP: \(smsOTP.joined())")
                print("Email OTP: \(emailOTP.joined())")
            }) {
                Text("Verify")
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

struct OTPTextField: View {
    @Binding var otpDigits: [String]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: $otpDigits[index])
                    .frame(width: 40, height: 50)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onReceive(otpDigits[index].publisher.collect()) {
                        let value = String($0.prefix(1)) // Limit to 1 character
                        otpDigits[index] = value
                    }
            }
        }
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
