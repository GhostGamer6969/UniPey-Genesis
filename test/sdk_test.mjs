import StellarSdk from "stellar-sdk";
import config from "dotenv";
config.config();
const server = new StellarSdk.Horizon.Server(
  "https://horizon-testnet.stellar.org"
);
// const custodianKeypair = StellarSdk.Keypair.random();
const custodianKeypair = StellarSdk.Keypair.fromSecret(
  process.env.CUSTODIAN_SECRET
);
console.log("Custodian Public Key:", custodianKeypair.publicKey());
console.log("Custodian Secret Key:", custodianKeypair.secret());
const custodianAccount = new StellarSdk.Account(
  custodianKeypair.publicKey(),
  "0"
);

const muxedAccount1 = new StellarSdk.MuxedAccount(custodianAccount, "1");
const muxedAccount2 = new StellarSdk.MuxedAccount(custodianAccount, "2");
const muxedAccount3 = new StellarSdk.MuxedAccount(custodianAccount, "3");

console.log("Muxed Account 1:", muxedAccount1.accountId());
console.log("Muxed Account 2:", muxedAccount2.accountId());
console.log("Muxed Account 3:", muxedAccount3.accountId());

async function fundCustodianAccount() {
  try {
    const response = await fetch(
      `https://friendbot.stellar.org?addr=${encodeURIComponent(
        custodianKeypair.publicKey()
      )}`
    );
    const responseJSON = await response.json();
    console.log("SUCCESS! Custodian account funded :)\n", responseJSON);
  } catch (e) {
    console.error("ERROR!", e);
  }
}

// fundCustodianAccount();

async function transferBetweenMuxedAccounts() {
  try {
    const account = await server.loadAccount(custodianKeypair.publicKey());
    // Check balances before transaction
    console.log("Balances before transaction:");
    await showMuxedAccountBalances(muxedAccount1, muxedAccount2, muxedAccount3);

    const transaction = new StellarSdk.TransactionBuilder(account, {
      fee: StellarSdk.BASE_FEE,
      networkPassphrase: StellarSdk.Networks.TESTNET,
    })
      .addOperation(
        StellarSdk.Operation.payment({
          source: muxedAccount1.accountId(),
          destination: muxedAccount2.accountId(),
          asset: StellarSdk.Asset.native(),
          amount: "100", // Transfer 100 XLM
        })
      )
      .setTimeout(30)
      .build();

    transaction.sign(custodianKeypair);

    const result = await server.submitTransaction(transaction);
    console.log("Transaction successful:", result.hash);

    // Check balances after transaction
    console.log("\nBalances after transaction:");
    await showMuxedAccountBalances(muxedAccount1, muxedAccount2, muxedAccount3);
  } catch (e) {
    console.error("Error transferring funds:", e);
  }
}

async function showMuxedAccountBalances(...muxedAccounts) {
  for (const muxedAccount of muxedAccounts) {
    const account = await server.loadAccount(
      muxedAccount.baseAccount().accountId()
    );
    const balance = account.balances.find(
      (b) => b.asset_type === "native"
    ).balance;
    console.log(`Muxed Account ${muxedAccount.id()}: ${balance} XLM`);
  }
}

transferBetweenMuxedAccounts();
