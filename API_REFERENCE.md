# TravelAble API Endpoints Reference

## Base URL
```
http://localhost:5000
```

## Authentication Endpoints

### 1. User Sign Up
**Endpoint:** `POST /signup`

**Request Body:**
```json
{
  "fullname": "John Doe",
  "email": "john@example.com",
  "phone": "+919876543210",
  "password": "securepassword123",
  "disability_type": "mobility",
  "special_needs": "Wheelchair accessibility needed"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Account created successfully",
  "userId": 1
}
```

**Error Response (400/500):**
```json
{
  "success": false,
  "message": "Email already registered" or "Error creating account"
}
```

---

### 2. User Login
**Endpoint:** `POST /login`

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "securepassword123"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "redirect": "/main.html"
}
```

**Error Response (401/500):**
```json
{
  "success": false,
  "message": "Invalid credentials" or "Database error"
}
```

---

## Medical Assistance Endpoints

### 3. Medical Assistant Request
**Endpoint:** `POST /medical-assistant-request`

**Request Body:**
```json
{
  "traveler_name": "John Doe",
  "email": "john@example.com",
  "phone": "+919876543210",
  "age": 65,
  "travel_from": "Delhi",
  "travel_to": "Mumbai",
  "travel_date": "2026-06-15",
  "transport_mode": "train",
  "journey_duration": 16,
  "disability_types": "mobility, chronic",
  "medical_details": "Severe arthritis, limited mobility. Uses walker for support.",
  "medications": "Aspirin 100mg daily, Calcium supplements",
  "allergies": "Penicillin, Shellfish",
  "assistance_types": "mobility_help, personal_care, medical_monitoring",
  "special_requirements": "Non-vegetarian meals preferred. Need elevated seating.",
  "budget": 5000,
  "assistant_gender": "female",
  "emergency_name": "Sarah Doe",
  "emergency_phone": "+919876543211",
  "emergency_relation": "Daughter"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Medical assistance request submitted successfully",
  "request_id": 1
}
```

**Error Response (500):**
```json
{
  "success": false,
  "message": "Error submitting request"
}
```

---

## Travel Booking Endpoints

### 4. Get Hotels
**Endpoint:** `GET /hotels?location=Delhi`

**Response (200):**
```json
[
  {
    "id": 1,
    "name": "Hotel Sunny",
    "location": "Delhi",
    "price": 5000,
    "rating": 4.5,
    "accessibility_features": "Wheelchair accessible rooms, Accessible bathrooms"
  }
]
```

---

### 5. Get Trains
**Endpoint:** `GET /trains?from=Delhi&to=Mumbai`

**Response (200):**
```json
[
  {
    "id": 1,
    "name": "Rajdhani Express",
    "from_location": "Delhi",
    "to_location": "Mumbai",
    "departure_time": "14:30:00",
    "arrival_time": "08:30:00",
    "price": 2500,
    "seats_available": 50,
    "wheelchair_accessible": true
  }
]
```

---

### 6. Get Buses
**Endpoint:** `GET /buses?from=Delhi&to=Gurgaon`

**Response (200):**
```json
[
  {
    "id": 1,
    "name": "Luxury Coach",
    "from_location": "Delhi",
    "to_location": "Gurgaon",
    "departure_time": "09:00:00",
    "arrival_time": "10:30:00",
    "price": 300,
    "seats_available": 45,
    "wheelchair_accessible": false
  }
]
```

---

## Page Routes

### 7. Page Serving

**Get Login Page:**
```
GET /login
```
Returns: login.html

**Get Sign Up Page:**
```
GET /signup
```
Returns: signup.html

**Get Medical Assistant Page:**
```
GET /medical-assistant
```
Returns: medical-assistant.html

**Get Main Page:**
```
GET /
```
Returns: main.html

---

## Error Codes

| Code | Message | Cause |
|------|---------|-------|
| 200 | Success | Request processed successfully |
| 400 | Bad Request | Email already exists (signup) |
| 401 | Unauthorized | Invalid credentials (login) |
| 500 | Server Error | Database error or server issue |

---

## Example cURL Requests

### Sign Up Example
```bash
curl -X POST http://localhost:5000/signup \
  -H "Content-Type: application/json" \
  -d '{
    "fullname": "John Doe",
    "email": "john@example.com",
    "phone": "+919876543210",
    "password": "securepassword123",
    "disability_type": "mobility",
    "special_needs": "Wheelchair accessibility"
  }'
```

### Login Example
```bash
curl -X POST http://localhost:5000/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "securepassword123"
  }'
```

### Medical Request Example
```bash
curl -X POST http://localhost:5000/medical-assistant-request \
  -H "Content-Type: application/json" \
  -d '{
    "traveler_name": "John Doe",
    "email": "john@example.com",
    "phone": "+919876543210",
    "age": 65,
    "travel_from": "Delhi",
    "travel_to": "Mumbai",
    "travel_date": "2026-06-15",
    "transport_mode": "train",
    "journey_duration": 16,
    "disability_types": "mobility",
    "medical_details": "Arthritis",
    "assistance_types": "mobility_help",
    "emergency_name": "Sarah",
    "emergency_phone": "+919876543211"
  }'
```

### Get Hotels Example
```bash
curl http://localhost:5000/hotels?location=Delhi
```

### Get Trains Example
```bash
curl http://localhost:5000/trains?from=Delhi&to=Mumbai
```

---

## Testing with Postman

1. **Import Base URL**: `http://localhost:5000`
2. **Create Environment**: Set `base_url` variable
3. **Test Each Endpoint**: Use collection runner

### Postman Collection
You can import this as raw JSON in Postman for easy testing.

---

## Response Headers

All responses include:
```
Content-Type: application/json
Access-Control-Allow-Origin: *
```

---

## Rate Limiting

Currently no rate limiting implemented. For production, add:
- 100 requests per minute for login/signup
- 50 requests per minute for booking endpoints
- 10 requests per minute for medical requests

---

## Future API Endpoints

```
GET /medical-assistant/<id>        # Get specific request details
PUT /medical-assistant/<id>        # Update request
DELETE /medical-assistant/<id>     # Cancel request
GET /my-requests                   # Get user's requests
GET /available-assistants          # Get available medical assistants
POST /payment                      # Process payment
GET /booking-status/<id>           # Get booking status
```

---

## Notes

- All endpoints require proper JSON formatting
- Error messages provide debugging information
- Database transactions ensure data integrity
- Timestamps are stored in DATETIME format (YYYY-MM-DD HH:MM:SS)

---

**Last Updated**: May 2026
**API Version**: 1.0
