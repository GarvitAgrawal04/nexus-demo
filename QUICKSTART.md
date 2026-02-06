# Quick Start Guide - Project Nexus

## 🚀 5-Minute Setup

### Step 1: Install PostgreSQL
Download and install PostgreSQL from https://www.postgresql.org/download/

Create a database:
```sql
CREATE DATABASE project_nexus;
```

### Step 2: Get OpenAI API Key
1. Go to https://platform.openai.com/api-keys
2. Create a new API key
3. Copy it for later use

### Step 3: Run Setup Script
```bash
cd project-nexus
setup.bat
```

### Step 4: Configure Environment
Edit `backend\.env`:
```env
DATABASE_URL="postgresql://postgres:password@localhost:5432/project_nexus"
JWT_SECRET="your-random-secret-key-here"
OPENAI_API_KEY="sk-your-openai-key-here"
PORT=5000
NODE_ENV=development
FRONTEND_URL="http://localhost:5173"
```

### Step 5: Start Backend
```bash
cd backend
npm run dev
```

Backend runs on http://localhost:5000

### Step 6: Start Frontend (New Terminal)
```bash
cd frontend
npm run dev
```

Frontend runs on http://localhost:5173

### Step 7: Test the App
1. Open http://localhost:5173
2. Click "Register" and create an account
3. Explore all 4 modules!

---

## 📋 Feature Checklist

### Module 1: Daily Pulse ✅
- [x] Live mess menu display
- [x] Real-time menu updates (Socket.io)
- [x] AI mail summarizer (OpenAI GPT)

### Module 2: Student Exchange ✅
- [x] Lost & Found with AI categorization
- [x] Buy/Sell marketplace
- [x] Travel sharing
- [x] Real-time chat for items

### Module 3: Explorer's Guide ✅
- [x] Campus hubs discovery
- [x] Location-based listings
- [x] Reviews & ratings system

### Module 4: Academic Cockpit ✅
- [x] Personal timetable
- [x] Assignment tracker with deadlines
- [x] AI study insights (OpenAI)
- [x] ML workload prediction

### Technical Requirements ✅
- [x] Full-stack (React + Node.js + PostgreSQL)
- [x] 2+ AI/ML components (OpenAI + TensorFlow.js)
- [x] Real-time features (Socket.io)
- [x] Authentication & authorization (JWT)
- [x] Responsive design (TailwindCSS)
- [x] API documentation
- [x] Data privacy & security
- [x] Git repository ready
- [x] Deployment guide included

---

## 🎯 Demo Flow

### 1. Authentication
- Register with email/password
- Login redirects to Daily Pulse

### 2. Daily Pulse
- View today's mess menu
- Paste an email and click "Summarize with AI"
- See AI-generated summary

### 3. Student Exchange
- **Lost & Found**: Report a lost item (AI auto-categorizes)
- **Marketplace**: List an item for sale
- **Travel**: Create a travel share
- Click message icon for real-time chat

### 4. Explorer's Guide
- Browse campus hubs
- Click a hub to see reviews
- Add your own review with rating

### 5. Academic Cockpit
- **Timetable**: View your class schedule
- **Assignments**: Check/uncheck to mark complete
- **AI Insights**: See workload score & AI study tips

---

## 🔧 Troubleshooting

### Backend won't start
- Check PostgreSQL is running
- Verify DATABASE_URL in .env
- Run `npx prisma migrate dev`

### Frontend shows connection error
- Ensure backend is running on port 5000
- Check VITE_API_URL in frontend/.env

### AI features not working
- Verify OPENAI_API_KEY is valid
- Check OpenAI account has credits
- See API usage at https://platform.openai.com/usage

### Real-time updates not working
- Check Socket.io connection in browser console
- Verify VITE_SOCKET_URL matches backend URL
- Ensure JWT token is valid

---

## 📊 Sample Data

### Mess Menu
```javascript
// POST /api/mess/menu
{
  "date": "2024-01-15",
  "mealType": "breakfast",
  "items": ["Idli", "Sambar", "Chutney", "Coffee"]
}
```

### Lost Item
```javascript
// POST /api/exchange/lost-found
{
  "type": "lost",
  "title": "Blue Backpack",
  "description": "Contains laptop and books",
  "location": "Library 2nd Floor"
}
```

### Campus Hub
```javascript
// POST /api/explore/hubs
{
  "name": "Central Cafe",
  "category": "Food",
  "location": "Main Building",
  "latitude": 12.9716,
  "longitude": 77.5946,
  "description": "Popular student hangout spot"
}
```

### Assignment
```javascript
// POST /api/academic/assignments
{
  "title": "Data Structures Assignment",
  "description": "Implement binary search tree",
  "dueDate": "2024-01-25",
  "priority": "high"
}
```

---

## 🎨 Customization

### Change Theme Colors
Edit `frontend/tailwind.config.js`:
```javascript
colors: {
  primary: '#3b82f6',  // Change to your color
  secondary: '#8b5cf6'
}
```

### Add New Module
1. Create route in `backend/src/routes/`
2. Add controller logic
3. Update Prisma schema if needed
4. Create frontend page in `frontend/src/pages/`
5. Add route in `App.jsx`

### Modify AI Prompts
Edit `backend/src/services/ai.js` to customize AI behavior

---

## 📱 Mobile Testing

The app is responsive! Test on mobile:
1. Find your local IP: `ipconfig` (Windows)
2. Update frontend/.env: `VITE_API_URL=http://YOUR_IP:5000/api`
3. Access from phone: `http://YOUR_IP:5173`

---

## 🏆 Hackathon Presentation Tips

1. **Start with the problem**: "Students need a unified campus ecosystem"
2. **Demo the integration**: Show how modules connect (e.g., lost item → chat → meet at hub)
3. **Highlight AI**: Emphasize 2 AI features (mail summarizer + item categorization)
4. **Show real-time**: Demonstrate live menu updates or chat
5. **Discuss scalability**: Mention deployment strategy and future features

### Future Enhancements
- Push notifications (PWA)
- Image upload for marketplace
- Google Maps integration
- Payment gateway for marketplace
- Calendar sync for timetable
- Collaborative study groups
- Event management module

---

## 📞 Support

For issues or questions:
1. Check API_DOCS.md for endpoint details
2. Review DEPLOYMENT.md for production setup
3. Check browser console for errors
4. Verify all environment variables are set

Good luck with your hackathon! 🚀
