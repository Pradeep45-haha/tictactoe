const mongoose = require("mongoose");


const playerSchema = new mongoose.Schema({
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
        default: 0
    },
    playerType:{
        required:true,
        type:String,
        
    }

});

module.exports = playerSchema;