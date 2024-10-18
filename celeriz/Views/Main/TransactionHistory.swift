//
//  TransactionHistory.swift
//  celeriz
//
//  Created by Raaz on 10/10/24.
//

import SwiftUI

struct TransactionHistoryView: View {
    // Sample transaction data
    let transactions = [
        Transaction(user: "Apple Green", avatar: "apple_avatar", amount: "€1234", date: "Today, 10:30 pm"),
        Transaction(user: "Mango Yellow", avatar: "mango_avatar", amount: "€500", date: "Today, 4:45 am"),
        Transaction(user: "Melon Water", avatar: "melon_avatar", amount: "€770", date: "Today, 9:09 am"),
        // Add more transactions as needed
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Transaction History")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // List of transactions
                List(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                        .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
                
                // Bottom navigation (like in your screenshot)
              
            }
     
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            // User avatar
            Image(transaction.avatar)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            
            // Transaction details
            VStack(alignment: .leading) {
                Text(transaction.user)
                    .font(.headline)
                Text(transaction.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount
            Text(transaction.amount)
                .font(.headline)
                .foregroundColor(transaction.amount.hasPrefix("-") ? .red : .green)
        }
    }
}

// Sample transaction model
struct Transaction: Identifiable {
    let id = UUID()
    let user: String
    let avatar: String
    let amount: String
    let date: String
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
    }
}
