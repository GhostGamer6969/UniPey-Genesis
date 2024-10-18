// NavView.swift
import SwiftUI

struct NavView: View {
    @State private var selectedTab: String = "home" // State to track the selected tab
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    // Show different views based on the selected tab
                    if selectedTab == "home" {
                        HomeView() // This now refers to the HomeView in Home.swift
                    } else if selectedTab == "list" {
                        ListView()
                    } else if selectedTab == "transfer" {
                        TransferView()
                    } else if selectedTab == "eraser" {
                        SettingsView()
                    }
                    
                    Spacer()
                    
                    // Custom bottom navigation bar
                    HStack {
                        Spacer()
                        
                        TabBarButton(imageName: "house.fill", isSelected: selectedTab == "home") {
                            selectedTab = "home"
                        }
                        Spacer()
                        
                        TabBarButton(imageName: "list.bullet", isSelected: selectedTab == "list") {
                            selectedTab = "list"
                        }
                        Spacer()
                        
                        TabBarButton(imageName: "arrow.left.arrow.right", isSelected: selectedTab == "transfer") {
                            selectedTab = "transfer"
                        }
                        Spacer()
                        
                        TabBarButton(imageName: "eraser.fill", isSelected: selectedTab == "eraser") {
                            selectedTab = "eraser"
                        }
                        Spacer()
                    }
                    .frame(height: 50)
                    .frame(width: 300)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5) // Blue shadow
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.blue, lineWidth: 2) // Blue border
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

// Custom TabBarButton for each icon
struct TabBarButton: View {
    var imageName: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(isSelected ? Color.blue : Color.black) // Change color based on selection
        }
    }
}

// Sample Views for Other Tabs
struct ListView: View {
    var body: some View {
        Text("List Page")
            .font(.largeTitle)
            .navigationTitle("List")
    }
}

struct TransferView: View {
    var body: some View {
        Text("Transfer Page")
            .font(.largeTitle)
            .navigationTitle("Transfer")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Page")
            .font(.largeTitle)
            .navigationTitle("Settings")
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
