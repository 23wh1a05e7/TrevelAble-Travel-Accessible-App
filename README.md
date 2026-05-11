# TravelAble - Medical Assistance for Disabled Travelers

## Project Overview

**TravelAble** is a real-time travel assistance platform designed to provide medical support to disabled and elderly individuals during their travels. The platform enables users to:
- Register with disability information
- Book travels (flights, trains, buses, hotels)
- Request medical assistants for their journeys
- Ensure safe and comfortable travel experiences

## New Features Added

### 1. **User Authentication System**
- **Login Page** (`/login.html`) - Sign in with email and password
- **Sign Up Page** (`/signup.html`) - New user registration with:
  - Full name, email, phone, password
  - Disability type selection
  - Special needs information
  - Terms & Conditions acceptance

### 2. **Medical Assistant Request System**
- **Medical Assistant Page** (`/medical-assistant.html`) - Comprehensive form for booking medical assistance
- Features include:
  - Traveler personal information
  - Travel details (date, route, transport mode, duration)
  - Medical condition description
  - Type of assistance needed
  - Emergency contact information
  - Budget and preferences

### 3. **Backend API Routes**

#### Authentication & User Management
```
POST /signup
- Register new users
- Fields: fullname, email, phone, password, disability_type, special_needs
- Response: { success: true, userId: X }

POST /login
- User login
- Fields: email, password
- Response: { success: true, redirect: '/main.html' }
```

#### Medical Assistance
```
POST /medical-assistant-request
- Submit medical assistance request
- Stores all traveler and medical information
- Creates a request with ID for tracking
- Response: { success: true, request_id: X }
```

#### Existing Routes
```
GET /hotels?location=<city>
GET /trains?from=<city>&to=<city>
GET /buses?from=<city>&to=<city>
```

## Database Setup

### Prerequisites
- MySQL 5.7 or higher
- Database: `travelDB`
- Username: `root`
- Password: `1234`

### Database Tables Required

Run the SQL commands from `database_setup.sql`:

1. **users** - User registration data with disability info
2. **medical_assistant_requests** - Medical assistance request records
3. **hotel** - Hotel listings (existing)
4. **train1** - Train listings (existing)
5. **bus1** - Bus listings (existing)
6. **medical_assistants** (optional) - Medical staff profiles
7. **request_assignments** (optional) - Assignment tracking

### Quick Setup
```bash
# Login to MySQL
mysql -u root -p

# Run the database setup
source path/to/database_setup.sql
```

Or manually import the `database_setup.sql` file in your MySQL client.

## Project Structure

```
REAL TIME PRO/
├── server.js                    # Express backend server
├── database_setup.sql           # Database schema and sample data
├── public/
│   ├── index.html              # Home page
│   ├── login.html              # Login page (Updated)
│   ├── signup.html             # Sign up page (NEW)
│   ├── medical-assistant.html  # Medical request form (NEW)
│   ├── main.html               # Main page
│   ├── booking.html            # Booking page
│   ├── payment.html            # Payment page
│   ├── trainseat.html          # Train seat selection
│   ├── busseat.html            # Bus seat selection
│   ├── hotelroom.html          # Hotel room selection
│   ├── main.css                # Styles
│   ├── script.js               # JavaScript
│   └── images/                 # Image assets
└── README.md                   # This file
```

## Running the Project

### 1. Install Dependencies
```bash
npm install express mysql cors
```

### 2. Setup Database
```bash
# Create database and tables
mysql -u root -p < database_setup.sql
```

### 3. Start Server
```bash
node server.js
```

Server will run on: `http://localhost:5000`

### 4. Access Application
- Home: http://localhost:5000
- Login: http://localhost:5000/login
- Sign Up: http://localhost:5000/signup
- Medical Assistant: http://localhost:5000/medical-assistant

## User Journey

### For New Users
1. Click "Sign Up for free" on login page
2. Fill in personal information
3. Select disability type (if applicable)
4. Create password and confirm
5. Accept terms and create account
6. Login with credentials

### For Medical Assistance
1. After login, navigate to Medical Assistant page
2. Fill in travel details
3. Describe medical condition
4. Select type of assistance needed
5. Provide emergency contact
6. Submit request
7. Receive request ID for tracking

## Database Fields Explanation

### Users Table
- **disability_type**: Type of disability (mobility, visual, hearing, cognitive, other)
- **special_needs**: Additional accessibility requirements
- **created_at**: Account creation timestamp

### Medical Assistant Requests Table
- **status**: pending, approved, rejected, or completed
- **disability_types**: Selected disabilities requiring support
- **assistance_types**: Types of help needed (mobility, medication, personal care, etc.)
- **budget**: Maximum affordable cost for services
- **assistant_gender**: Optional gender preference

## Security Notes

⚠️ **For Production Deployment:**

1. **Password Hashing**
   - Never store plain text passwords
   - Use bcrypt for password hashing
   - Update server.js with hashing logic

2. **API Security**
   - Add authentication tokens (JWT)
   - Validate all inputs server-side
   - Implement rate limiting

3. **Database**
   - Change default credentials
   - Use environment variables for sensitive data
   - Enable MySQL SSL connections

4. **HTTPS**
   - Deploy with SSL/TLS certificate
   - Redirect all HTTP to HTTPS

## Example Implementation (Password Hashing)

```javascript
const bcrypt = require('bcrypt');

// Hash password on signup
const hashedPassword = bcrypt.hashSync(password, 10);

// Verify password on login
const isPasswordValid = bcrypt.compareSync(password, hashedPassword);
```

## Accessibility Features

The platform is designed with accessibility in mind:

✅ Semantic HTML
✅ ARIA labels for forms
✅ Keyboard navigation support
✅ Screen reader compatibility
✅ High contrast colors
✅ Accessible form controls

## Future Enhancements

1. **Real-time Tracking** - GPS tracking of medical assistants
2. **Video Consultation** - Virtual doctor consultations
3. **Payment Integration** - Secure payment gateway
4. **Ratings & Reviews** - User feedback system
5. **SMS Notifications** - Real-time alerts
6. **Multi-language Support** - Support for multiple languages
7. **AI Chatbot** - 24/7 customer support

## Troubleshooting

### Database Connection Error
```
Error: connect ECONNREFUSED 127.0.0.1:3306
```
**Solution:** 
- Check MySQL service is running
- Verify credentials in server.js
- Ensure database name is correct

### Port Already in Use
```
Error: listen EADDRINUSE: address already in use :::5000
```
**Solution:**
```bash
# Kill process on port 5000
netstat -ano | findstr :5000  # Windows
lsof -i :5000                 # Mac/Linux
```

### Missing HTML Files
**Solution:** Ensure all HTML files are in the `public/` folder

## Support & Contact

For issues or questions:
- Check the database_setup.sql for schema
- Review server.js for API endpoints
- Test with Postman or curl

## Team Information

**Project**: TravelAble - Medical Assistance Platform
**Purpose**: Enable safe and comfortable travel for disabled individuals
**Database**: MySQL
**Backend**: Node.js + Express
**Frontend**: HTML, CSS, JavaScript

## License

This project is created for educational and commercial purposes.

---

**Last Updated**: May 2026
**Version**: 2.0 (With Medical Assistance Feature)
