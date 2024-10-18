const sdk = require("stellar-sdk");

// Create a base account
const baseAccount = new sdk.Account(publicKey, sequenceNumber);

// Create a muxed account
const muxedAccount = new sdk.MuxedAccount(baseAccount, "12345");

const payment = sdk.Operation.payment({
  source: muxedSourceAccount.accountId(),
  destination: muxedDestinationAccount.accountId(),
  asset: sdk.Asset.native(),
  amount: "100",
});

const transaction = new sdk.TransactionBuilder(muxedSourceAccount, {
  fee: sdk.BASE_FEE,
  networkPassphrase: sdk.Networks.TESTNET,
})
  .addOperation(payment)
  .setTimeout(30)
  .build();

// Sign the transaction
transaction.sign(sourceKeypair);

// Submit the transaction
server
  .submitTransaction(transaction)
  .then((result) => console.log(result))
  .catch((error) => console.error(error));

function doPayment(source, dest) {
  return loadAccount(source)
    .then((accountBeforePayment) => {
      showBalance(accountBeforePayment);
      let payment = sdk.Operation.payment({
        source: source.accountId(),
        destination: dest.accountId(),
        asset: sdk.Asset.native(),
        amount: 10,
      });
      let tx = new sdk.TransactionBuilder(accountBeforePayment, {
        networkPassphrase: StellarSdk.Networks.TESTNET,
        fee: StellarSdk.BASE_FEE,
      })
        .addOperation(payment)
        .setTimeout(30)
        .build();
      tx.sign(custodian);
      return server.submitTransaction(tx);
    })
    .then(() => loadAccount(source))
    .then(showBalance);
}
