const express = require('express');
const router  = express.Router();
const db      = require('../db');

// GET /leaves — fetch all leave requests (newest first)
router.get('/', (req, res) => {
  db.query(
    'SELECT * FROM leaves ORDER BY created_at DESC',
    (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(results);
    }
  );
});

// GET /leaves/:id — fetch single leave request
router.get('/:id', (req, res) => {
  db.query(
    'SELECT * FROM leaves WHERE id = ?',
    [req.params.id],
    (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length === 0)
        return res.status(404).json({ error: 'Leave request not found' });
      res.json(results[0]);
    }
  );
});

// POST /leaves — create a new leave request
router.post('/', (req, res) => {
  const { leave_date, return_date, reason, additional_details } = req.body;

  if (!leave_date || !return_date || !reason) {
    return res.status(400).json({
      error: 'leave_date, return_date, and reason are required',
    });
  }
  if (reason === 'Select a reason') {
    return res.status(400).json({ error: 'Please select a valid reason' });
  }

  db.query(
    `INSERT INTO leaves (leave_date, return_date, reason, additional_details)
     VALUES (?, ?, ?, ?)`,
    [leave_date, return_date, reason, additional_details || ''],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({
        message:            'Leave request submitted successfully',
        id:                 result.insertId,
        leave_date,
        return_date,
        reason,
        additional_details: additional_details || '',
        status:             'Pending',
      });
    }
  );
});

// PUT /leaves/:id — update an existing leave request
router.put('/:id', (req, res) => {
  const { id }                                                  = req.params;
  const { leave_date, return_date, reason, additional_details } = req.body;

  if (!leave_date || !return_date || !reason) {
    return res.status(400).json({
      error: 'leave_date, return_date, and reason are required',
    });
  }

  db.query(
    `UPDATE leaves
     SET leave_date = ?, return_date = ?, reason = ?, additional_details = ?
     WHERE id = ?`,
    [leave_date, return_date, reason, additional_details || '', id],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      if (result.affectedRows === 0)
        return res.status(404).json({ error: 'Leave request not found' });
      res.json({ message: 'Leave request updated successfully' });
    }
  );
});

// DELETE /leaves/:id — delete a leave request
router.delete('/:id', (req, res) => {
  db.query(
    'DELETE FROM leaves WHERE id = ?',
    [req.params.id],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      if (result.affectedRows === 0)
        return res.status(404).json({ error: 'Leave request not found' });
      res.json({ message: 'Leave request deleted successfully' });
    }
  );
});

module.exports = router;
