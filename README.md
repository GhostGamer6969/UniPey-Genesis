# CeleriZ

CeleriZ is a modern cross-border payments platform that allows users to send and receive money seamlessly across countries. Built with a focus on user experience, security, and low transaction fees, CeleriZ uses **Swift** for the iOS app and **Stellar Blockchain** for fast, low-cost backend transactions.

Demo video- https://youtube.com/shorts/E-9n81Q9AyU?si=A3-7nQlkaXiIlISo

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Installation](#installation)
  - [iOS App](#ios-app)
  - [Backend (Stellar)](#backend-stellar)
- [Usage](#usage)
- [Environment Setup](#environment-setup)
- [License](#license)

---

## Features

- **Cross-Border Payments:** Seamlessly send and receive money across different countries with minimal fees.
- **Swift iOS App:** An intuitive user interface built using Swift and SwiftUI.
- **Stellar Blockchain:** Uses the Stellar blockchain for secure, fast, and cost-effective transactions.
- **USDC Integration:** All fiat currencies are converted into USDC for uniform cross-border transactions.
- **Decoy Pricing Tiers:** Three-tier system for users, including a premium experience.
- **Modern Design:** Blends elements of luxury and youth-centric experience, targeting modern users.

---

## Tech Stack

**Frontend:**
- Swift 5
- SwiftUI
- Combine Framework

**Backend:**
- Stellar Blockchain
- USDC stablecoin integration
- Circle API for fiat conversion
- Horizon API for interacting with the Stellar network

**Others:**
- Stellar SDK for Swift
- Keychain for secure user data storage
- Xcode 15 or later

---

## Architecture

CeleriZ follows a modular, decentralized architecture:

1. **Frontend (iOS):** 
    - The iOS app built with Swift and SwiftUI serves as the user interface. Users can create accounts, manage wallets, send and receive payments, and view transaction history.
    
2. **Backend (Stellar Blockchain):**
    - Stellar blockchain handles the backend transactions. Every transaction on the app is processed through the Stellar network, leveraging its speed and low fees.
    - The Stellar SDK is used to generate wallets, create and sign transactions, and interact with the Horizon API.
    - Fiat currencies are converted into USDC, allowing global users to send and receive money in a stable digital format.
    
3. **APIs:**
    - Circle API: Manages fiat-to-USDC conversions.
    - Stellar Horizon API: Facilitates communication with the Stellar network for transaction queries, account details, and operations.

---

## Installation

### iOS App

1. **Requirements**
   - Xcode 15+
   - macOS 13+ (Ventura or later)
   - Swift 5

2. **Setup**
   1. Clone the repository:
      ```bash
      git clone https://github.com/yourusername/CeleriZ-iOS.git
      cd CeleriZ-iOS
      ```

   2. Install dependencies via CocoaPods or Swift Package Manager (if needed):
      ```bash
      pod install
      ```

   3. Open the `.xcworkspace` file in Xcode:
      ```bash
      open CeleriZ.xcworkspace
      ```

   4. Configure the API keys for Circle and Stellar SDK in the `Config.swift` file.

   5. Build and run the app on the simulator or device.

### Backend (Stellar)

1. **Requirements**
   - Stellar SDK for Swift
   - Horizon API access
   - Circle API access for fiat conversion

2. **Setup**
   1. Install the Stellar SDK for Swift via CocoaPods or Swift Package Manager:
      ```bash
      pod 'stellar-sdk'
      ```

   2. Set up the Circle API for fiat conversions. Add the Circle API Key in the environment:
      ```bash
      export CIRCLE_API_KEY=your-api-key-here
      ```

   3. Install and configure the Horizon API access:
      - Horizon can be accessed via Stellar's public instance: `https://horizon.stellar.org`

   4. Set up a Stellar test account or fund your wallet for live transactions:
      - Use the Stellar laboratory (https://www.stellar.org/laboratory/) to generate keys, fund test accounts, and submit transactions.

---

## Usage

1. **Register an Account**: Create a new user account, which generates a Stellar wallet for you.
2. **Add Funds**: Use Circle to convert your fiat currency into USDC.
3. **Send Money**: Use the app to send USDC to another user, either via their email or wallet address.
4. **Receive Money**: Receive USDC directly into your Stellar wallet.
5. **Transaction History**: View all completed transactions on the app in real-time using the Stellar Horizon API.

---

## Environment Setup

1. **API Keys:**
   - Circle API: Used for fiat to USDC conversion.
   - Stellar Horizon API: Used for querying accounts, sending and receiving funds.

   Configure them in your `Config.swift` file:
   ```swift
   let CIRCLE_API_KEY = "your-circle-api-key"
   let STELLAR_HORIZON_URL = "https://horizon.stellar.org"
   ```

2. **Stellar Network Configuration:**
   - Use the Stellar SDK to configure your transactions.
   - To test, switch to Stellar testnet:
     ```swift
     StellarSDK(usingTestnet: true)
     ```

3. **Firebase (Optional)**: For user authentication and push notifications, integrate Firebase if required.

---

## License

CeleriZ is a proprietary project and is not open-source. All rights reserved.

---

This README file provides a structured overview of the project, the tech stack, and instructions for setting up and running both the Swift iOS app and the Stellar backend.
