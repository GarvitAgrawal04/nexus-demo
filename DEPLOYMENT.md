# Deployment Guide - Project Nexus

## Prerequisites
- GitHub account
- Vercel account (for frontend)
- Railway account (for backend + database)
- OpenAI API key

## Step 1: Push to GitHub

```bash
cd project-nexus
git init
git add .
git commit -m "Initial commit - Project Nexus MVP"
git branch -M main
git remote add origin <your-github-repo-url>
git push -u origin main
```

## Step 2: Deploy Database (Railway)

1. Go to https://railway.app
2. Click "New Project" → "Provision PostgreSQL"
3. Copy the DATABASE_URL from the PostgreSQL service
4. Save it for backend deployment

## Step 3: Deploy Backend (Railway)

1. In Railway, click "New" → "GitHub Repo"
2. Select your project-nexus repository
3. Railway will auto-detect Node.js
4. Add environment variables:
   - `DATABASE_URL`: (from Step 2)
   - `JWT_SECRET`: (generate a random string)
   - `OPENAI_API_KEY`: (your OpenAI key)
   - `NODE_ENV`: production
   - `FRONTEND_URL`: (will add after frontend deployment)
5. Set root directory to `backend`
6. Set start command: `npm start`
7. Deploy and copy the backend URL

## Step 4: Run Database Migrations

In Railway backend service terminal:
```bash
npx prisma migrate deploy
npx prisma generate
```

## Step 5: Deploy Frontend (Vercel)

1. Go to https://vercel.com
2. Click "New Project" → Import your GitHub repo
3. Set root directory to `frontend`
4. Add environment variables:
   - `VITE_API_URL`: https://your-backend-url.railway.app/api
   - `VITE_SOCKET_URL`: https://your-backend-url.railway.app
5. Deploy

## Step 6: Update Backend CORS

Go back to Railway backend environment variables and update:
- `FRONTEND_URL`: https://your-frontend-url.vercel.app

Redeploy the backend service.

## Step 7: Seed Initial Data (Optional)

Create a seed script or manually add:
- Sample mess menu items
- Campus hubs
- Test users

## Testing Deployment

1. Visit your Vercel URL
2. Register a new account
3. Test all 4 modules:
   - Daily Pulse (mess menu + mail summarizer)
   - Student Exchange (lost & found, marketplace, travel)
   - Explorer's Guide (hubs + reviews)
   - Academic Cockpit (timetable + assignments + AI insights)

## Monitoring

- Railway: Check logs for backend errors
- Vercel: Check deployment logs for frontend issues
- OpenAI: Monitor API usage in dashboard

## Custom Domain (Optional)

### Vercel (Frontend)
1. Go to Project Settings → Domains
2. Add your custom domain
3. Update DNS records as instructed

### Railway (Backend)
1. Go to Service Settings → Networking
2. Add custom domain
3. Update DNS records

## Environment Variables Checklist

### Backend (.env)
- [x] DATABASE_URL
- [x] JWT_SECRET
- [x] OPENAI_API_KEY
- [x] PORT (5000)
- [x] NODE_ENV (production)
- [x] FRONTEND_URL

### Frontend (.env)
- [x] VITE_API_URL
- [x] VITE_SOCKET_URL

## Troubleshooting

### Database Connection Issues
- Verify DATABASE_URL format
- Check Railway PostgreSQL is running
- Ensure migrations are applied

### CORS Errors
- Verify FRONTEND_URL in backend matches Vercel URL
- Check both URLs use HTTPS in production

### Socket.io Connection Failed
- Ensure VITE_SOCKET_URL is correct
- Check Railway backend is running
- Verify WebSocket support is enabled

### OpenAI API Errors
- Verify API key is valid
- Check API quota/billing
- Monitor rate limits

## Cost Estimation

- Railway: ~$5/month (Hobby plan)
- Vercel: Free (Hobby plan)
- PostgreSQL: Included in Railway
- OpenAI API: Pay-as-you-go (~$0.002 per request)

Total: ~$5-10/month for MVP

## Security Checklist

- [x] JWT secret is strong and random
- [x] Database credentials are not in code
- [x] API keys are in environment variables
- [x] CORS is properly configured
- [x] HTTPS is enabled (automatic on Vercel/Railway)
- [x] Input validation on all endpoints
- [x] Password hashing with bcrypt

## Performance Optimization

1. Enable Vercel Edge Network
2. Add database indexes for frequent queries
3. Implement Redis caching (optional)
4. Optimize images with CDN
5. Enable gzip compression

## Backup Strategy

1. Railway automatic PostgreSQL backups
2. GitHub for code versioning
3. Export critical data weekly
