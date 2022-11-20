
const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const cors = require('cors');
const PORT = process.env.PORT | 3001;


const app = express();
const DB = "mongodb+srv://sahil:Sahil(0)@cluster0.mdfpfuc.mongodb.net/myFirstDatabase"

mongoose.connect(DB).then(function(value){
    console.log(`mongoose connection sucessful :-- ${value}`);
}).catch((e)=>{
    console.log(`mongoose connect error :-- ${e}`);
});

app.use(cors())
//middlewares
app.use(express.json());
app.use(authRouter);



app.listen(PORT, "0.0.0.0", ()=>{
    console.log(`connected at port ${PORT}`)
});

