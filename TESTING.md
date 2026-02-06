# Testing & Demo Guide - Project Nexus

## Pre-Demo Checklist

### Environment Setup
- [ ] PostgreSQL running
- [ ] Backend running on port 5000
- [ ] Frontend running on port 5173
- [ ] OpenAI API key configured
- [ ] Database seeded with sample data
- [ ] Browser cache cleared

### Browser Setup
- [ ] Open in Chrome/Firefox (recommended)
- [ ] Open DevTools (F12) for monitoring
- [ ] Check Console for errors
- [ ] Check Network tab for API calls
- [ ] Disable browser extensions that might interfere

---

## Complete Testing Workflow

### 1. Authentication Testing

#### Test Case 1.1: User Registration
**Steps:**
1. Navigate to http://localhost:5173
2. Click "Register"
3. Enter:
   - Name: "Test User"
   - Email: "test@example.com"
   - Password: "password123"
4. Click "Register"

**Expected Result:**
- Redirected to Daily Pulse page
- User name appears in top-right corner
- No console errors

**Verification:**
```sql
-- Check in database
SELECT * FROM "User" WHERE email = 'test@example.com';
```

#### Test Case 1.2: User Login
**Steps:**
1. Logout (click logout icon)
2. Click "Login"
3. Enter credentials
4. Click "Login"

**Expected Result:**
- Redirected to Daily Pulse
- Token stored in localStorage
- User authenticated

**Verification:**
```javascript
// In browser console
localStorage.getItem('token')
```

#### Test Case 1.3: Protected Routes
**Steps:**
1. Logout
2. Try to access http://localhost:5173/daily-pulse directly

**Expected Result:**
- Redirected to login page
- Cannot access without authentication

---

### 2. Daily Pulse Module Testing

#### Test Case 2.1: View Mess Menu
**Steps:**
1. Login
2. Navigate to "Daily Pulse"
3. View menu cards

**Expected Result:**
- Today's menu displayed
- Breakfast, Lunch, Dinner sections
- Items listed correctly

**API Verification:**
```bash
curl http://localhost:5000/api/mess/menu
```

#### Test Case 2.2: AI Email Summarizer
**Steps:**
1. In Daily Pulse page
2. Paste sample email:
```
Subject: Project Meeting Tomorrow

Hi Team,

We have an important project meeting scheduled for tomorrow at 10 AM in Conference Room B. Please bring your progress reports and be prepared to discuss the following:

1. Current project status
2. Upcoming milestones
3. Resource requirements
4. Risk assessment

The meeting is expected to last 2 hours. Coffee and snacks will be provided.

Please confirm your attendance by replying to this email.

Best regards,
Project Manager
```
3. Click "Summarize with AI"

**Expected Result:**
- Loading indicator appears
- Summary generated in 2-5 seconds
- Summary is concise (2-3 sentences)
- Key points highlighted

**Verification:**
- Check Network tab for API call to `/api/mess/mail/summarize`
- Response should contain `summary` field

#### Test Case 2.3: Real-time Menu Update
**Steps:**
1. Open app in two browser windows
2. In Window 1, stay on Daily Pulse
3. In Window 2, use API to create menu:
```bash
curl -X POST http://localhost:5000/api/mess/menu \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "date": "2024-01-15",
    "mealType": "snacks",
    "items": ["Samosa", "Tea", "Biscuits"]
  }'
```

**Expected Result:**
- Window 1 updates automatically
- New menu card appears
- No page refresh needed

---

### 3. Student Exchange Module Testing

#### Test Case 3.1: Lost & Found - Report Lost Item
**Steps:**
1. Navigate to "Student Exchange"
2. Click "Lost & Found" tab
3. Click "+ Add New"
4. Fill form:
   - Type: Lost
   - Title: "Blue Backpack"
   - Description: "Contains laptop and books"
   - Location: "Library 2nd Floor"
5. Submit

**Expected Result:**
- Item appears in list
- AI categorizes as "Accessories" or "Other"
- User name displayed
- Status shows "active"

**Verification:**
```sql
SELECT * FROM "LostFound" ORDER BY "createdAt" DESC LIMIT 1;
```

#### Test Case 3.2: Marketplace - List Item
**Steps:**
1. Click "Marketplace" tab
2. Click "+ Add New"
3. Fill form:
   - Title: "Engineering Textbook"
   - Description: "Data Structures by Cormen"
   - Price: 500
4. Submit

**Expected Result:**
- Item appears in marketplace
- AI categorizes as "Books"
- Price displayed correctly
- Message icon available

**Verification:**
- Check category is auto-assigned
- Verify price format

#### Test Case 3.3: Travel Share
**Steps:**
1. Click "Travel Share" tab
2. Click "+ Add New"
3. Fill form:
   - From: "Campus"
   - To: "Airport"
   - Date: Tomorrow's date
   - Seats: 3
   - Price: 200
5. Submit

**Expected Result:**
- Travel share listed
- Date formatted correctly
- Seats count visible
- User can see their own listing

#### Test Case 3.4: Real-time Chat
**Steps:**
1. Open two browser windows with different users
2. User A creates marketplace item
3. User B clicks message icon on that item
4. User B sends message: "Is this available?"
5. User A should see message in real-time

**Expected Result:**
- Messages appear instantly
- No page refresh needed
- Sender name displayed
- Timestamp shown

---

### 4. Explorer's Guide Module Testing

#### Test Case 4.1: View Campus Hubs
**Steps:**
1. Navigate to "Explorer's Guide"
2. Browse hub cards

**Expected Result:**
- Hubs displayed in grid
- Category badges visible
- Location shown
- Average rating calculated
- Review count displayed

#### Test Case 4.2: View Hub Details
**Steps:**
1. Click on any hub card
2. Modal opens with details

**Expected Result:**
- Hub name and description
- All reviews listed
- Star ratings displayed
- User names shown
- Can close modal

#### Test Case 4.3: Add Review
**Steps:**
1. Click on a hub
2. Add review:
   - Rating: 5 stars
   - Comment: "Great place to study!"
3. Submit

**Expected Result:**
- Review appears in hub details
- Rating updates average
- User name attached to review

**Verification:**
```sql
SELECT * FROM "Review" ORDER BY "createdAt" DESC LIMIT 1;
```

---

### 5. Academic Cockpit Module Testing

#### Test Case 5.1: View Timetable
**Steps:**
1. Navigate to "Academic Cockpit"
2. Click "Timetable" tab

**Expected Result:**
- Table with days and times
- Subjects listed
- Room numbers shown
- Organized by day

#### Test Case 5.2: Create Assignment
**Steps:**
1. Click "Assignments" tab
2. Click "+ Add New"
3. Fill form:
   - Title: "Math Assignment"
   - Description: "Solve problems 1-10"
   - Due Date: Next week
   - Priority: High
4. Submit

**Expected Result:**
- Assignment appears in list
- Due date formatted
- Priority badge colored (red for high)
- Status is "pending"
- Checkbox unchecked

#### Test Case 5.3: Mark Assignment Complete
**Steps:**
1. Click checkbox on an assignment

**Expected Result:**
- Checkbox checked
- Title gets strikethrough
- Status updates to "completed"
- Changes persist on refresh

#### Test Case 5.4: View AI Insights
**Steps:**
1. Click "AI Insights" tab
2. Wait for loading

**Expected Result:**
- Workload score displayed (0-100)
- Recommendation text shown
- AI study tips generated
- Tips are relevant to workload

**Verification:**
- Score should increase with more assignments
- Overdue assignments increase score more
- AI tips should be actionable

---

## Performance Testing

### Load Time Testing
**Metrics to Check:**
- Initial page load: < 2 seconds
- API response time: < 500ms
- AI summarization: 2-5 seconds
- Real-time message: < 100ms

**Tools:**
- Browser DevTools → Network tab
- Lighthouse audit (F12 → Lighthouse)

### Concurrent Users Testing
**Steps:**
1. Open 5 browser windows
2. Login with different users
3. Perform actions simultaneously
4. Check for conflicts or errors

**Expected Result:**
- No data corruption
- All users see correct data
- Real-time updates work for all

---

## Security Testing

### Test Case: SQL Injection Prevention
**Steps:**
1. Try to login with:
   - Email: `admin' OR '1'='1`
   - Password: `anything`

**Expected Result:**
- Login fails
- No database error
- Prisma prevents injection

### Test Case: XSS Prevention
**Steps:**
1. Create lost item with title:
   - `<script>alert('XSS')</script>`

**Expected Result:**
- Script not executed
- Displayed as plain text
- React escapes HTML

### Test Case: JWT Validation
**Steps:**
1. Get token from localStorage
2. Modify token slightly
3. Try to make API call

**Expected Result:**
- 401 Unauthorized error
- Access denied
- Token validation works

---

## Demo Script (5 Minutes)

### Minute 1: Introduction
**Say:**
"Project Nexus is a unified campus ecosystem that integrates 4 essential student modules with AI-powered features and real-time updates."

**Show:**
- Login screen
- Quick registration

### Minute 2: Daily Pulse
**Say:**
"Students can check today's mess menu with live updates and use AI to summarize long emails."

**Demo:**
1. Show mess menu
2. Paste sample email
3. Click "Summarize with AI"
4. Show instant summary

### Minute 3: Student Exchange
**Say:**
"The exchange module connects students through Lost & Found, Marketplace, and Travel Sharing with real-time chat."

**Demo:**
1. Show lost item (mention AI categorization)
2. Show marketplace item
3. Click message icon
4. Send message (show real-time)

### Minute 4: Explorer & Academic
**Say:**
"Students discover campus hubs with reviews, and manage their academic life with AI insights."

**Demo:**
1. Show campus hubs
2. Click hub, show reviews
3. Switch to Academic Cockpit
4. Show timetable
5. Show AI insights with workload score

### Minute 5: Technical Highlights
**Say:**
"Built with React, Node.js, PostgreSQL, featuring 2 AI components (OpenAI + TensorFlow), real-time Socket.io, JWT auth, and deployed on Vercel + Railway."

**Show:**
- Open DevTools → Network tab
- Show WebSocket connection
- Mention deployment readiness

---

## Common Issues & Solutions

### Issue: AI Summarizer Not Working
**Solution:**
- Check OpenAI API key
- Verify API credits
- Check console for errors
- Test with shorter email

### Issue: Real-time Updates Not Working
**Solution:**
- Check Socket.io connection in console
- Verify token is valid
- Restart backend server
- Check CORS settings

### Issue: Database Connection Error
**Solution:**
- Verify PostgreSQL is running
- Check DATABASE_URL
- Run migrations again
- Check database exists

### Issue: Slow Performance
**Solution:**
- Clear browser cache
- Check network tab for slow requests
- Verify database has indexes
- Check OpenAI API response time

---

## Post-Demo Checklist

- [ ] All features demonstrated
- [ ] No errors in console
- [ ] Real-time features worked
- [ ] AI features responded
- [ ] Questions answered
- [ ] GitHub repo shared
- [ ] Deployment URL shared (if deployed)

---

## Judging Criteria Alignment

### Innovation (25%)
**Highlight:**
- Unified ecosystem approach
- Cross-module integration
- AI-powered intelligence
- Real-time collaboration

### Technical Complexity (25%)
**Highlight:**
- Full-stack implementation
- Multiple AI/ML integrations
- WebSocket architecture
- Secure authentication
- Production deployment

### Functionality (25%)
**Highlight:**
- All 4 modules working
- End-to-end flows complete
- Data persistence
- Error handling
- Responsive design

### Presentation (25%)
**Highlight:**
- Clear documentation
- Professional README
- API documentation
- Live demo
- Deployment guide

---

## Backup Plans

### If OpenAI API Fails
- Use pre-generated summaries
- Explain the feature
- Show code implementation

### If Real-time Fails
- Demonstrate with manual refresh
- Show Socket.io code
- Explain architecture

### If Database Fails
- Use screenshots
- Show code and schema
- Explain data model

---

## Success Metrics

**Demo is successful if:**
- ✅ All 4 modules demonstrated
- ✅ At least 1 AI feature works
- ✅ Real-time feature demonstrated
- ✅ No critical errors
- ✅ Questions answered confidently
- ✅ Technical depth shown
- ✅ Judges understand value proposition

Good luck with your demo! 🚀
