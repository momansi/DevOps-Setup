const express = require('express');
const path = require('path');
const pool = require('./db');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static('public'));


app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

app.get('/votes', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM votes ORDER BY id');
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/vote', async (req, res) => {
  const { candidate } = req.body;

  try {
    await pool.query(
      'UPDATE votes SET count = count + 1 WHERE candidate = $1',
      [candidate]
    );

    res.json({ message: 'Vote submitted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});