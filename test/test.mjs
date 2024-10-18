import sdk from "stellar-sdk";

const passphrase = "Test SDF Network ; September 2015";
const url = "https://horizon-testnet.stellar.org";
let server = new sdk.Horizon.Server(url);

const custodian = sdk.Keypair.fromSecret(
  "SAQLZCQA6AYUXK6JSKVPJ2MZ5K5IIABJOEQIG4RVBHX4PG2KMRKWXCHJ",
);
const outsider = sdk.Keypair.fromSecret(
  "SAAY2H7SANIS3JLFBFPLJRTYNLUYH4UTROIKRVFI4FEYV4LDW5Y7HDZ4",
);

const admin = sdk.Keypair.fromSecret()
let customers = [];

async function preamble() {
  [custodianAcc, outsiderAcc] = await Promise.all([
    server.loadAccount(custodian.publicKey()),
    server.loadAccount(outsider.publicKey()),
  ]);

  customers = ["1", "22", "333", "4444"].map(
    (id) => new sdk.MuxedAccount(custodianAcc, id),
  );

  console.log("Custodian:\n       ", custodian.publicKey());
  console.log("Customers:");
  customers.forEach((customer) => {
    console.log(
      " " + customer.id().padStart(4, " ") + ":",
      customer.accountId(),
    );
  });
  console.log();
}

preamble()