const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send("333-333-333\nWe Present\n A SPECIAL\n PRESENTATION\n ")
})

app.listen(port, () => {
  console.log(`Listening on port: ${port}`)
})