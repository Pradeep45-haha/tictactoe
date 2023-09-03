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
                socket.emit("joinRoomError", "Invalid_Room_Id");
                console.log("invalid room id");
                return;
            }
            let room = await Room.findById(roomId);
            if (!room) {
                socket.emit("joinRoomError", "Wrong_Room_Id");
                console.log("wrong room id");
                return;
            }
            console.log(`room is join 1 : ${room.isJoin}`);
            if (!room.isJoin) {
                socket.emit("joinRoomError", "Cannot_Join_Room");
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



    });
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
            });
        } catch (e) {
            console.log(e.toString());
        }

    });
    socket.on("winner", async ({ roomId }) => {
        console.log("player won event ");
        try {
            let room = await Room.findById(roomId);
            if (!room) {
                socket.emit("wrongRoomId", "Room Id not found");
                return;
            }

            if (room.players[0].socketId == socket.id) {
                console.log("player 0  1st");
                room.players[0].matchWon++;
                room.currentRound++;
                room = await room.save();
                if (room.currentRound > 6) {
                    if (room.players[0].matchWon > room.players[1].matchWon) {
                        socket.emit("playerWon", room);
                        socket.to(roomId).emit("playerDefeated", room);
                        return;
                    }
                    if (room.players[0].matchWon < room.players[1].matchWon) {
                        socket.emit("playerDefeated", room);
                        socket.to(roomId).emit("playerWon", room);
                        return;
                    }
                    if (room.players[0].matchWon == room.players[1].matchWon) {
                        io.to(roomId).emit("gameDraw", room);
                        return;
                    }
                }
                socket.emit("addPoints", room);
                socket.to(roomId).emit("noPoints", room);
                console.log("player 0  2nd");
                return;
            }

            console.log("player 1  1st");
            room.players[1].matchWon++;
            room.currentRound++;
            room = await room.save();
            if (room.currentRound > 6) {
                if (room.players[1].matchWon > room.players[0].matchWon) {
                    socket.emit("playerWon", room);
                    socket.to(roomId).emit("playerDefeated", room);
                    return;
                }
                if (room.players[1].matchWon < room.players[0].matchWon) {
                    socket.emit("playerDefeated", room);
                    socket.to(roomId).emit("playerWon", room);
                    return;
                }
                if (room.players[0].matchWon == room.players[1].matchWon) {
                    io.to(roomId).emit("gameDraw", room);
                    return;
                }
            }
            socket.emit("addPoints", room);
            socket.to(roomId).emit("noPoints", room);
            console.log("player 1  2st");
            return;
        } catch (e) {
            console.log(e.toString());
        }

    });

    socket.on("matchDraw", async ({ roomId }) => {
        console.log("Player draw event");
        try {
            let room = await Room.findById(roomId);
            if (!room) {
                console.log("from draw event room id is invalid");
                socket.emit("wrongRoomId", "Room Id not found");
                return;
            }
            room.currentRound++;
            room = await room.save();
            io.to(roomId).emit("matchDraw", room);
        } catch (e) {

            console.log(e.toString());
        }



    });


    socket.on("leaveRoom", async ({ roomId }) => {
        console.log("Player leave room event ");
        try {
            let room = await Room.findById(roomId);
            if (!room) {
                console.log("from leave event room id is invalid");
                socket.emit("wrongRoomId", "Room Id not found");
                return;
            }
            await Room.deleteOne({ "_id": roomId });


            io.to(roomId).emit("playerLeft",
                "Player left the game"
            );
            socket.leaveAll();

        } catch (e) {
            console.log(e.toString(),);
        }

    });
});

io.on('disconnect', async () => {
    console.log("socket disconnected");
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