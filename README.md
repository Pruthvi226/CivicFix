# CivicFix+ 🏛️ AI-Enhanced Smart City Solutions

**CivicFix+** is a powerful Smart City Citizen Complaint & Public Infrastructure Tracker. It leverages Java logic to provide intelligent classification, duplicate detection, and predictive maintenance to help local governments resolve issues efficiently while rewarding civic engagement.

---

## ✨ Novel AI Features (Built with Pure Java)

1.  **🤖 AI Complaint Classifier:** Automatically detects category (Pothole, Drain, etc.) and severity levels from plain language descriptions using rule-based NLP.
2.  **📍 Duplicate Radar:** Prevents redundant reports by checking for existing complaints within 100 meters using the Haversine formula.
3.  **🏆 Citizen Karma System:** Citizens earn points and badges for reporting valid issues, upvoting others, and verifying resolutions.
4.  **⚡ Predictive Maintenance:** Analyzes historical clusters to flag infrastructure likely to fail before it happens.
5.  **📊 Live Ward Health Score:** Real-time (0-100) performance metrics for every ward in the city.
6.  **📣 Anonymous Whistleblower Mode:** Secure, AES-encrypted channel for reporting corruption or fake resolutions anonymously.

---

-   **Backend:** Java 21, Spring MVC 5.x, Hibernate ORM 5.x
-   **Database:** MySQL 8.x
-   **Frontend:** JSP, JSTL, Vanilla CSS (Premium Modern Design)
-   **Testing:** JUnit 5, Mockito 5, Byte Buddy (Java 21+ support)
-   **Build Tool:** Maven
-   **Deployment:** Docker-ready (Render, Railway, or AWS)

---

## 📁 Project Structure

-   `src/main/java/com/civicfix/entity`: Hibernate persistent entities.
-   `src/main/java/com/civicfix/service`: Core business logic (AI, Haversine, Schedulers).
-   `src/main/java/com/civicfix/controller`: Spring MVC Controllers handling routing.
-   `src/main/webapp/WEB-INF/views`: JSP templates for Citizens, Workers, and Officials.
-   `schema.sql`: Complete database schema and seed data.

---

## 🚀 Getting Started

### Local Setup
1.  **Database:** Create a MySQL DB named `civicfix_db` and run `schema.sql`.
2.  **Configuration:** Update `src/main/resources/application.properties` with your local credentials.
3.  **Build:** Run `mvn clean package`.
4.  **Deploy:** Run the generated `.war` file on Apache Tomcat 9.

### Cloud Deployment (Render)
This project is pre-configured for Render via `render.yaml` and `Dockerfile`.
1.  Push code to GitHub.
2.  Connect repository to **Render Blueprint**.
3.  Set `DB_URL`, `DB_USER`, and `DB_PASSWORD` in the Render dashboard.

### 🧪 Automated Testing
Run the comprehensive test suite (Unit + Integration):
```bash
mvn clean test
```
*Note: Uses experimental Byte Buddy flags for full compatibility with Java 21/25 runtimes.*

---


