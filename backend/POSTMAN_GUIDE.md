# HostelHub API — Postman Testing Guide

Base URL: `http://localhost:3000`

Make sure the backend is running (`npm run dev`) and MySQL is connected before testing.

---

## Health Check

### GET — API Root
- **URL**: `http://localhost:3000/`
- **Method**: GET
- **Expected Response**:
```json
{
  "message": "HostelHub API is running!",
  "version": "1.0.0"
}
```

---

## COMPLAINTS MODULE

### 1. GET All Complaints
- **Method**: GET
- **URL**: `http://localhost:3000/complaints`
- **Body**: None
- **Expected Response (200)**:
```json
[
  {
    "id": 1,
    "category": "Electricity",
    "description": "The light in Room B-204 has not been working for 3 days.",
    "status": "Pending",
    "created_at": "2025-06-01T10:00:00.000Z",
    "updated_at": "2025-06-01T10:00:00.000Z"
  }
]
```

---

### 2. POST — Create a Complaint
- **Method**: POST
- **URL**: `http://localhost:3000/complaints`
- **Headers**:
  - `Content-Type: application/json`
- **Body (raw JSON)**:
```json
{
  "category": "Water",
  "description": "There is no hot water supply in the morning from 6 AM to 9 AM."
}
```
- **Expected Response (201)**:
```json
{
  "message": "Complaint submitted successfully",
  "id": 4,
  "category": "Water",
  "description": "There is no hot water supply in the morning from 6 AM to 9 AM.",
  "status": "Pending"
}
```
- **Valid categories**: `Electricity`, `Water`, `Cleanliness`, `Internet`, `Noise`, `Other`

---

### 3. PUT — Update a Complaint
- **Method**: PUT
- **URL**: `http://localhost:3000/complaints/1`
- **Headers**:
  - `Content-Type: application/json`
- **Body (raw JSON)**:
```json
{
  "category": "Electricity",
  "description": "The light in Room B-204 AND the hallway light have stopped working."
}
```
- **Expected Response (200)**:
```json
{
  "message": "Complaint updated successfully"
}
```
- **Error (404 if ID not found)**:
```json
{
  "error": "Complaint not found"
}
```

---

### 4. DELETE — Delete a Complaint
- **Method**: DELETE
- **URL**: `http://localhost:3000/complaints/1`
- **Body**: None
- **Expected Response (200)**:
```json
{
  "message": "Complaint deleted successfully"
}
```
- **Error (404 if ID not found)**:
```json
{
  "error": "Complaint not found"
}
```

---

## LEAVE REQUESTS MODULE

### 5. GET All Leave Requests
- **Method**: GET
- **URL**: `http://localhost:3000/leaves`
- **Body**: None
- **Expected Response (200)**:
```json
[
  {
    "id": 1,
    "leave_date": "2025-06-10",
    "return_date": "2025-06-15",
    "reason": "Medical Issue",
    "additional_details": "Need to visit doctor in home city for a checkup.",
    "status": "Pending",
    "created_at": "2025-06-01T10:00:00.000Z",
    "updated_at": "2025-06-01T10:00:00.000Z"
  }
]
```

---

### 6. POST — Create a Leave Request
- **Method**: POST
- **URL**: `http://localhost:3000/leaves`
- **Headers**:
  - `Content-Type: application/json`
- **Body (raw JSON)**:
```json
{
  "leave_date": "2025-07-10",
  "return_date": "2025-07-14",
  "reason": "Family Emergency",
  "additional_details": "My father is admitted to hospital and I need to go home urgently."
}
```
- **Expected Response (201)**:
```json
{
  "message": "Leave request submitted successfully",
  "id": 4,
  "leave_date": "2025-07-10",
  "return_date": "2025-07-14",
  "reason": "Family Emergency",
  "additional_details": "My father is admitted to hospital and I need to go home urgently.",
  "status": "Pending"
}
```
- **Valid reasons**: `Medical Issue`, `Family Emergency`, `Family Event`, `Academic Purpose`, `Personal Work`, `Other`

---

### 7. PUT — Update a Leave Request
- **Method**: PUT
- **URL**: `http://localhost:3000/leaves/1`
- **Headers**:
  - `Content-Type: application/json`
- **Body (raw JSON)**:
```json
{
  "leave_date": "2025-06-12",
  "return_date": "2025-06-18",
  "reason": "Medical Issue",
  "additional_details": "Doctor appointment rescheduled — dates updated accordingly."
}
```
- **Expected Response (200)**:
```json
{
  "message": "Leave request updated successfully"
}
```

---

### 8. DELETE — Delete a Leave Request
- **Method**: DELETE
- **URL**: `http://localhost:3000/leaves/1`
- **Body**: None
- **Expected Response (200)**:
```json
{
  "message": "Leave request deleted successfully"
}
```

---

## Error Responses

### 400 Bad Request (missing/invalid fields)
```json
{
  "error": "Both category and description are required"
}
```

### 404 Not Found
```json
{
  "error": "Complaint not found"
}
```

### 500 Internal Server Error
```json
{
  "error": "ER_ACCESS_DENIED_ERROR: Access denied for user..."
}
```

---

## Quick Test Order in Postman

1. GET `/` — confirm server is running
2. POST `/complaints` — create a complaint
3. GET `/complaints` — verify it was created
4. PUT `/complaints/1` — update the complaint
5. GET `/complaints` — verify the update
6. DELETE `/complaints/1` — delete it
7. GET `/complaints` — verify deletion
8. Repeat steps 2–7 for `/leaves`
