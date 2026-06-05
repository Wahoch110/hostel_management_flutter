const express = require('express');
const router  = express.Router();
const db      = require('../db');

// GET /complaints — fetch all complaints (newest first)
router.get('/', (req, res) => {
  db.query(
    'SELECT * FROM complaints ORDER BY created_at DESC',
    (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(results);
    }
  );
});

// GET /complaints/:id — fetch single complaint
router.get('/:id', (req, res) => {
  db.query(
    'SELECT * FROM complaints WHERE id = ?',
    [req.params.id],
    (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length === 0)
        return res.status(404).json({ error: 'Complaint not found' });
      res.json(results[0]);
    }
  );
});

// POST /complaints — create a new complaint
router.post('/', (req, res) => {
  const { category, description } = req.body;

  if (!category || !description) {
    return res.status(400).json({
      error: 'Both category and description are required',
    });
  }
  if (description.trim().length < 10) {
    return res.status(400).json({
      error: 'Description must be at least 10 characters',
    });
  }

  const validCategories = [
    'Electricity', 'Water', 'Cleanliness', 'Internet', 'Noise', 'Other',
  ];
  if (!validCategories.includes(category)) {
    return res.status(400).json({ error: 'Invalid category' });
  }

  db.query(
    'INSERT INTO complaints (category, description) VALUES (?, ?)',
    [category, description.trim()],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({
        message:     'Complaint submitted successfully',
        id:          result.insertId,
        category,
        description: description.trim(),
        status:      'Pending',
      });
    }
  );
});

// PUT /complaints/:id — update an existing complaint
router.put('/:id', (req, res) => {
  const { id }                    = req.params;
  const { category, description } = req.body;

  if (!category || !description) {
    return res.status(400).json({
      error: 'Both category and description are required',
    });
  }

  db.query(
    'UPDATE complaints SET category = ?, description = ? WHERE id = ?',
    [category, description.trim(), id],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      if (result.affectedRows === 0)
        return res.status(404).json({ error: 'Complaint not found' });
      res.json({ message: 'Complaint updated successfully' });
    }
  );
});

// DELETE /complaints/:id — delete a complaint
router.delete('/:id', (req, res) => {
  db.query(
    'DELETE FROM complaints WHERE id = ?',
    [req.params.id],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      if (result.affectedRows === 0)
        return res.status(404).json({ error: 'Complaint not found' });
      res.json({ message: 'Complaint deleted successfully' });
    }
  );
});

module.exports = router;
