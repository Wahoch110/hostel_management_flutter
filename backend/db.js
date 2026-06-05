const mysql = require('mysql2');

// Update password if your MySQL root user has a password set
const db = mysql.createConnection({
  host:        'localhost',
  user:        'hostel_user',
  password:    '1234',
  database:    'hostel_hub_db',
  dateStrings: true,   // Return DATE columns as 'YYYY-MM-DD' strings
});

db.connect((err) => {
  if (err) {
    console.error('MySQL connection failed:', err.message);
    console.error('Make sure MySQL is running and hostel_hub_db database exists.');
    process.exit(1);
  }
  console.log('MySQL connected to hostel_hub_db successfully!');
});

module.exports = db;
