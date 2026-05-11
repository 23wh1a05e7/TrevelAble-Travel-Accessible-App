# TravelAble - Quick Start Guide

## What's New? 

Your TravelAble project now includes a complete medical assistance system for disabled travelers!

### ✨ New Features

1. **User Registration** - Sign up with disability information
2. **Login System** - Secure authentication
3. **Medical Assistant Booking** - Comprehensive form to request medical help during travel

---

## Quick Setup (5 Steps)

### Step 1: Create Database Tables
Run this in MySQL:

```bash
mysql -u root -p < database_setup.sql
```

Or copy-paste the SQL from `database_setup.sql` into MySQL Workbench/Client.

### Step 2: Verify Dependencies
Ensure you have these npm packages:
```bash
npm install express mysql cors
```

### Step 3: Start the Server
```bash
node server.js
```

You should see:
```
✅ Connected to MySQL database
🚀 Server running on http://localhost:5000
```

### Step 4: Open Application
- **Home**: http://localhost:5000
- **Login**: http://localhost:5000/login
- **Sign Up**: http://localhost:5000/signup
- **Medical Assistant**: http://localhost:5000/medical-assistant

### Step 5: Test the Features!

---

## File Overview

| File | Purpose |
|------|---------|
| `server.js` | Backend Express server with API routes |
| `signup.html` | User registration page |
| `login.html` | User login page |
| `medical-assistant.html` | Medical request booking form |
| `database_setup.sql` | Database schema and sample data |
| `README.md` | Complete documentation |
| `API_REFERENCE.md` | All API endpoints |

---

## Test with Sample Data

### Sample User Account
```
Email: john@example.com
Password: password123
Disability: mobility
```

### Medical Request Sample
```
Name: Jane Smith
Travel: Delhi → Mumbai
Date: 2026-06-15
Disability: Mobility Impairment
Assistance: Mobility help, Medical monitoring
```

---

## Common Issues & Solutions

### ❌ "Database connection failed"
**Solution:**
- Check MySQL is running: `mysql -u root -p`
- Verify credentials in server.js (line 16-20)
- Ensure database name is `travelDB`

### ❌ "Table doesn't exist"
**Solution:**
- Run `database_setup.sql` completely
- Check database: `USE travelDB; SHOW TABLES;`

### ❌ "Port 5000 already in use"
**Solution:**
```bash
# Windows
netstat -ano | findstr :5000

# Mac/Linux
lsof -i :5000

# Change port in server.js (last line)
app.listen(8000, () => { ... })  # Use 8000 instead
```

### ❌ "Cannot POST /signup"
**Solution:**
- Verify `signup` route exists in server.js
- Check route is before `app.listen()`
- Restart server after changes

---

## Features Explained

### 1. Sign Up Page
Users provide:
- Full name, email, phone
- Password with confirmation
- Disability type (optional)
- Special needs (optional)

Creates user account in database.

### 2. Login Page
Users authenticate with:
- Email address
- Password

Stores email in browser localStorage for future use.

### 3. Medical Assistant Page
Comprehensive booking form with sections:

**Traveler Info**
- Name, age, contact details

**Travel Details**
- From/to locations
- Travel date
- Transport mode
- Journey duration

**Medical Info**
- Disability types (checkboxes)
- Medical condition details
- Current medications
- Allergies

**Assistance Type**
- Mobility help
- Medication management
- Personal care
- Communication support
- Emergency support
- Medical monitoring

**Emergency Contact**
- Name, phone, relationship

Stores request with unique ID in database.

---

## Database Tables

### users
Stores user accounts with disability info
```sql
id | fullname | email | phone | password | disability_type | special_needs
```

### medical_assistant_requests  
Stores all medical assistance requests
```sql
id | traveler_name | email | travel_date | medical_details | status | created_at
```

See full schema in `database_setup.sql`

---

## API Endpoints

### Authentication
- `POST /signup` - Register new user
- `POST /login` - User login

### Medical Assistance
- `POST /medical-assistant-request` - Submit request

### Travel Bookings
- `GET /hotels?location=Delhi` - Get hotels
- `GET /trains?from=Delhi&to=Mumbai` - Get trains
- `GET /buses?from=Delhi&to=Gurgaon` - Get buses

### Pages
- `GET /` - Home page
- `GET /login` - Login page
- `GET /signup` - Sign up page
- `GET /medical-assistant` - Medical form

See full details in `API_REFERENCE.md`

---

## Next Steps

### Immediate
1. ✅ Run database setup
2. ✅ Start server
3. ✅ Test signup & login
4. ✅ Test medical request form

### Short Term
- Add payment integration
- Add request tracking page
- Create admin dashboard
- Add notification system

### Long Term
- Mobile app version
- Real-time GPS tracking
- Video consultation
- AI chatbot support
- Multi-language support

---

## Important Notes

⚠️ **Before Going Live:**
1. Change database password
2. Hash passwords (use bcrypt)
3. Use environment variables
4. Add SSL/HTTPS
5. Add input validation
6. Add rate limiting
7. Test all features

---

## Support Resources

- **API Reference**: See `API_REFERENCE.md`
- **Database Schema**: See `database_setup.sql`
- **Full Documentation**: See `README.md`
- **Test with Postman**: Import API endpoints

---

## Quick Commands

```bash
# Start server
node server.js

# Connect to MySQL
mysql -u root -p

# Use database
USE travelDB;

# Show all tables
SHOW TABLES;

# Show users
SELECT * FROM users;

# Show medical requests
SELECT * FROM medical_assistant_requests;
```

---

## Project Structure

```
📁 REAL TIME PRO/
├── 📄 server.js              ← Backend
├── 📄 database_setup.sql     ← Database
├── 📄 README.md              ← Full docs
├── 📄 API_REFERENCE.md       ← API guide
├── 📄 QUICK_START.md         ← This file
└── 📁 public/
    ├── 📄 login.html         ← Login page
    ├── 📄 signup.html        ← Sign up page
    ├── 📄 medical-assistant.html  ← Medical form
    ├── 📄 main.html          ← Home page
    ├── 📄 booking.html       ← Booking
    ├── 📄 payment.html       ← Payment
    ├── 📄 main.css           ← Styles
    ├── 📄 script.js          ← JavaScript
    └── 📁 images/            ← Images
```

---

## Success Checklist

- [ ] Database created and tables populated
- [ ] Server running without errors
- [ ] Can access http://localhost:5000
- [ ] Sign up page works
- [ ] Login page works
- [ ] Medical assistant form works
- [ ] Data saved in database

---

## Congratulations! 🎉

Your TravelAble medical assistance project is ready to help disabled travelers!

**Version**: 2.0 (With Medical Assistance)
**Last Updated**: May 2026

---

Need help? Check the documentation files!
