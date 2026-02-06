# Project Nexus - Architecture Diagrams

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT LAYER                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ Daily Pulse  │  │   Student    │  │  Explorer's  │          │
│  │   Module     │  │   Exchange   │  │    Guide     │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  ┌──────────────┐  ┌──────────────────────────────────┐        │
│  │  Academic    │  │   React + TailwindCSS + Vite     │        │
│  │   Cockpit    │  │   Socket.io-client + Axios       │        │
│  └──────────────┘  └──────────────────────────────────┘        │
│                                                                   │
└───────────────────────────┬─────────────────────────────────────┘
                            │ HTTPS / WebSocket
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                      APPLICATION LAYER                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌────────────────────────────────────────────────────────┐    │
│  │              Express.js REST API                        │    │
│  │  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐        │    │
│  │  │ Auth │ │ Mess │ │ Exch │ │ Expl │ │ Acad │        │    │
│  │  └──────┘ └──────┘ └──────┘ └──────┘ └──────┘        │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                   │
│  ┌────────────────────────────────────────────────────────┐    │
│  │              Socket.io Real-time Server                 │    │
│  │  • Menu Updates  • Chat  • Notifications               │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                   │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                  Middleware Layer                       │    │
│  │  • JWT Auth  • CORS  • Validation  • Error Handler    │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                   │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                       SERVICE LAYER                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────────┐         ┌──────────────────┐             │
│  │   AI Service     │         │   ML Service     │             │
│  │  ┌────────────┐  │         │  ┌────────────┐  │             │
│  │  │  OpenAI    │  │         │  │TensorFlow.js│ │             │
│  │  │  GPT-3.5   │  │         │  │ Categorizer │ │             │
│  │  └────────────┘  │         │  └────────────┘  │             │
│  │  • Email Sum.    │         │  • Item Cat.     │             │
│  │  • Study Tips    │         │  • Workload Pred.│             │
│  └──────────────────┘         └──────────────────┘             │
│                                                                   │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                        DATA LAYER                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                   Prisma ORM                            │    │
│  └────────────────────────────────────────────────────────┘    │
│                            │                                     │
│  ┌────────────────────────────────────────────────────────┐    │
│  │              PostgreSQL Database                        │    │
│  │  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐        │    │
│  │  │Users │ │ Menu │ │Items │ │ Hubs │ │ Acad │        │    │
│  │  └──────┘ └──────┘ └──────┘ └──────┘ └──────┘        │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Data Flow Diagram

### User Authentication Flow
```
┌──────┐     Register/Login      ┌──────────┐
│Client│ ───────────────────────>│  Backend │
└──────┘                          └──────────┘
   │                                    │
   │                              Hash Password
   │                              (bcrypt)
   │                                    │
   │                              Store in DB
   │                                    │
   │         JWT Token + User     ┌──────────┐
   │<─────────────────────────────│PostgreSQL│
   │                              └──────────┘
   │
Store Token
(localStorage)
```

### AI Email Summarization Flow
```
┌──────┐   Email Content   ┌──────────┐   API Request   ┌─────────┐
│Client│ ─────────────────>│  Backend │ ───────────────>│ OpenAI  │
└──────┘                    └──────────┘                 └─────────┘
   │                             │                            │
   │                             │                       GPT-3.5
   │                             │                       Processing
   │                             │                            │
   │      Summary          ┌──────────┐    Summary      ┌─────────┐
   │<──────────────────────│  Backend │<─────────────────│ OpenAI  │
   │                       └──────────┘                  └─────────┘
   │
Display
Summary
```

### Real-time Chat Flow
```
User A                    Server                    User B
  │                         │                         │
  │  join-chat(itemId)      │                         │
  ├────────────────────────>│                         │
  │                         │  join-chat(itemId)      │
  │                         │<────────────────────────┤
  │                         │                         │
  │  send-message           │                         │
  ├────────────────────────>│                         │
  │                         │  new-message            │
  │                         ├────────────────────────>│
  │  new-message            │                         │
  │<────────────────────────┤                         │
  │                         │                         │
```

---

## Module Integration Map

```
┌─────────────────────────────────────────────────────────────┐
│                     PROJECT NEXUS ECOSYSTEM                  │
└─────────────────────────────────────────────────────────────┘

┌──────────────┐         ┌──────────────┐         ┌──────────────┐
│ Daily Pulse  │────────>│   Student    │────────>│ Explorer's   │
│              │         │   Exchange   │         │    Guide     │
│ • Mess Menu  │         │ • Lost/Found │         │ • Hubs       │
│ • Mail AI    │         │ • Marketplace│         │ • Reviews    │
└──────┬───────┘         └──────┬───────┘         └──────┬───────┘
       │                        │                        │
       │                        │                        │
       └────────────────────────┼────────────────────────┘
                                │
                                ▼
                        ┌──────────────┐
                        │  Academic    │
                        │   Cockpit    │
                        │ • Timetable  │
                        │ • Assignments│
                        │ • AI Insights│
                        └──────────────┘

Integration Examples:
1. Lost item location → Campus hub for meetup
2. Study schedule → Hub recommendations
3. Mess menu → Food hub reviews
4. Travel share → Campus locations
```

---

## Database Schema Relationships

```
┌──────────┐
│   User   │
└────┬─────┘
     │
     ├──────────> LostFound
     │
     ├──────────> MarketItem ──────> Message
     │
     ├──────────> TravelShare
     │
     ├──────────> Review ──────> Hub
     │
     ├──────────> Timetable
     │
     └──────────> Assignment

Relationships:
• User (1) ──> (N) LostFound
• User (1) ──> (N) MarketItem
• User (1) ──> (N) TravelShare
• User (1) ──> (N) Review
• User (1) ──> (N) Timetable
• User (1) ──> (N) Assignment
• Hub (1) ──> (N) Review
• MarketItem (1) ──> (N) Message
```

---

## API Request Flow

```
1. Client Request
   ↓
2. CORS Middleware
   ↓
3. Auth Middleware (if protected)
   ↓
4. Route Handler
   ↓
5. Controller Logic
   ↓
6. Service Layer (AI/ML if needed)
   ↓
7. Prisma ORM
   ↓
8. PostgreSQL Database
   ↓
9. Response to Client
```

---

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    PRODUCTION SETUP                      │
└─────────────────────────────────────────────────────────┘

Internet
   │
   ├──────────────────────────────────────────┐
   │                                           │
   ▼                                           ▼
┌─────────────┐                         ┌─────────────┐
│   Vercel    │                         │   Railway   │
│   (CDN)     │                         │  (Backend)  │
│             │                         │             │
│  Frontend   │◄────── API Calls ──────>│  Node.js    │
│   React     │                         │  Express    │
│  Static     │                         │  Socket.io  │
└─────────────┘                         └──────┬──────┘
                                               │
                                               ▼
                                        ┌─────────────┐
                                        │   Railway   │
                                        │ PostgreSQL  │
                                        └─────────────┘
                                               │
                                               ▼
                                        ┌─────────────┐
                                        │   OpenAI    │
                                        │     API     │
                                        └─────────────┘

Features:
• Auto-scaling
• HTTPS/SSL
• CDN caching
• Automatic backups
• Environment variables
• CI/CD ready
```

---

## Security Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    SECURITY LAYERS                       │
└─────────────────────────────────────────────────────────┘

Layer 1: Transport Security
├─ HTTPS/TLS encryption
└─ Secure WebSocket (WSS)

Layer 2: Authentication
├─ JWT tokens
├─ bcrypt password hashing
└─ Token expiration

Layer 3: Authorization
├─ Role-based access
├─ Protected routes
└─ Middleware checks

Layer 4: Input Validation
├─ Request validation
├─ SQL injection prevention (Prisma)
└─ XSS protection (React)

Layer 5: Environment Security
├─ Environment variables
├─ No secrets in code
└─ .gitignore configured

Layer 6: API Security
├─ CORS configuration
├─ Rate limiting ready
└─ API key management
```

---

## Performance Optimization Strategy

```
Frontend Optimizations:
├─ Code splitting (React.lazy)
├─ Image optimization
├─ Minification (Vite)
├─ Tree shaking
└─ CDN delivery

Backend Optimizations:
├─ Database indexing
├─ Connection pooling
├─ Caching strategy (Redis ready)
├─ Query optimization
└─ Compression (gzip)

Database Optimizations:
├─ Indexed foreign keys
├─ Efficient queries
├─ Connection pooling
└─ Query result caching
```

---

## Scalability Plan

```
Current (MVP):
Single server, single database

Phase 1 (100-1000 users):
├─ Add Redis caching
├─ Enable CDN
└─ Database read replicas

Phase 2 (1000-10000 users):
├─ Horizontal scaling (multiple servers)
├─ Load balancer
├─ Separate Socket.io server
└─ Database sharding

Phase 3 (10000+ users):
├─ Microservices architecture
├─ Message queue (RabbitMQ)
├─ Separate AI service
└─ Multi-region deployment
```

---

## Technology Stack Diagram

```
┌─────────────────────────────────────────────────────────┐
│                    TECHNOLOGY STACK                      │
└─────────────────────────────────────────────────────────┘

Frontend:
├─ React 18 (UI Library)
├─ Vite (Build Tool)
├─ TailwindCSS (Styling)
├─ React Router (Routing)
├─ Axios (HTTP Client)
├─ Socket.io-client (Real-time)
└─ Lucide React (Icons)

Backend:
├─ Node.js (Runtime)
├─ Express (Web Framework)
├─ Socket.io (WebSocket)
├─ Prisma (ORM)
├─ JWT (Authentication)
├─ bcrypt (Password Hashing)
└─ CORS (Security)

Database:
└─ PostgreSQL (Relational DB)

AI/ML:
├─ OpenAI API (GPT-3.5)
└─ TensorFlow.js (ML)

DevOps:
├─ Git (Version Control)
├─ Vercel (Frontend Hosting)
├─ Railway (Backend + DB)
└─ GitHub (Repository)
```

This architecture provides a solid foundation for a production-ready campus super-app with room for growth and scalability.
