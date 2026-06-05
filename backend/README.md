# HostelHub Backend

**Node.js + Express.js + MySQL REST API**

This folder contains the backend REST API for the Hostel Hub Flutter application. The backend handles CRUD operations for the assignment modules and stores data in a MySQL database.

---

## Backend Overview

The backend is built using **Node.js**, **Express.js**, and **MySQL**.

Implemented modules:

* Complaint Management
* Leave Request Management

Each module supports complete CRUD operations:

* Create
* Read
* Update
* Delete

---

## Technologies Used

* Node.js
* Express.js
* MySQL
* mysql2
* cors
* body-parser
* nodemon

---

## Prerequisites

Before running the backend, install:

* Node.js v18 or higher
* MySQL Server or XAMPP
* MySQL Workbench or phpMyAdmin
* Postman for API testing

---

## Backend Folder Structure

```text
backend/

├── routes/
│   ├── complaints.js
│   └── leaves.js
│
├── database.sql
├── db.js
├── package.json
├── package-lock.json
├── POSTMAN_GUIDE.md
├── README.md
└── server.js
```

---

## Database Setup

Database name:

```sql
hostel_hub_db
```

Tables:

* complaints
* leaves

### Option 1: MySQL Workbench

Open MySQL Workbench.

Open a new SQL tab.

Copy the complete content of:

```text
database.sql
```

Paste it into MySQL Workbench.

Run the script.

This will:

* Create the `hostel_hub_db` database
* Create the `complaints` table
* Create the `leaves` table
* Insert sample records for testing, if included in the SQL file

---

### Option 2: Command Line

Run this command inside the backend folder:

```bash
mysql -u root -p < database.sql
```

Enter your MySQL password when asked.

---

## Database Configuration

Open:

```text
db.js
```

Update the MySQL connection if needed:

```js
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'hostel_hub_db',
});
```

If your MySQL has a password, add it here:

```js
password: 'your_mysql_password',
```

For XAMPP default MySQL, password is usually empty.

---

## Install Dependencies

Open terminal inside the backend folder:

```bash
cd backend
```

Install packages:

```bash
npm install
```

This installs:

* express
* mysql2
* cors
* body-parser
* nodemon

---

## Run Backend Server

### Development Mode

```bash
npm run dev
```

### Production Mode

```bash
npm start
```

Expected output:

```text
HostelHub backend running at http://localhost:3000
MySQL connected to hostel_hub_db successfully!
```

---

## Test API Health

Open browser and visit:

```text
http://localhost:3000
```

Expected response:

```json
{
  "message": "HostelHub API is running!",
  "version": "1.0.0"
}
```

---

## API Endpoints

### Complaints

| Method | Endpoint        | Description        |
| ------ | --------------- | ------------------ |
| GET    | /complaints     | Get all complaints |
| POST   | /complaints     | Create a complaint |
| PUT    | /complaints/:id | Update a complaint |
| DELETE | /complaints/:id | Delete a complaint |

---

### Leave Requests

| Method | Endpoint    | Description            |
| ------ | ----------- | ---------------------- |
| GET    | /leaves     | Get all leave requests |
| POST   | /leaves     | Create a leave request |
| PUT    | /leaves/:id | Update a leave request |
| DELETE | /leaves/:id | Delete a leave request |

---

## Sample JSON Requests

### Create Complaint

```json
{
  "category": "Electricity",
  "description": "Fan is not working"
}
```

### Update Complaint

```json
{
  "category": "Water",
  "description": "Water supply issue in hostel block"
}
```

### Create Leave Request

```json
{
  "leave_date": "2026-06-30",
  "return_date": "2026-07-13",
  "reason": "Other",
  "additional_details": "Summer vacations"
}
```

### Update Leave Request

```json
{
  "leave_date": "2026-07-01",
  "return_date": "2026-07-15",
  "reason": "Family Emergency",
  "additional_details": "Updated leave request details"
}
```

---

## Flutter API Connection

The Flutter frontend connects to this backend using the API service file:

```text
lib/services/api_service.dart
```

Use the correct base URL based on platform:

### Flutter Web

```text
http://localhost:3000
```

### Android Emulator

```text
http://10.0.2.2:3000
```

### Physical Android Device

Use your computer local IP address:

```text
http://YOUR_LOCAL_IP:3000
```

Example:

```text
http://192.168.1.95:3000
```

---

## Postman Testing

All API endpoints can be tested using Postman.

For complete Postman testing instructions, see:

```text
POSTMAN_GUIDE.md
```

Test these operations for both modules:

* POST
* GET
* PUT
* DELETE

---

## Notes

* Keep MySQL running before starting the backend.
* Make sure `hostel_hub_db` exists before running the backend.
* Update MySQL username and password in `db.js` if needed.
* Keep backend running while testing the Flutter app.
* Use Postman to verify all API endpoints.

---

## Author

**Muhammad Raza**

Full Stack Mobile Application Development Project
