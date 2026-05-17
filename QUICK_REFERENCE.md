# CivicFix+ Quick Reference Commands

## 🚀 STARTUP (30 seconds)
```bash
cd C:\Users\pruthviraj\OneDrive\Desktop\jdk\CivicFix
docker-compose up -d
# Wait 15-20 seconds
# Open: http://localhost:8090
```

## 🛑 SHUTDOWN
```bash
docker-compose down
```

## 🔄 FULL RESTART (with fresh database)
```bash
docker-compose down -v
docker-compose up -d
# Wait 15-20 seconds
```

## 📊 CHECK STATUS
```bash
docker ps
# Should show: civicfix_app (healthy) and civicfix_db (healthy)
```

## 📋 VIEW LOGS
```bash
# Application logs:
docker-compose logs civicfix_app -f

# Database logs:
docker-compose logs civicfix_db -f

# Both:
docker-compose logs -f
```

## 🗄️ DATABASE COMMANDS
```bash
# Access MySQL directly:
docker exec civicfix_db mysql -u root -ppassword civicfix_db

# Quick queries:
docker exec civicfix_db mysql -u root -ppassword civicfix_db -e "SELECT COUNT(*) FROM complaints;"
docker exec civicfix_db mysql -u root -ppassword civicfix_db -e "SELECT username, role FROM users;"
docker exec civicfix_db mysql -u root -ppassword civicfix_db -e "SELECT * FROM complaints LIMIT 3\G"
```

## 🏗️ BUILD & DEPLOY
```bash
# Build WAR file:
mvn clean package -DskipTests

# Full rebuild with Docker:
docker-compose down
mvn clean package -DskipTests
docker-compose up -d --build
```

## 🔧 DEBUGGING
```bash
# See what's on port 8090:
netstat -ano | findstr :8090

# See what's on port 3309:
netstat -ano | findstr :3309

# Kill container and restart:
docker stop civicfix_app
docker start civicfix_app

# Rebuild specific container:
docker-compose up -d --build civicfix_app
```

## 📱 TEST LOGINS
```
CITIZEN:   citizen1 / password
ADMIN:     admin / password
WORKER:    worker_ravi / password
OFFICIAL:  official_sharma / password
```

## 🌐 KEY URLS
```
Home:               http://localhost:8090
Login:              http://localhost:8090/login
Citizen Dashboard:  http://localhost:8090/citizen/dashboard
Report Issue:       http://localhost:8090/citizen/complaint/new
Leaderboard:        http://localhost:8090/leaderboard
Transparency:       http://localhost:8090/transparency
```

## ⚡ QUICK HEALTH CHECK
```bash
# 1. Check containers running
docker ps -f "name=civicfix"

# 2. Check app responds
curl -I http://localhost:8090

# 3. Check database connection
docker exec civicfix_db mysql -u root -ppassword civicfix_db -e "SELECT 1;"

# 4. Check for errors in logs
docker-compose logs --tail=50
```

## 📦 PROJECT STRUCTURE
```
CivicFix/
├── pom.xml                    # Maven dependencies
├── docker-compose.yml         # Docker configuration ⭐
├── Dockerfile                 # App container
├── schema.sql                 # Database initialization ⭐
├── DEMO_SCRIPT.md             # 2-minute demo guide ⭐
├── DEMO_SETUP_COMPLETE.md     # Setup summary ⭐
└── src/
    └── main/
        ├── java/com/civicfix/
        │   ├── controller/     # Spring MVC controllers
        │   ├── service/        # Business logic
        │   ├── dao/            # Hibernate data access
        │   ├── entity/         # JPA entities
        │   └── config/         # Spring configuration
        ├── resources/
        │   ├── application.properties
        │   └── logback.xml
        └── webapp/
            ├── WEB-INF/
            │   ├── applicationContext.xml
            │   ├── dispatcher-servlet.xml
            │   ├── web.xml
            │   └── views/      # JSP templates
            └── resources/      # CSS, JS, images
```

## 🎯 FOR YOUR DEMO
1. Run: `docker-compose up -d`
2. Open: http://localhost:8090
3. Follow: DEMO_SCRIPT.md
4. Use credentials above
5. That's it! You're ready.

## 💡 TROUBLESHOOTING

**App won't start?**
```bash
# Check logs
docker-compose logs civicfix_app
# Usually means port 8090 is in use
```

**Can't login?**
```bash
# Check database is running and has users
docker exec civicfix_db mysql -u root -ppassword civicfix_db -e "SELECT username FROM users;"
# If empty, restart: docker-compose down -v && docker-compose up -d
```

**Slow startup?**
```bash
# Normal - Tomcat can take 20-30 seconds first time
# Check health: docker ps
# Wait for all containers to show (healthy)
```

**Database connection error?**
```bash
# The app container needs to wait for DB
# Check docker-compose.yml has depends_on with condition: service_healthy
docker-compose logs | grep "mysql"
# Wait 30+ seconds if you see connection refused
```

## 🔗 PORTS REFERENCE
- **8090**: Web Application (external)
- **8080**: Tomcat (internal container)
- **3309**: MySQL (external)  
- **3306**: MySQL (internal container)

---

**Remember:** All demo users password is "password" except admin is "password" too!
