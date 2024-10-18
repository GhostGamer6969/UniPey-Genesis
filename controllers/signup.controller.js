require("dotenv").config();
const User = require("../models/user.model");

async function registerUser(req, res) {
  const { firstName, lastName, email, phoneNumber, publicKey } = req.body;

  try {
    const user = new User({
      firstName,
      lastName,
      email,
      phoneNumber,
      publicKey,
    });
    await fetch(
      `https://friendbot.stellar.org?addr=${encodeURIComponent(publicKey)}`
    );
    await user.save();
    res.status(201).send({
      message: "User registered and funded successfully",
      accountId: publicKey,
    });
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).send("Failed to register user");
  }
}

module.exports = {
  registerUser,
};
