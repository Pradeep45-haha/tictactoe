const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  nickName: {
    type: String,
    required: true,
    trim: true,
  },
  socketId: {
    type: String,
    required: true,
  },
  matchWon: {
    type: Number,
    default: 0,
  },
  playerType: {
    required: true,
    type: String,
  },
});

const playerModel = mongoose.model("Player", playerSchema);
module.exports = { playerSchema, playerModel };
