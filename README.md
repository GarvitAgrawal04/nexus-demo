# Project Nexus - Campus Super-App

## Overview
Project Nexus is an integrated campus ecosystem connecting students through 4 intelligent modules with AI-powered features and real-time updates.

## Features

### 1. Daily Pulse
- Live mess menu with real-time updates
- AI-powered mail summarizer (OpenAI GPT)
- Push notifications for menu changes

### 2. Student Exchange
- Lost & Found with AI image categorization
- Buy/Sell marketplace
- Travel sharing & carpooling
- Real-time chat for negotiations

### 3. Explorer's Guide
- Nearby campus hubs discovery
- Location-based recommendations
- Student reviews & ratings

### 4. Academic Cockpit
- Personal timetable management
- LMS lite (assignments, deadlines)
- AI academic insights & study patterns

## Tech Stack
- **Frontend**: React 18, Vite, TailwindCSS, Socket.io-client
- **Backend**: Node.js, Express, Socket.io, Prisma
- **Database**: PostgreSQL
- **AI/ML**: OpenAI API, TensorFlow.js
- **Auth**: JWT, bcrypt

## Setup Instructions

### Prerequisites
- Node.js 18+
- PostgreSQL 14+
- OpenAI API key

### Backend Setup
```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your credentials
npx prisma migrate dev
npx prisma generate
npm run dev
```

### Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

### Environment Variables
See `.env.example` for required variables.

## API Documentation
Base URL: `http://localhost:5000/api`

### Auth Endpoints
- POST `/auth/register` - Register new user
- POST `/auth/login` - Login user
- GET `/auth/me` - Get current user

### Daily Pulse
- GET `/mess-menu` - Get today's menu
- POST `/mail/summarize` - Summarize email (AI)

### Student Exchange
- GET `/exchange/lost-found` - List lost items
- POST `/exchange/lost-found` - Report lost/found item
- GET `/exchange/marketplace` - List items for sale
- POST `/exchange/travel` - Create travel share

### Explorer's Guide
- GET `/explore/hubs` - Get nearby hubs
- POST `/explore/reviews` - Add review

### Academic Cockpit
- GET `/academic/timetable` - Get user timetable
- POST `/academic/assignments` - Create assignment
- GET `/academic/insights` - AI study insights

## Real-time Features
- Mess menu updates (Socket.io)
- Chat for marketplace items
- Live notifications

## Deployment
- Frontend: Vercel
- Backend: Railway
- Database: Railway PostgreSQL

## License
MIT
