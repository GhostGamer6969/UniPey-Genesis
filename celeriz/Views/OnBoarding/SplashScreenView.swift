import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
   
            Color("bgColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

             
                Image("SplashScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Spacer()
            }
            
            
            VStack {
                Spacer()
                Text("Pay anyone,\nanywhere,\nany currency")
                    .font(Font.custom("Merriweather", size: 24))
                    .italic()
                    .foregroundColor(Color("primary"))
                    .multilineTextAlignment(.center)

                Spacer()
                    .frame(height: 30)
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
