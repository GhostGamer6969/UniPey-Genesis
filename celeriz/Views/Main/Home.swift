import SwiftUI

struct HomeView: View {
    @State private var selectedTab = "home" // To track selected tab
    
    var body: some View {
        ZStack {
           
            // Full screen background color
            Color(UIColor.systemGray6)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                
                HStack {
                    // Profile Icon and Text
                    HStack(spacing: 12) {
                        Image(systemName: "person.circle.fill") // Profile icon
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Bonjour,")
                                .font(Font.custom("Rosario", size: 20))
                                .foregroundColor(Color.gray)
                            Text("User One")
                                .font(Font.custom("Rosario", size: 20).weight(.bold))
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                    
                    Image(systemName: "bell.fill") // Notification bell icon
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                }
                .padding([.leading, .trailing, .top])
                
                // "Quick Send" Section with rounded card style
                VStack(alignment: .leading, spacing: 16) {
                    Text("Quick Send")
                        .font(Font.custom("Rosario", size: 18).weight(.bold))
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            QuickSendItem(name: "Apple")
                            QuickSendItem(name: "Mango")
                            QuickSendItem(name: "Pear")
                            QuickSendItem(name: "Melon")
                            QuickSendItem(name: "Add", isAddButton: true)
                        }
                        .padding(.horizontal, 20)
                    }
                    .background(Color.white) // Card style background
                    .cornerRadius(20) // Rounded corners
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Subtle shadow
                    .padding([.leading, .trailing], 20)
                }
                .padding(.top, 10)
                
                // Recent Transactions Section with rounded card style
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Transactions")
                                .font(Font.custom("Rosario", size: 18).weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                            Text("see all")
                                .font(Font.custom("Rosario", size: 16))
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 20)
                        
                        // List of transactions
                        VStack(spacing: 16) {
                            TransactionItem(name: "Apple Green", amount: "€1234", time: "Today, 10:30 pm", isPositive: true, flag: "🇨🇦")
                            TransactionItem(name: "Mango Yellow", amount: "€500", time: "Today, 4:45 am", isPositive: true, flag: "🇺🇸")
                            TransactionItem(name: "Melon Water", amount: "€770", time: "Yesterday, 9:09 am", isPositive: false, flag: "🇫🇷")
                            TransactionItem(name: "Pear Sweet", amount: "€14", time: "Today, 8:30 pm", isPositive: false, flag: "🇮🇳")
                        }
                        .background(Color.white) // Card style background
                        .cornerRadius(20) // Rounded corners
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Subtle shadow
                        .padding([.leading, .trailing], 20)
                    }
                    .background(Color.white) // Full background for the entire VStack
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding([.leading, .trailing], 20)
                }
                .ignoresSafeArea(edges: .bottom)
                
                Spacer() // Ensure the VStack stretches to fill remaining space
            }
        }
        .ignoresSafeArea(edges: .bottom) // Ensures background extends fully
    }
}

// Quick Send Item View
struct QuickSendItem: View {
    var name: String
    var isAddButton: Bool = false
    
    var body: some View {
        VStack {
            if isAddButton {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                Text(name)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
        }
        .frame(width: 70, height: 100) // Ensures consistent spacing
    }
}

// Transaction Item View
struct TransactionItem: View {
    var name: String
    var amount: String
    var time: String
    var isPositive: Bool
    var flag: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(name + " " + flag)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Text(time)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(isPositive ? "+ \(amount)" : "- \(amount)")
                .foregroundColor(isPositive ? .green : .red)
                .font(.system(size: 16).weight(.bold))
        }
        .padding(.horizontal, 20)
    }
}

// Bottom Tab Bar Item View
struct BottomTabBarItem: View {
    var iconName: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
