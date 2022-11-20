const express = require('express');
const User = require('../models/user');

const authRouter = express.Router();

//signup api
authRouter.post("/api/signUp",async (req,res)=>{

    try{
        const { name, email, profilePic} =  req.body;

       let user =  await User.find({email:email});
       if(!user[0]){
        user = new User({
            email : email,
            name : name,
            profilePic : profilePic
        });
        user = await user.save();
       }

       res.status(200).json({user});
    }catch(e){
      console.log(`signUp exception ::  ${e}`);
      res.status(500).json({'error':`${e}`});
    }

});


module.exports = authRouter;