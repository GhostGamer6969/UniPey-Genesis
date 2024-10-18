import SwiftUI

struct SendMoney: View {
    @State private var searchText = ""
    @State private var contactsOffset: CGFloat = 0
    @State private var cardHeight: CGFloat = 200
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 20) {
                Text("Send Money To..")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.6, blue: 1.0, alpha: 1)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Enter Name, UIP ID, Phone Number", text: $searchText)
                }
                .padding()
                .background(Color(#colorLiteral(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)))
                .cornerRadius(10)
                
                RecentsCard()
                
                Spacer()
            }
            .padding()
            
            ContactsCard(offset: $contactsOffset, cardHeight: $cardHeight)
                .offset(y: contactsOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newOffset = value.translation.height + self.contactsOffset
                            self.contactsOffset = min(max(newOffset, -300), 0)
                        }
                        .onEnded { _ in
                            withAnimation {
                                if self.contactsOffset < -150 {
                                    self.contactsOffset = -300
                                    self.cardHeight = 500
                                } else {
                                    self.contactsOffset = 0
                                    self.cardHeight = 200
                                }
                            }
                        }
                )
            
          
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RecentsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recents")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 4), spacing: 15) {
                ForEach(0..<12) { _ in
                    ContactAvatar()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct ContactsCard: View {
    @Binding var offset: CGFloat
    @Binding var cardHeight: CGFloat
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.gray)
                .frame(width: 40, height: 5)
                .padding(.top, 10)
            
            Text("From Your Contacts")
                .font(.headline)
                .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10) { _ in
                        HStack {
                            ContactAvatar()
                            Text("Apple Green")
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
        .frame(height: cardHeight)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct ContactAvatar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(#colorLiteral(red: 0.9, green: 0.95, blue: 1.0, alpha: 1)))
            Image(systemName: "person.fill")
                .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.6, blue: 1.0, alpha: 1)))
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 15, height: 15)
                .overlay(
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 5)
                )
                .overlay(
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 5)
                        .offset(x: 5)
                )
                .overlay(
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 5)
                        .offset(x: 10)
                )
                .position(x: 40, y: 40)
        }
        .frame(width: 50, height: 50)
    }
}





struct SendMoney_Previews: PreviewProvider {
    static var previews: some View {
        SendMoney()
    }
}
