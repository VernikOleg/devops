const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send("<h4> <center> 333-333-333 </center> </h4> <br> <h4> <center> We Present </center> </h4> <br> <h3> <center> A SPECIAL </center> </h3> <br> <h3> <center> PRESENTATION </center> </h3>")
})

app.listen(port, () => {
  console.log(`Listening on port: ${port}`)
})