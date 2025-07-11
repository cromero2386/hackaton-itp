import express from 'express';
import cors from 'cors';
import mysql from 'mysql2/promise';

const app = express();
app.use(cors());
app.use(express.json());

const db = await mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'hackaton',
  password: process.env.DB_PASSWORD || 'hackaton',
  database: process.env.DB_NAME || 'hackaton',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

app.get('/api/ping', (req, res) => {
  res.json({ message: 'Backend funcionando!' });
});

// Ejemplo de endpoint que consulta la base de datos
app.get('/api/ejemplo', async (req, res) => {
  try {
    const [rows] = await db.query('SHOW TABLES');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint de ejemplo para validar conexión con la base de datos
app.get('/api/validar-db', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT 1 + 1 AS resultado');
    res.json({ ok: true, resultado: rows[0].resultado });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Servidor backend escuchando en puerto ${PORT}`);
});
