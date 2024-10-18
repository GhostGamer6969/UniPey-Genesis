import StellarSdk from "stellar-sdk";
import config from "dotenv";
config.config();
const express = require("express");
const app = express();
app.use(express.json());

const server = new StellarSdk.Horizon.Server(
  "https://horizon-testnet.stellar.org"
);

// Create a payment transaction and send back the raw XDR
async function createTransaction(req, res) {
  const { sourcePublicKey, destination, amount, assetType, memo } = req.body;

  try {
    const sourceAccount = await server.loadAccount(sourcePublicKey);

    let transaction = new StellarSdk.TransactionBuilder(sourceAccount, {
      fee: StellarSdk.BASE_FEE,
      networkPassphrase: StellarSdk.Networks.TESTNET, // Change to MAINNET in production
    })
      .addOperation(
        StellarSdk.Operation.payment({
          destination: destination,
          asset:
            assetType === "XLM"
              ? StellarSdk.Asset.native()
              : new StellarSdk.Asset(assetType, sourcePublicKey),
          amount: amount,
        })
      )
      .addMemo(StellarSdk.Memo.text(memo || "Payment"))
      .setTimeout(30)
      .build();

    // Send back the raw transaction XDR to the frontend
    const transactionXDR = transaction.toXDR();
    res.status(200).json({ transactionXDR });
  } catch (error) {
    console.error("Transaction Creation Error:", error);
    res.status(500).json({ error: "Failed to create transaction" });
  }
}

// Submit a signed transaction received from the frontend
async function submitTransaction(req, res) {
  const { signedTransactionXDR } = req.body;

  try {
    // Parse the signed transaction from XDR
    const transaction = StellarSdk.TransactionBuilder.fromXDR(
      signedTransactionXDR,
      StellarSdk.Networks.TESTNET // Use MAINNET in production
    );

    // Submit the signed transaction to the Stellar network
    const transactionResult = await server.submitTransaction(transaction);

    res.status(200).json({ result: transactionResult });
  } catch (error) {
    console.error("Transaction Submission Error:", error);
    res.status(500).json({ error: "Failed to submit transaction" });
  }
}

// Add signer to the account for multisig without signing it
async function addSigner(req, res) {
  const { sourcePublicKey, signerPublicKey, signerWeight } = req.body;

  try {
    const sourceAccount = await server.loadAccount(sourcePublicKey);

    const transaction = new StellarSdk.TransactionBuilder(sourceAccount, {
      fee: StellarSdk.BASE_FEE,
      networkPassphrase: StellarSdk.Networks.TESTNET, // Change to MAINNET in production
    })
      .addOperation(
        StellarSdk.Operation.setOptions({
          signer: {
            ed25519PublicKey: signerPublicKey,
            weight: signerWeight, // Set the weight for the new signer
          },
        })
      )
      .setTimeout(30)
      .build();

    // Return the raw transaction for front-end signing
    const transactionXDR = transaction.toXDR();
    res.status(200).json({ transactionXDR });
  } catch (error) {
    console.error("Error adding signer:", error);
    res.status(500).json({ error: "Failed to add signer." });
  }
}

// Set thresholds for the multisig account without signing it
async function setThresholds(req, res) {
  const { sourcePublicKey, lowThreshold, medThreshold, highThreshold } =
    req.body;

  try {
    const sourceAccount = await server.loadAccount(sourcePublicKey);

    const transaction = new StellarSdk.TransactionBuilder(sourceAccount, {
      fee: StellarSdk.BASE_FEE,
      networkPassphrase: StellarSdk.Networks.TESTNET, // Change to MAINNET in production
    })
      .addOperation(
        StellarSdk.Operation.setOptions({
          lowThreshold: lowThreshold,
          medThreshold: medThreshold,
          highThreshold: highThreshold,
        })
      )
      .setTimeout(30)
      .build();

    // Return the raw transaction for front-end signing
    const transactionXDR = transaction.toXDR();
    res.status(200).json({ transactionXDR });
  } catch (error) {
    console.error("Error setting thresholds:", error);
    res.status(500).json({ error: "Failed to set thresholds" });
  }
}

// Sign a multisig transaction (on the front-end) and return the raw XDR for further signing or submission
async function signMultisigTransaction(req, res) {
  const { transactionXDR, signerSecretKey } = req.body;

  try {
    // Load the signer's keypair
    const signerKeypair = StellarSdk.Keypair.fromSecret(signerSecretKey);

    // Load the transaction from the XDR
    const transaction = StellarSdk.TransactionBuilder.fromXDR(
      transactionXDR,
      StellarSdk.Networks.TESTNET // Use MAINNET in production
    );

    // Sign the transaction with the signer's key
    transaction.sign(signerKeypair);

    // Convert the signed transaction back to XDR
    const signedTransactionXDR = transaction.toXDR();
    res.status(200).json({ signedTransactionXDR });
  } catch (error) {
    console.error("Error signing transaction:", error);
    res.status(500).json({ error: "Failed to sign transaction" });
  }
}

module.exports = {
  createTransaction,
  submitTransaction,
  addSigner,
  setThresholds,
  signMultisigTransaction,
};
