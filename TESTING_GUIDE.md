# TravelAble - Testing Guide & Test Cases

## Testing Overview

This guide provides comprehensive test scenarios to validate all new features:
- User signup
- User login
- Medical assistant request
- Database operations
---

## Environment Setup for Testing

### Prerequisites
```bash
✓ MySQL running
✓ Node.js server running (port 5000)
✓ Modern web browser
✓ Internet connection
✓ Database created (travelDB)
```

### Pre-Test Checklist
- [ ] Database tables created
- [ ] Server started without errors
- [ ] No port conflicts
- [ ] Network connectivity verified
- [ ] Browser cache cleared

---

## Test Case 1: User Signup

### TC-1.1: Valid Signup with All Fields
**Steps:**
1. Navigate to http://localhost:5000/signup
2. Enter: John Doe
3. Enter email: john.doe@test.com
4. Enter phone: +919876543210
5. Enter password: SecurePass123
6. Confirm password: SecurePass123
7. Select disability: Mobility Impairment
8. Enter special needs: Wheelchair accessibility
9. Check Terms & Conditions
10. Click "Create Account"

**Expected Result:**
- ✅ Success message appears
- ✅ Redirects to login.html after 2 seconds
- ✅ Data saved in users table
- ✅ created_at timestamp recorded

**Database Verification:**
```sql
SELECT * FROM users WHERE email = 'john.doe@test.com';
```
Should show all entered data.

---

### TC-1.2: Signup without Optional Fields
**Steps:**
1. Go to signup page
2. Fill required fields only (name, email, phone, password)
3. Leave disability and special needs empty
4. Accept terms
5. Submit

**Expected Result:**
- ✅ Account created successfully
- ✅ disability_type = NULL
- ✅ special_needs = NULL
- ✅ Redirects to login

---

### TC-1.3: Duplicate Email Validation
**Steps:**
1. Try signup with existing email: john.doe@test.com
2. Fill other fields
3. Submit

**Expected Result:**
- ❌ Error message: "Email already registered"
- ✅ Form not submitted
- ✅ User stays on signup page
- ❌ No duplicate entry created

---

### TC-1.4: Password Mismatch Validation
**Steps:**
1. Enter password: Pass123456
2. Confirm password: Pass123457
3. Click create account

**Expected Result:**
- ❌ Error: "Passwords do not match!"
- ✅ Form not submitted
- ✅ User stays on page

---

### TC-1.5: Password Length Validation
**Steps:**
1. Enter password: Pass123 (7 characters)
2. Confirm same password
3. Submit

**Expected Result:**
- ❌ Error: "Password must be at least 8 characters long!"
- ✅ Form not submitted

---

### TC-1.6: Terms Not Accepted
**Steps:**
1. Fill all fields correctly
2. Don't check Terms & Conditions
3. Click create account

**Expected Result:**
- ❌ Error: "Please agree to the Terms & Conditions!"
- ✅ Form not submitted

---

### TC-1.7: All Disability Types
**Test each option:**
- [ ] Mobility Impairment
- [ ] Visual Impairment
- [ ] Hearing Impairment
- [ ] Cognitive Disability
- [ ] Other

**Expected Result:**
- ✅ Each selects successfully
- ✅ Saved in database correctly

---

## Test Case 2: User Login

### TC-2.1: Valid Login
**Prerequisites:** User account exists (john.doe@test.com / SecurePass123)

**Steps:**
1. Navigate to http://localhost:5000/login
2. Enter email: john.doe@test.com
3. Enter password: SecurePass123
4. Click "Login"

**Expected Result:**
- ✅ Success
- ✅ Redirects to /main.html
- ✅ Email stored in localStorage
- ❌ No error message

**Verification:**
```
Browser DevTools → Application → Local Storage
Check: userEmail = john.doe@test.com
```

---

### TC-2.2: Invalid Password
**Steps:**
1. Enter email: john.doe@test.com
2. Enter wrong password: WrongPass123
3. Click login

**Expected Result:**
- ❌ Error: "Invalid credentials"
- ✅ Stays on login page
- ❌ No redirect
- ❌ localStorage not updated

---

### TC-2.3: Nonexistent Email
**Steps:**
1. Enter email: nonexistent@test.com
2. Enter any password
3. Click login

**Expected Result:**
- ❌ Error: "Invalid credentials"
- ✅ Stays on login page

---

### TC-2.4: Empty Fields
**Steps:**
1. Leave email empty
2. Leave password empty
3. Try to submit

**Expected Result:**
- ✅ Browser validation prevents submit
- ✅ "Please fill out this field" message

---

### TC-2.5: Signup Link Navigation
**Steps:**
1. On login page
2. Click "Sign Up for free"

**Expected Result:**
- ✅ Redirects to signup.html
- ✅ Clear form (fresh signup)

---

## Test Case 3: Medical Assistant Request

### TC-3.1: Complete Valid Request
**Steps:**
1. Navigate to http://localhost:5000/medical-assistant
2. Fill all required fields:

**Traveler Info:**
- Name: Jane Smith
- Email: jane@test.com
- Phone: +919876543211
- Age: 65

**Travel Details:**
- From: Delhi
- To: Mumbai
- Date: 2026-06-15
- Mode: Train
- Duration: 16

**Medical Info:**
- Disability: ☑ Mobility Impairment, ☑ Chronic Medical Condition
- Details: "Severe arthritis with limited mobility. Use walker."
- Medications: "Aspirin 100mg daily"
- Allergies: "Penicillin"

**Assistance:**
- Types: ☑ Mobility Help, ☑ Personal Care, ☑ Medical Monitoring
- Requirements: "Need assisted seating"
- Budget: 5000
- Gender: Female

**Emergency:**
- Name: Sarah Smith
- Phone: +919876543212
- Relation: Daughter

3. Check agreement checkbox
4. Click "Submit Request"

**Expected Result:**
- ✅ Success message with Request ID
- ✅ "Redirecting to home..." appears
- ✅ Redirects to /main.html after 3 seconds
- ✅ Form clears

**Database Verification:**
```sql
SELECT * FROM medical_assistant_requests 
WHERE traveler_name = 'Jane Smith';
```
Should show all data with:
- status = 'pending'
- created_at timestamp
- Unique request ID

---

### TC-3.2: Minimum Valid Request (Only Required Fields)
**Steps:**
1. Fill only required fields:
   - Traveler name
   - Email
   - Phone
   - Age
   - Travel from/to/date
   - Transport mode
   - Duration
   - At least one disability type ✓
   - Medical details
   - At least one assistance type ✓
   - Emergency name/phone
2. Leave optional fields blank
3. Submit

**Expected Result:**
- ✅ Request submitted successfully
- ✅ Optional fields = NULL in database

---

### TC-3.3: Multiple Disability Types
**Steps:**
1. Select: ☑ Mobility, ☑ Hearing, ☑ Cognitive
2. Rest of form filled
3. Submit

**Expected Result:**
- ✅ All three saved: "mobility, hearing, cognitive"
- ✅ Stored in disability_types field

---

### TC-3.4: Multiple Assistance Types
**Steps:**
1. Select:
   - ☑ Mobility Assistance
   - ☑ Medication Management
   - ☑ Personal Care Assistance
   - ☑ Medical Monitoring
2. Submit

**Expected Result:**
- ✅ All four saved in database
- ✅ Comma-separated format

---

### TC-3.5: No Disability Type Selected
**Steps:**
1. Leave all disability checkboxes unchecked
2. Fill rest of form
3. Click submit

**Expected Result:**
- ❌ Error: "Please select at least one disability/medical condition type."
- ✅ Form not submitted

---

### TC-3.6: No Assistance Type Selected
**Steps:**
1. Select disability types
2. Leave all assistance checkboxes unchecked
3. Fill rest of form
4. Submit

**Expected Result:**
- ❌ Error: "Please select at least one type of assistance needed."
- ✅ Form not submitted

---

### TC-3.7: Invalid Date (Past Date)
**Steps:**
1. Select travel date: 2024-01-01 (past)
2. Fill other fields
3. Submit

**Expected Result:**
- ⚠️ System accepts but should warn
- 💡 Future: Add date validation

---

### TC-3.8: Very High Budget
**Steps:**
1. Enter budget: 999999
2. Fill other fields
3. Submit

**Expected Result:**
- ✅ Saved as DECIMAL
- ✅ No validation error

---

### TC-3.9: Special Characters in Text Fields
**Steps:**
1. Name: "O'Brien-Smith"
2. Medical Details: "Allergy to eggs & peanuts; uses \"special\" chair"
3. Submit

**Expected Result:**
- ✅ All special characters saved correctly
- ✅ No SQL injection possible (prepared statements)

---

### TC-3.10: Different Transport Modes
**Test each option:**
```
☐ Flight
☐ Train
☐ Bus
☐ Car/Taxi
```

**Expected Result:**
- ✅ Each saves correctly
- ✅ All forms process successfully

---

## Test Case 4: Database Operations

### TC-4.1: Data Persistence
**Steps:**
1. Submit medical request
2. Close browser completely
3. Reopen browser
4. Query database

**Expected Result:**
- ✅ Data still exists
- ✅ Timestamps unchanged
- ✅ Status = pending

---

### TC-4.2: Multiple Concurrent Requests
**Steps:**
1. Open two browser windows
2. Submit request in window 1
3. Submit different request in window 2
4. Check database

**Expected Result:**
- ✅ Both requests saved with unique IDs
- ✅ No data corruption
- ✅ Both have own timestamps

---

### TC-4.3: Database Query Verification
```sql
-- Verify users table
SELECT COUNT(*) FROM users;
-- Should have at least 1 user

-- Verify medical requests
SELECT COUNT(*) FROM medical_assistant_requests;
-- Should match submitted requests

-- Check specific request
SELECT * FROM medical_assistant_requests 
WHERE id = 1;

-- Verify status
SELECT COUNT(*) FROM medical_assistant_requests 
WHERE status = 'pending';
```

---

## Test Case 5: UI/UX Testing

### TC-5.1: Responsive Design
**Test on:**
- [ ] Desktop (1920x1080)
- [ ] Laptop (1366x768)
- [ ] Tablet (768x1024)
- [ ] Mobile (375x667)

**Check:**
- ✓ All fields visible
- ✓ Buttons clickable
- ✓ Form readable
- ✓ No overflow
- ✓ Proper spacing

---

### TC-5.2: Form Validation Feedback
**Steps:**
1. Try each validation error
2. Check error message clarity
3. Verify error positioning

**Expected Result:**
- ✅ Error messages clear and helpful
- ✅ Red color highlighting
- ✅ Positioned near field

---

### TC-5.3: Success Message Display
**Steps:**
1. Submit valid form
2. Check success message

**Expected Result:**
- ✅ Green background
- ✅ Clear messaging
- ✅ Shows request ID (if applicable)
- ✅ Auto-redirect works

---

### TC-5.4: Accessibility Features
- [ ] Tab navigation works
- [ ] Enter key submits form
- [ ] Color contrast sufficient
- [ ] Labels associated with inputs
- [ ] Error messages announced to screen readers

---

## Test Case 6: Cross-Browser Testing

### Browsers to Test
```
✓ Google Chrome (Latest)
✓ Mozilla Firefox (Latest)
✓ Microsoft Edge (Latest)
✓ Safari (if Mac available)
```

### Test Points
- Form submission works
- Validation displays correctly
- Styling consistent
- No console errors
- localStorage works

---

## Test Case 7: Error Handling

### TC-7.1: Network Error
**Steps:**
1. Disconnect internet
2. Try to submit form
3. Reconnect

**Expected Result:**
- ✅ Error message displayed
- ✅ User informed of issue
- ✅ Option to retry

---

### TC-7.2: Database Connection Error
**Prerequisites:** Stop MySQL service

**Steps:**
1. Try login or signup
2. Observe error handling

**Expected Result:**
- ❌ "Database error" message
- ✅ Graceful error handling
- ✅ No crash

---

## Test Case 8: Performance Testing

### TC-8.1: Form Load Time
```
Step 1: Navigate to medical-assistant.html
Check: Page loads in < 2 seconds
```

### TC-8.2: Form Submission Time
```
Step 1: Submit valid form
Check: Response received in < 1 second
```

### TC-8.3: Database Query Time
```
SELECT * FROM medical_assistant_requests
Should return < 1 second (for < 1000 records)
```

---

## Test Case 9: Security Testing

### TC-9.1: SQL Injection Prevention
**Steps:**
1. Try to enter SQL in email field:
   ```
   test@test.com' OR '1'='1
   ```
2. Submit form

**Expected Result:**
- ✅ Treated as literal text
- ❌ No SQL injection occurs

---

### TC-9.2: XSS Prevention
**Steps:**
1. Try to enter script in name field:
   ```
   <script>alert('XSS')</script>
   ```
2. Submit

**Expected Result:**
- ✅ Stored as text
- ❌ Script doesn't execute

---

### TC-9.3: Password Storage
**Steps:**
1. Create user account
2. Query database

```sql
SELECT password FROM users WHERE email = 'test@test.com';
```

**Expected Result:**
- ⚠️ Currently shows plain text (FIX NEEDED!)
- 🔐 Should be hashed in production

---

## Test Results Template

```
Date: ___________
Tester: _________
Environment: Windows/Mac/Linux
Browser: _____________

Test Case: TC-X.X
Objective: ____________________
Status: ☐ PASS ☐ FAIL ☐ BLOCKED
Notes: ________________________

Issues Found:
[ ] Issue 1
[ ] Issue 2

Recommendations:
- ___________________________
```

---

## Known Issues & Recommendations

### Issue 1: Plain Text Passwords
**Severity:** HIGH
**Fix:** Implement bcrypt hashing
```javascript
const bcrypt = require('bcrypt');
const hashedPassword = bcrypt.hashSync(password, 10);
```

### Issue 2: No Input Sanitization
**Severity:** MEDIUM
**Fix:** Add input validation library
```javascript
const sanitize = require('sanitize-html');
```

### Issue 3: Missing HTTPS
**Severity:** MEDIUM
**Fix:** Deploy with SSL certificate

---

## Test Execution Checklist

### Day 1: Basic Functionality
- [ ] Signup form renders
- [ ] Login form renders
- [ ] Medical form renders
- [ ] Database connected

### Day 2: User Signup
- [ ] Valid signup works
- [ ] Duplicate email prevented
- [ ] Passwords validated
- [ ] Data saved correctly

### Day 3: User Login
- [ ] Valid login works
- [ ] Invalid credentials rejected
- [ ] Data fetched from DB
- [ ] localStorage updated

### Day 4: Medical Requests
- [ ] Form renders all sections
- [ ] Validation works
- [ ] Multiple selections work
- [ ] Data saved with ID

### Day 5: Database
- [ ] All tables created
- [ ] Data persists
- [ ] Queries work
- [ ] No corruption

### Day 6: UI/UX
- [ ] Responsive design
- [ ] Error messages clear
- [ ] Success messages show
- [ ] Navigation works

### Day 7: Cross-Browser
- [ ] Chrome tested
- [ ] Firefox tested
- [ ] Edge tested
- [ ] Mobile tested

---

## Sign-Off

- **Tested By:** _________________
- **Date:** _____________________
- **Status:** ☐ APPROVED ☐ REJECTED
- **Notes:** _____________________

---

**Testing Guide Version:** 1.0
**Last Updated:** May 2026
