# API Documentation - Project Nexus

Base URL: `http://localhost:5000/api` (Development)

## Authentication

All protected endpoints require JWT token in Authorization header:
```
Authorization: Bearer <token>
```

### Register User
**POST** `/auth/register`

Request:
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "token": "jwt_token_here",
  "user": {
    "id": "uuid",
    "email": "john@example.com",
    "name": "John Doe",
    "role": "student"
  }
}
```

### Login
**POST** `/auth/login`

Request:
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

Response: Same as register

### Get Current User
**GET** `/auth/me` 🔒

Response:
```json
{
  "id": "uuid",
  "email": "john@example.com",
  "name": "John Doe",
  "role": "student"
}
```

---

## Daily Pulse Module

### Get Mess Menu
**GET** `/mess/menu`

Response:
```json
[
  {
    "id": "uuid",
    "date": "2024-01-15T00:00:00.000Z",
    "mealType": "breakfast",
    "items": ["Idli", "Sambar", "Chutney"],
    "updatedAt": "2024-01-15T06:00:00.000Z"
  }
]
```

### Create Mess Menu
**POST** `/mess/menu` 🔒

Request:
```json
{
  "date": "2024-01-15",
  "mealType": "lunch",
  "items": ["Rice", "Dal", "Curry"]
}
```

### Summarize Email (AI)
**POST** `/mess/mail/summarize` 🔒

Request:
```json
{
  "emailContent": "Long email text here..."
}
```

Response:
```json
{
  "summary": "Brief 2-3 sentence summary with key action items."
}
```

---

## Student Exchange Module

### Lost & Found

**GET** `/exchange/lost-found`

Response:
```json
[
  {
    "id": "uuid",
    "type": "lost",
    "title": "Black Wallet",
    "description": "Lost near library",
    "category": "Accessories",
    "location": "Main Library",
    "imageUrl": null,
    "status": "active",
    "createdAt": "2024-01-15T10:00:00.000Z",
    "user": {
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
]
```

**POST** `/exchange/lost-found` 🔒

Request:
```json
{
  "type": "lost",
  "title": "Black Wallet",
  "description": "Lost near library",
  "location": "Main Library",
  "imageUrl": "https://example.com/image.jpg"
}
```

### Marketplace

**GET** `/exchange/marketplace`

**POST** `/exchange/marketplace` 🔒

Request:
```json
{
  "title": "Used Textbook",
  "description": "Engineering Mathematics",
  "price": 500,
  "imageUrl": "https://example.com/book.jpg"
}
```

### Travel Sharing

**GET** `/exchange/travel`

**POST** `/exchange/travel` 🔒

Request:
```json
{
  "from": "Campus",
  "to": "Airport",
  "date": "2024-01-20",
  "seats": 3,
  "price": 200,
  "description": "Leaving at 6 AM"
}
```

### Messages (Real-time Chat)

**GET** `/exchange/messages/:itemId` 🔒

**POST** `/exchange/messages` 🔒

Request:
```json
{
  "itemId": "uuid",
  "content": "Is this still available?"
}
```

---

## Explorer's Guide Module

### Get Hubs
**GET** `/explore/hubs`

Response:
```json
[
  {
    "id": "uuid",
    "name": "Central Cafe",
    "category": "Food",
    "location": "Main Building",
    "latitude": 12.9716,
    "longitude": 77.5946,
    "description": "Popular student hangout",
    "reviews": [
      {
        "id": "uuid",
        "rating": 5,
        "comment": "Great coffee!",
        "user": { "name": "Jane" }
      }
    ]
  }
]
```

### Create Hub
**POST** `/explore/hubs` 🔒

Request:
```json
{
  "name": "Central Cafe",
  "category": "Food",
  "location": "Main Building",
  "latitude": 12.9716,
  "longitude": 77.5946,
  "description": "Popular student hangout"
}
```

### Add Review
**POST** `/explore/reviews` 🔒

Request:
```json
{
  "hubId": "uuid",
  "rating": 5,
  "comment": "Great place!"
}
```

---

## Academic Cockpit Module

### Timetable

**GET** `/academic/timetable` 🔒

Response:
```json
[
  {
    "id": "uuid",
    "day": "Monday",
    "startTime": "09:00",
    "endTime": "10:00",
    "subject": "Mathematics",
    "room": "Room 101"
  }
]
```

**POST** `/academic/timetable` 🔒

Request:
```json
{
  "day": "Monday",
  "startTime": "09:00",
  "endTime": "10:00",
  "subject": "Mathematics",
  "room": "Room 101"
}
```

### Assignments

**GET** `/academic/assignments` 🔒

Response:
```json
[
  {
    "id": "uuid",
    "title": "Math Assignment 1",
    "description": "Solve problems 1-10",
    "dueDate": "2024-01-20T23:59:59.000Z",
    "status": "pending",
    "priority": "high",
    "createdAt": "2024-01-15T10:00:00.000Z"
  }
]
```

**POST** `/academic/assignments` 🔒

Request:
```json
{
  "title": "Math Assignment 1",
  "description": "Solve problems 1-10",
  "dueDate": "2024-01-20",
  "priority": "high"
}
```

**PATCH** `/academic/assignments/:id` 🔒

Request:
```json
{
  "status": "completed"
}
```

### AI Academic Insights

**GET** `/academic/insights` 🔒

Response:
```json
{
  "aiInsights": "Based on your workload, focus on high-priority tasks first. Consider breaking down large assignments into smaller chunks. Schedule study sessions during your free periods.",
  "workloadScore": 65,
  "recommendation": "Maintain steady pace"
}
```

---

## Real-time Events (Socket.io)

### Connection
```javascript
const socket = io('http://localhost:5000', {
  auth: { token: 'your_jwt_token' }
});
```

### Events

**menu-updated** (Server → Client)
```json
{
  "id": "uuid",
  "date": "2024-01-15",
  "mealType": "dinner",
  "items": ["Rice", "Curry"]
}
```

**join-chat** (Client → Server)
```javascript
socket.emit('join-chat', itemId);
```

**send-message** (Client → Server)
```javascript
socket.emit('send-message', {
  itemId: 'uuid',
  content: 'Hello!'
});
```

**new-message** (Server → Client)
```json
{
  "itemId": "uuid",
  "userId": "uuid",
  "content": "Hello!",
  "createdAt": "2024-01-15T10:00:00.000Z"
}
```

**notification** (Server → Client)
```json
{
  "type": "info",
  "message": "New assignment added"
}
```

---

## Error Responses

All endpoints return errors in this format:

```json
{
  "error": "Error message here"
}
```

Common status codes:
- 400: Bad Request
- 401: Unauthorized
- 404: Not Found
- 500: Internal Server Error

---

## Rate Limiting

- Authentication endpoints: 5 requests/minute
- AI endpoints: 10 requests/minute
- Other endpoints: 100 requests/minute

## Notes

🔒 = Requires authentication
All dates are in ISO 8601 format
All IDs are UUIDs
