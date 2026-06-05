# HostelHub Backend — Node.js + MySQL REST API

A complete REST API backend for the HostelHub Flutter app.

---

## Prerequisites

- [Node.js](https://nodejs.org/) v18 or higher
- [MySQL](https://dev.mysql.com/downloads/) or [XAMPP](https://www.apachefriends.org/) (for easy MySQL setup)

---

## 1. Database Setup

### Start MySQL
- **XAMPP**: Open XAMPP Control Panel → Start **Apache** and **MySQL**
- **Standalone MySQL**: Start the MySQL service from Services or terminal

### Create the Database & Tables

**Option A — MySQL Workbench / phpMyAdmin:**
1. Open MySQL Workbench or go to `http://localhost/phpmyadmin`
2. Open the SQL editor
3. Copy the entire content of `database.sql`
4. Paste and run it

**Option B — Command Line:**
```bash
mysql -u root -p < database.sql
```

This will:
- Create `hostel_hub_db` database
- Create `complaints` and `leaves` tables
- Insert 3 sample records in each table for testing

---

## 2. Configure Database Connection

Open `db.js` and update the connection settings if needed:

```js
const db = mysql.createConnection({
  host:     'localhost',
  user:     'root',
  password: '',           // ← Add your MySQL password here (empty for XAMPP default)
  database: 'hostel_hub_db',
});
```

---

## 3. Install Dependencies

Open a terminal inside the `backend/` folder and run:

```bash
npm install
```

This installs:
- `express` — web framework
- `mysql2` — MySQL driver
- `cors` — Cross-Origin Resource Sharing
- `body-parser` — parse JSON request bodies
- `nodemon` — auto-restart on file changes (dev dependency)

---

## 4. Run the Backend

### Development mode (auto-restarts on file changes):
```bash
npm run dev
```

### Production mode:
```bash
npm start
```

You should see:
```
HostelHub backend running at http://localhost:3000
MySQL connected to hostel_hub_db successfully!
```

---

## 5. Test the API

Open your browser and go to `http://localhost:3000` — you should see:
```json
{ "message": "HostelHub API is running!", "version": "1.0.0" }
```

For full API testing, see [POSTMAN_GUIDE.md](./POSTMAN_GUIDE.md).

---

## 6. Flutter Connection

The Flutter app connects using:
- **Android Emulator**: `http://10.0.2.2:3000` (maps to your computer's localhost)
- **Physical Android Device**: Use your computer's local IP, e.g., `http://192.168.1.x:3000`

To switch, edit `lib/services/api_service.dart` and change `baseUrl`.

---

## Project Structure

```
backend/
├── server.js          ← Express app entry point
├── db.js              ← MySQL connection
├── package.json       ← Dependencies & scripts
├── database.sql       ← SQL to create DB & tables
├── README.md          ← This file
├── POSTMAN_GUIDE.md   ← Postman testing guide
└── routes/
    ├── complaints.js  ← CRUD routes for complaints
    └── leaves.js      ← CRUD routes for leave requests
```

---

## API Endpoints Summary

| Method | URL               | Description              |
|--------|-------------------|--------------------------|
| GET    | /complaints       | Get all complaints       |
| POST   | /complaints       | Create a complaint       |
| PUT    | /complaints/:id   | Update a complaint       |
| DELETE | /complaints/:id   | Delete a complaint       |
| GET    | /leaves           | Get all leave requests   |
| POST   | /leaves           | Create a leave request   |
| PUT    | /leaves/:id       | Update a leave request   |
| DELETE | /leaves/:id       | Delete a leave request   |
