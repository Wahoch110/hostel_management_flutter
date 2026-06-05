const mysql = require('mysql2');

// Update password if your MySQL root user has a password set
const db = mysql.createConnection({
  host:        'localhost',
  user:        'test_user',
  password:    'your password',
  database:    'Database Name ',
  dateStrings: true,   // Return DATE columns as 'YYYY-MM-DD' strings
});

db.connect((err) => {
  if (err) {
    console.error('MySQL connection failed:', err.message);
    console.error('Make sure MySQL is running and  database exists.');
    process.exit(1);
  }
  console.log('MySQL connected to database successfully!');
});

module.exports = db;
