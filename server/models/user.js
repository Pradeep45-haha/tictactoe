const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const secretKey = require("../config/secret");

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },

  matchWon: {
    type: Number,
    default: 0,
  },
  isOnline: {
    type: Boolean,
    default: false,
  },
  isWaiting: {
    type: Boolean,
    default: false,
  },
  isPlaying: {
    type: Boolean,
    default: false,
  },
});

userSchema.methods.generateToken = function () {
  try {
    const user = this;
    console.log(user.toString());
    const token = jwt.sign({ email: user.email, _id: user._id }, secretKey);
    return token;
  } catch (error) {
    throw error;
  }
};

const userModel = mongoose.model("User", userSchema);
module.exports = userModel;
