import express from 'express';
import cors from 'cors';
import pool from './config/database.js';

const app = express();

app.use(cors());
app.use(express.json());

// Health check express server
app.get('/api/health', (_req, res) => {
    res.json({
        status: 'ok',
    });
});

// Health check express communicate with postgreSQL
app.get('/api/health/db', async (_req, res) => {
    try {
        await pool.query('SELECT 1');

        res.json({
            status: 'ok',
            database: 'connected',
        });
    } catch (error) {
        console.error('Database connection failed:', error);

        res.status(500).json({
            status: 'error',
            database: 'disconnected',
        });
    }
});

export default app;
