import React, { useEffect, useState } from 'react';

function App() {
  const [message, setMessage] = useState('');
  const [tables, setTables] = useState([]);
  const [dbStatus, setDbStatus] = useState(null);

  useEffect(() => {
    fetch('http://localhost:5000/api/ping')
      .then(res => res.json())
      .then(data => setMessage(data.message));
    fetch('http://localhost:5000/api/ejemplo')
      .then(res => res.json())
      .then(data => setTables(data));
    fetch('http://localhost:5000/api/validar-db')
      .then(res => res.json())
      .then(data => setDbStatus(data));
  }, []);

  return (
    <div style={{ padding: 32 }}>
      <h1>Frontend React</h1>
      <p>Backend dice: {message}</p>
      <h2>Tablas en la base de datos:</h2>
      <ul>
        {tables.map((row, idx) => (
          <li key={idx}>{Object.values(row)[0]}</li>
        ))}
      </ul>
      <h2>Validación conexión DB:</h2>
      {dbStatus && dbStatus.ok ? (
        <p style={{ color: 'green' }}>Conexión exitosa, resultado: {dbStatus.resultado}</p>
      ) : dbStatus ? (
        <p style={{ color: 'red' }}>Error: {dbStatus.error}</p>
      ) : (
        <p>Validando conexión...</p>
      )}
    </div>
  );
}

export default App;
