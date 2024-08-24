const jwt = require("jsonwebtoken");
const secretKey = require("../config/secret");
const User = require("../models/user");

async function authorise(socket, next) {
  try {
    console.log("authorise middleware called");
    let jwtTokenData;

    jwtTokenData = socket.handshake.auth.authorisation;

    console.log(2);
    if (!jwtTokenData) {
      console.log(2.1);
      const err = new Error("not authorized");
      err.data = { content: "no authorisation token" };
      next(err);
      return;
    }

    const jwtToken = jwtTokenData;
    console.log(`jwtToken ${jwtToken}`);

    jwt.verify(jwtToken, secretKey, async (error, data) => {
      if (error) {
        console.log("got error in jwtverify");
        const err = new Error("not authorized");
        err.data = { content: "Please retry later" };
        next(err);
      }
      console.log(data.toString());
      const user = await User.findOne({ email: data.email });

      if (!user) {
        // if (!req) {
        const err = new Error("not authorized");
        err.data = { content: "Please retry later" };
        next(err);
      }

      socket.user = user;
      // }
      next();
    });
    return;
  } catch (error) {
    console.log(error);

    return;
  }
}

module.exports = authorise;
