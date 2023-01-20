const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
})

app.listen(port, () => {
  console.log(`Listening on port: ${port}`)
})