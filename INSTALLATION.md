# Installation Guide - Project Nexus

## Prerequisites Installation

### 1. Install Node.js (v18 or higher)
- Download from: https://nodejs.org/
- Verify installation:
```bash
node --version
npm --version
```

### 2. Install PostgreSQL (v14 or higher)
- Download from: https://www.postgresql.org/download/windows/
- During installation:
  - Set password for postgres user (remember this!)
  - Port: 5432 (default)
  - Install pgAdmin 4 (optional GUI)

### 3. Create Database
Open pgAdmin or command line:
```sql
CREATE DATABASE project_nexus;
```

Or via command line:
```bash
psql -U postgres
CREATE DATABASE project_nexus;
\q
```

### 4. Get OpenAI API Key
1. Go to https://platform.openai.com/
2. Sign up or log in
3. Go to API Keys section
4. Create new secret key
5. Copy and save it securely

---

## Project Setup

### Step 1: Navigate to Project
```bash
cd C:\Users\Garvit agrawal\Desktop\project-nexus
```

### Step 2: Backend Setup

#### Install Dependencies
```bash
cd backend
npm install
```

#### Configure Environment
Create `backend\.env` file:
```env
DATABASE_URL="postgresql://postgres:YOUR_PASSWORD@localhost:5432/project_nexus"
JWT_SECRET="your-super-secret-jwt-key-min-32-chars-long"
OPENAI_API_KEY="sk-your-openai-api-key-here"
PORT=5000
NODE_ENV=development
FRONTEND_URL="http://localhost:5173"
```

Replace:
- `YOUR_PASSWORD` with your PostgreSQL password
- `your-super-secret-jwt-key-min-32-chars-long` with a random string
- `sk-your-openai-api-key-here` with your OpenAI API key

#### Generate Prisma Client
```bash
npx prisma generate
```

#### Run Database Migrations
```bash
npx prisma migrate dev --name init
```

This will:
- Create all database tables
- Set up relationships
- Apply indexes

#### Seed Sample Data (Optional)
```bash
npm run seed
```

This creates:
- Demo user (demo@student.com / password123)
- Sample mess menu
- Campus hubs
- Sample timetable
- Sample assignments
- Marketplace items
- Lost & found items

### Step 3: Frontend Setup

#### Install Dependencies
```bash
cd ..\frontend
npm install
```

#### Configure Environment
Create `frontend\.env` file:
```env
VITE_API_URL=http://localhost:5000/api
VITE_SOCKET_URL=http://localhost:5000
```

---

## Running the Application

### Terminal 1: Start Backend
```bash
cd backend
npm run dev
```

You should see:
```
Server running on port 5000
```

### Terminal 2: Start Frontend
```bash
cd frontend
npm run dev
```

You should see:
```
  VITE v5.0.7  ready in 500 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

### Access the Application
Open browser and go to: http://localhost:5173

---

## First Time Setup

### Option 1: Use Seeded Data
If you ran the seed script:
- Email: `demo@student.com`
- Password: `password123`

### Option 2: Create New Account
1. Click "Register"
2. Enter your details
3. Click "Register" button
4. You'll be automatically logged in

---

## Verify Installation

### Check Backend
Visit: http://localhost:5000/api/mess/menu

You should see JSON response (empty array or menu items)

### Check Frontend
1. Register/Login
2. Navigate through all 4 modules:
   - Daily Pulse
   - Student Exchange
   - Explorer's Guide
   - Academic Cockpit

### Test AI Features
1. Go to Daily Pulse
2. Paste sample email in Mail Summarizer
3. Click "Summarize with AI"
4. Should see AI-generated summary

### Test Real-time Features
1. Open app in two browser windows
2. In one window, create a mess menu item (if admin)
3. Other window should update automatically

---

## Troubleshooting

### Backend won't start

#### Error: "Cannot connect to database"
- Check PostgreSQL is running
- Verify DATABASE_URL in .env
- Test connection: `psql -U postgres -d project_nexus`

#### Error: "Prisma Client not generated"
```bash
cd backend
npx prisma generate
```

#### Error: "Table does not exist"
```bash
cd backend
npx prisma migrate reset
npx prisma migrate dev
```

### Frontend won't start

#### Error: "Cannot find module"
```bash
cd frontend
rm -rf node_modules
npm install
```

#### Error: "Port 5173 already in use"
Kill the process or change port in vite.config.js

### API Connection Issues

#### CORS Error
- Verify FRONTEND_URL in backend/.env matches frontend URL
- Restart backend server

#### 401 Unauthorized
- Clear browser localStorage
- Login again
- Check JWT_SECRET is set in backend/.env

### AI Features Not Working

#### OpenAI API Error
- Verify API key is correct
- Check you have credits: https://platform.openai.com/usage
- Ensure no extra spaces in .env file

#### Rate Limit Error
- Wait a few minutes
- Check OpenAI usage limits
- Consider upgrading OpenAI plan

### Database Issues

#### Reset Database
```bash
cd backend
npx prisma migrate reset
npx prisma migrate dev
npm run seed
```

#### View Database
Using pgAdmin:
1. Open pgAdmin
2. Connect to localhost
3. Navigate to project_nexus database
4. Browse tables

Or command line:
```bash
psql -U postgres -d project_nexus
\dt  # List tables
SELECT * FROM "User";  # Query users
```

---

## Development Tips

### Hot Reload
Both frontend and backend support hot reload:
- Frontend: Changes reflect immediately
- Backend: Nodemon restarts server on file changes

### View Logs
- Backend: Check terminal running `npm run dev`
- Frontend: Open browser DevTools (F12) → Console

### Database Changes
After modifying `prisma/schema.prisma`:
```bash
npx prisma migrate dev --name your_migration_name
npx prisma generate
```

### Add Sample Data
Edit `prisma/seed.js` and run:
```bash
npm run seed
```

---

## IDE Setup (Optional)

### VS Code Extensions
1. **Prisma** - Syntax highlighting for schema
2. **ES7+ React/Redux** - React snippets
3. **Tailwind CSS IntelliSense** - CSS autocomplete
4. **ESLint** - Code linting
5. **Prettier** - Code formatting

### VS Code Settings
Create `.vscode/settings.json`:
```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

---

## Testing Checklist

After installation, verify:

- [ ] Backend starts without errors
- [ ] Frontend starts without errors
- [ ] Can register new user
- [ ] Can login
- [ ] Can view mess menu
- [ ] AI mail summarizer works
- [ ] Can create lost & found item
- [ ] Can view marketplace
- [ ] Can create travel share
- [ ] Can view campus hubs
- [ ] Can add review
- [ ] Can view timetable
- [ ] Can create assignment
- [ ] Can mark assignment complete
- [ ] AI insights load
- [ ] Real-time updates work
- [ ] Responsive on mobile

---

## Next Steps

1. **Customize**: Edit colors in `frontend/tailwind.config.js`
2. **Add Data**: Create more hubs, menu items, etc.
3. **Deploy**: Follow DEPLOYMENT.md for production setup
4. **Extend**: Add new features based on your needs

---

## Common Commands Reference

### Backend
```bash
npm run dev          # Start development server
npm start            # Start production server
npm run migrate      # Run database migrations
npm run generate     # Generate Prisma client
npm run seed         # Seed database
```

### Frontend
```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run preview      # Preview production build
```

### Database
```bash
npx prisma studio    # Open Prisma Studio (GUI)
npx prisma migrate reset  # Reset database
npx prisma db push   # Push schema without migration
```

---

## Support

If you encounter issues:
1. Check this guide's troubleshooting section
2. Review error messages carefully
3. Check environment variables are correct
4. Verify all prerequisites are installed
5. Try resetting database and reseeding

---

## Success Indicators

You'll know everything is working when:
- ✅ No errors in backend terminal
- ✅ No errors in frontend terminal
- ✅ Can login and see all 4 modules
- ✅ AI features respond (may take 2-3 seconds)
- ✅ Real-time updates work
- ✅ Data persists after refresh

Happy coding! 🚀
