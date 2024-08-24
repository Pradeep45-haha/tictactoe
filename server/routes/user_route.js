const express = require("express");
const router = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authorise = require("../middlewares/auth");

router.post("/user/signup", async (req, res) => {
  try {
    const { email, password, username } = req.body;
    console.log(`email: ${email} username: ${username} password: ${password} req.body: ${req.body}`)
    if (!(email && password && username)) {
      res
        .status(400)
        .send({ error: "please provide email, username and paswword" });
      return;
    }
    const userWithSameEmail = await User.findOne({ email: email });
    if (userWithSameEmail) {
      res.status(409).send({ error: "account already exists" });
      return;
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    const userModel = new User({ email, password: hashedPassword, username });
    await userModel.save();
    res.status(200).send({ msg: "Account created successfully" });
    return;
  } catch (error) {
    res.status(500).send({ error: "something went wrong" });
  }
});

router.post("/user/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    console.log(`email: ${email}`);
    if (!(email && password)) {
      res.status(400).send({ error: "please provide email and password" });
      return;
    }

    const user = await User.findOne({ email: email });
    if (!user) {
      res.status(401).send({ error: "wrong email and password" });
      return;
    }
    const token = user.generateToken();
    res.status(200).send({ token: token });
    return;
  } catch (error) {
    res.status(500).send({ error: "something went wrong" });
    return;
  }
});

router.post("/user/profile", authorise, async (req, res) => {
  try {
    res.status(200).send(req.user);
    return;
  } catch (error) {
    res.status(500).send({ error: "something went wrong" });
    return;
  }
});

module.exports = router;
