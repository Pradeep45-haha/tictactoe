const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");


const app = express();
const port = process.env.PORT || 3000;


var server = http.createServer(app);
var io = require("socket.io")(server);

io.on('connection', (socket) => {
    
    console.log("socket connection successful");
    socket.on('joinRoom', async ({ nickName, roomId }) => {
        try {
            console.log(nickName);
            console.log(roomId);
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                io.to(roomId).emit("joinRoomError", "Invalid_Room_Id");
                console.log("invalid room id");
                return;
            }
            let room = await Room.findById(roomId);
            if (!room) {
                io.to(roomId).emit("joinRoomError", "Wrong_Room_Id");
                console.log("wrong room id");
                return;
            }
            console.log(`room is join 1 : ${room.isJoin}`);
            if (!room.isJoin) {
                io.to(roomId).emit("joinRoomError", "Cannot_Join_Room");
                return;
            }
            let player = {
                nickName,
                socketId: socket.id,
                playerType: "O",

            }
            socket.join(roomId);
            room.players.push(player);
            room.isJoin = false;
            room = await room.save();

            io.to(roomId).emit("joinRoomSuccess", room);
            io.to(roomId).emit("newPlayerJoined", room);

            console.log(`room is join : ${room.isJoin}`);
            console.log("join success");
        } catch (e) {
            console.log(e.toString);

        }
    });
    socket.on("createRoom", async ({ roomName }) => {
        try {//create room
            console.log(roomName);
            let room = new Room();
            //console.log(`socket id is ${socket.id}`);
            let player = {
                socketId: socket.id,
                nickName: roomName,
                playerType: "X",
            };
            room.players.push(player);
            room.turn = player;
            //store room to mongoDB
            room = await room.save();

            const roomId = room._id.toString();
            console.log(roomId);
            socket.join(roomId);
            //send room data to client
            io.to(roomId).emit("createRoomSuccess", room);

        } catch (e) {
            console.log(e.toString());
        }

        socket.on("boardTap", async ({ index, roomId, }) => {
            try {

                console.log("boardTap");
                console.log(roomId);
                let room = await Room.findById(roomId);
                let choice = room.turn.playerType;
                if (room.turnIndex == 0) {
                    room.turnIndex = 1;
                    room.turn = room.players[1];
                } else {
                    room.turnIndex = 0;
                    room.turn = room.players[0];
                }
                room = await room.save();
                console.log(`after saving room room id is ${room._id}`);
                io.to(roomId).emit("tapped", {
                    index, choice, room,
                })
            } catch (e) {
                console.log(e.toString());
            }
        });

    });
});


app.use(express.json());
const DB = "mongodb+srv://ironpradeep991:akjjyglc@cluster0.zsphmpt.mongodb.net/?retryWrites=true&w=majority";
mongoose.connect(DB).then(() => {
    console.log("database connection successfull");
}).catch((e) => {
    console.log(e);
})



server.listen(port, '192.168.0.7', () => {
    console.log(`server started on port ${port}`);
}); 