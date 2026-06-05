const express    = require('express');
const cors       = require('cors');
const bodyParser = require('body-parser');

const complaintsRouter = require('./routes/complaints');
const leavesRouter     = require('./routes/leaves');

const app  = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

// Health check
app.get('/', (req, res) => {
  res.json({ message: 'HostelHub API is running!', version: '1.0.0' });
});

// Routes
app.use('/complaints', complaintsRouter);
app.use('/leaves',     leavesRouter);

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

app.listen(PORT, () => {
  console.log(`HostelHub backend running at http://localhost:${PORT}`);
});
