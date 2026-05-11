const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const path = require('path');

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // To parse JSON bodies
app.use(express.urlencoded({ extended: true })); // To parse form submissions
app.use(express.static(path.join(__dirname, 'public')));

// MySQL DB connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'travelDB'
});

db.connect(err => {
  if (err) {
    console.error('❌ Database connection failed:', err.stack);
    return;
  }
  console.log('✅ Connected to MySQL database');
});


// ----------------- LOGIN API -----------------
app.post('/login', (req, res) => {
  const { email, password } = req.body;

  const query = 'SELECT * FROM users WHERE email = ? AND password = ?';
  db.query(query, [email, password], (err, results) => {
    if (err) return res.status(500).json({ message: 'Database error' });

    if (results.length > 0) {
      res.json({ success: true, redirect: '/main.html' });
    } else {
      res.status(401).json({ success: false, message: 'Invalid credentials' });
    }
  });
});

// ----------------- SIGNUP API -----------------
app.post('/signup', (req, res) => {
  const { fullname, email, phone, password, disability_type, special_needs } = req.body;

  // Check if email already exists
  const checkQuery = 'SELECT * FROM users WHERE email = ?';
  db.query(checkQuery, [email], (err, results) => {
    if (err) return res.status(500).json({ success: false, message: 'Database error' });

    if (results.length > 0) {
      return res.status(400).json({ success: false, message: 'Email already registered' });
    }

    // Insert new user
    const insertQuery = 'INSERT INTO users (fullname, email, phone, password, disability_type, special_needs, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())';
    db.query(insertQuery, [fullname, email, phone, password, disability_type || null, special_needs || null], (err, results) => {
      if (err) {
        console.error('Signup error:', err);
        return res.status(500).json({ success: false, message: 'Error creating account' });
      }

      res.json({ success: true, message: 'Account created successfully', userId: results.insertId });
    });
  });
});

// ----------------- MEDICAL ASSISTANT REQUEST API -----------------
app.post('/medical-assistant-request', (req, res) => {
  const {
    traveler_name, email, phone, age, travel_from, travel_to, travel_date,
    transport_mode, journey_duration, disability_types, medical_details,
    medications, allergies, assistance_types, special_requirements,
    budget, assistant_gender, emergency_name, emergency_phone, emergency_relation
  } = req.body;

  const insertQuery = `
    INSERT INTO medical_assistant_requests (
      traveler_name, email, phone, age, travel_from, travel_to, travel_date,
      transport_mode, journey_duration, disability_types, medical_details,
      medications, allergies, assistance_types, special_requirements,
      budget, assistant_gender, emergency_name, emergency_phone, emergency_relation,
      status, created_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW())
  `;

  db.query(insertQuery, [
    traveler_name, email, phone, age, travel_from, travel_to, travel_date,
    transport_mode, journey_duration, disability_types, medical_details,
    medications, allergies, assistance_types, special_requirements,
    budget, assistant_gender, emergency_name, emergency_phone, emergency_relation
  ], (err, results) => {
    if (err) {
      console.error('Medical request error:', err);
      return res.status(500).json({ success: false, message: 'Error submitting request' });
    }

    res.json({
      success: true,
      message: 'Medical assistance request submitted successfully',
      request_id: results.insertId
    });
  });
});

// ----------- PAGE SERVING FOR NEW PAGES -----------
app.get('/signup', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'signup.html'));
});

app.get('/medical-assistant', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'medical-assistant.html'));
});

app.get('/dashboard', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'dashboard.html'));
});

// ----------- USER API ENDPOINTS -----------
app.get('/user/requests', (req, res) => {
  const { email } = req.query;

  if (!email) {
    return res.status(400).json({ success: false, message: 'Email is required' });
  }

  const query = 'SELECT * FROM medical_assistant_requests WHERE email = ? ORDER BY created_at DESC';
  db.query(query, [email], (err, results) => {
    if (err) {
      console.error('Error fetching user requests:', err);
      return res.status(500).json({ success: false, message: 'Database error' });
    }

    res.json({ success: true, requests: results });
  });
});

// ----------------- Existing Routes -----------------
app.get('/hotels', (req, res) => {
  const location = req.query.location;
  const query = 'SELECT * FROM hotel WHERE location = ?';
  db.query(query, [location], (err, results) => {
    if (err) return res.status(500).send('Database query error');
    res.json(results);
  });
});

app.get('/trains', (req, res) => {
  const from = req.query.from;
  const to = req.query.to;
  const query = 'SELECT * FROM train1 WHERE from_location = ? AND to_location = ?';
  db.query(query, [from, to], (err, results) => {
    if (err) return res.status(500).send('Database query error');
    res.json(results);
  });
});

app.get('/buses', (req, res) => {
  const from = req.query.from;
  const to = req.query.to;
  const query = 'SELECT * FROM bus1 WHERE from_location = ? AND to_location = ?';
  db.query(query, [from, to], (err, results) => {
    if (err) return res.status(500).json({ error: 'Database query error' });
    res.json(results);
  });
});


// ----------------- Page Serving -----------------
app.get('/booking', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'booking.html'));
});
app.get('/req', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'req.html'));
});
app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});
app.get('/trainseat', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'trainseat.html'));
});
app.get('/busseat', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'busseat.html'));
});
app.get('/payment', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'payment.html'));
});
app.get('/book', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'book.html'));
});
app.get('/home.html', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'home.html'));
});
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'main.html'));
});


// ----------------- Server -----------------
app.listen(5000, () => {
  console.log('🚀 Server running on http://localhost:5000');
});
