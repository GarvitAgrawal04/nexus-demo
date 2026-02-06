@echo off
echo ========================================
echo Project Nexus - Setup Script
echo ========================================
echo.

echo [1/5] Installing Backend Dependencies...
cd backend
call npm install
if %errorlevel% neq 0 (
    echo Backend installation failed!
    exit /b %errorlevel%
)
echo Backend dependencies installed successfully!
echo.

echo [2/5] Setting up Database...
copy ..\\.env.example .env
echo Please edit backend\.env with your database credentials and API keys
pause
call npx prisma generate
call npx prisma migrate dev --name init
echo Database setup complete!
echo.

echo [3/5] Installing Frontend Dependencies...
cd ..\frontend
call npm install
if %errorlevel% neq 0 (
    echo Frontend installation failed!
    exit /b %errorlevel%
)
echo Frontend dependencies installed successfully!
echo.

echo [4/5] Creating Frontend Environment...
echo VITE_API_URL=http://localhost:5000/api > .env
echo VITE_SOCKET_URL=http://localhost:5000 >> .env
echo.

echo [5/5] Setup Complete!
echo.
echo ========================================
echo Next Steps:
echo ========================================
echo 1. Edit backend\.env with your credentials
echo 2. Start backend: cd backend && npm run dev
echo 3. Start frontend: cd frontend && npm run dev
echo 4. Open http://localhost:5173
echo ========================================
cd ..
