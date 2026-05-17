# CivicFix+

**Smart civic issue tracking with Spring MVC, Hibernate, MySQL, JSP, and role-based municipal workflows.**

![Java](https://img.shields.io/badge/Java-21-orange?logo=openjdk)
![Spring MVC](https://img.shields.io/badge/Spring%20MVC-5.3.30-6DB33F?logo=spring)
![Hibernate](https://img.shields.io/badge/Hibernate-5.6.15-59666C?logo=hibernate)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)
![JSP](https://img.shields.io/badge/JSP%20%2B%20JSTL-Servlet%204.0-blue)
![Maven](https://img.shields.io/badge/Maven-WAR%20Build-C71A36?logo=apachemaven)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)

CivicFix+ is a full-stack Java web application for reporting, assigning, resolving, and publicly tracking civic infrastructure issues such as potholes, drainage failures, broken streetlights, and garbage collection problems. The project demonstrates a traditional enterprise Java MVC architecture with Spring MVC controllers, Hibernate-backed DAO repositories, JSP/JSTL views, session-based authentication, file uploads, public analytics, and Dockerized MySQL deployment.

**Portfolio one-liner:** A role-based smart-city complaint management platform where citizens report issues, officials assign workers, field teams upload resolution proof, and the public can track city performance transparently.

## Project Overview

CivicFix+ models a real municipal issue-resolution workflow:

1. Citizens register or log in, submit location-tagged complaints, upload evidence, and track status.
2. The complaint form uses AJAX endpoints to classify issue category/severity and detect nearby duplicates.
3. Officials review city-wide complaints, search/filter using Hibernate Criteria API, assign workers, view audit dashboards, and export CSV data.
4. Workers see assigned jobs on a schedule/map page, upload resolution proof, and mark tasks as resolved.
5. Citizens verify whether the fix is acceptable; accepted fixes update status and award karma points.
6. Public users can view city health, transparency charts, ward details, leaderboards, and anonymous whistleblower reporting.

## Key Features

| Area | Implemented Functionality |
| --- | --- |
| Authentication | Login, registration, logout, session storage, role-aware redirects, protected routes through `AuthFilter` and controller checks. |
| Citizen workflow | Report complaints, upload evidence files, view personal dashboard, verify resolutions, view karma ledger, redeem perks. |
| Official workflow | Command center, pending issue queue, worker assignment, simple search, advanced Criteria API filtering, CSV export, audit dashboard, ward heatmap. |
| Worker workflow | Worker dashboard, assigned task schedule, Leaflet task map, resolution proof upload, task history. |
| Public transparency | Home page, ward health leaderboard, citizen karma leaderboard, transparency charts, ward detail pages. |
| Smart classification | `ComplaintClassifierService` uses keyword-based NLP rules to infer category, severity, and estimated fix time. |
| Duplicate detection | `DuplicateRadarService` uses the Haversine formula to find same-category complaints within 100 meters in the last 30 days. |
| Civic rewards | `KarmaEngineService` records auditable karma transactions and updates citizen balances. |
| Predictive maintenance | Scheduled service scans verified complaint clusters and creates preventive maintenance advisories. |
| Secure reporting | Anonymous whistleblower reports are encrypted using the AES utility before persistence. |
| File handling | Multipart uploads with a 10 MB limit and evidence serving with path traversal protection. |
| Observability | Logback logging plus a servlet performance audit filter for endpoint timing. |

## Tech Stack

| Layer | Technology |
| --- | --- |
| Language | Java 21 |
| Web framework | Spring MVC 5.3.30 |
| Persistence | Hibernate ORM 5.6.15.Final, JPA annotations |
| Database | MySQL 8.0 for Docker/local production, H2 in-memory defaults for lightweight local startup |
| View layer | JSP, JSTL, JSP taglibs |
| Frontend | HTML, CSS, vanilla JavaScript, Chart.js, Leaflet.js, Font Awesome |
| Build | Maven WAR packaging |
| Runtime | Apache Tomcat 9 in Docker, Jetty Maven plugin for local development |
| Testing | JUnit 5, Mockito, Spring Test |
| Deployment | Dockerfile, docker-compose, Render blueprint |

## Architecture

CivicFix+ follows a layered MVC architecture:

```text
Browser / JSP Views
        |
        v
Spring DispatcherServlet
        |
        v
Controllers
AuthController, CitizenController, OfficialController, WorkerController, PublicController
        |
        v
Services
Classifier, Duplicate Radar, Karma Engine, Scheduling, Predictive Maintenance
        |
        v
DAO Layer
BaseDaoImpl + entity-specific DAO implementations
        |
        v
Hibernate SessionFactory / Transactions
        |
        v
MySQL or H2 Database
```

### MVC and Backend Design

| Pattern | Evidence in Codebase |
| --- | --- |
| Model | Hibernate entities in `src/main/java/com/civicfix/entity` such as `Complaint`, `User`, `Ward`, `KarmaTransaction`, `Perk`, `Notification`, and `WhistleblowerReport`. |
| View | JSP pages under `src/main/webapp/WEB-INF/views`, grouped by `public`, `common`, `citizen`, `official`, and `worker`. |
| Controller | Spring MVC controllers in `src/main/java/com/civicfix/controller` using `@Controller`, `@GetMapping`, `@PostMapping`, `@RequestMapping`, and `@ResponseBody`. |
| Service Layer | Business logic in `src/main/java/com/civicfix/service`, including classification, duplicate detection, karma, scheduling, and predictive analytics. |
| DAO Layer | Reusable `BaseDao` / `BaseDaoImpl` with Hibernate `SessionFactory`, plus entity-specific DAO implementations. |
| Transactions | XML-configured `HibernateTransactionManager` and `@Transactional` service/DAO methods. |

## Project Structure

```text
CivicFix/
|-- pom.xml
|-- Dockerfile
|-- docker-compose.yml
|-- render.yaml
|-- schema.sql
|-- README.md
|-- screenshots/
|   `-- README.md
|-- src/
|   |-- main/
|   |   |-- java/com/civicfix/
|   |   |   |-- config/
|   |   |   |   |-- AuthFilter.java
|   |   |   |   `-- DataInitializer.java
|   |   |   |-- controller/
|   |   |   |   |-- AuthController.java
|   |   |   |   |-- CitizenController.java
|   |   |   |   |-- FileController.java
|   |   |   |   |-- HealthController.java
|   |   |   |   |-- OfficialController.java
|   |   |   |   |-- PublicController.java
|   |   |   |   `-- WorkerController.java
|   |   |   |-- dao/
|   |   |   |-- dto/
|   |   |   |-- entity/
|   |   |   |-- exception/
|   |   |   |-- filter/
|   |   |   |-- service/
|   |   |   `-- util/
|   |   |-- resources/
|   |   |   |-- application.properties
|   |   |   `-- logback.xml
|   |   `-- webapp/
|   |       |-- resources/css/style.css
|   |       `-- WEB-INF/
|   |           |-- applicationContext.xml
|   |           |-- dispatcher-servlet.xml
|   |           |-- web.xml
|   |           `-- views/
|   |               |-- citizen/
|   |               |-- common/
|   |               |-- official/
|   |               |-- public/
|   |               `-- worker/
|   `-- test/java/com/civicfix/
|       |-- controller/
|       `-- service/
`-- uploads/
```

## Database Design

The MySQL schema is defined in `schema.sql` and includes seed data for wards, demo users, complaints, karma transactions, perks, and predictive flags.

| Table | Purpose |
| --- | --- |
| `wards` | City wards/zones with calculated health scores. |
| `users` | Citizens, workers, officials, and admins with role and karma metadata. |
| `complaints` | Core issue reports with category, severity, status, GPS coordinates, evidence path, worker assignment, and verification state. |
| `karma_transactions` | Audit ledger for karma point awards and reasons. |
| `predictive_flags` | Preventive maintenance advisories for risky ward/category clusters. |
| `whistleblower_reports` | Anonymous encrypted reports with tracking tokens and investigation status. |
| `notifications` | Unread user notifications, especially resolution verification prompts. |
| `perks` | Redeemable marketplace rewards funded by karma points. |

Key relationships:

- `users.ward_id -> wards.id`
- `complaints.citizen_id -> users.id`
- `complaints.ward_id -> wards.id`
- `complaints.assigned_worker_id -> users.id`
- `karma_transactions.citizen_id -> users.id`
- `notifications.user_id -> users.id`
- `predictive_flags.ward_id -> wards.id`

## Routes and APIs

| Module | Route | Method | Description |
| --- | --- | --- | --- |
| Public | `/`, `/home` | GET | Public home page. |
| Public | `/leaderboard` | GET | Ward health ranking and top citizen karma leaderboard. |
| Public | `/transparency` | GET | Public analytics with Chart.js data. |
| Public | `/ward/{id}` | GET | Ward-level complaint and health detail page. |
| Public | `/whistleblower` | GET | Anonymous report form. |
| Public | `/whistleblower/submit` | POST | Encrypts and stores whistleblower report. |
| Auth | `/login` | GET/POST | Login page and credential validation. |
| Auth | `/register` | GET/POST | User registration with duplicate username/email checks. |
| Auth | `/logout` | GET | Invalidates session. |
| Citizen | `/citizen/dashboard` | GET | Citizen complaint tracker and notifications. |
| Citizen | `/citizen/complaint/new` | GET | New complaint form. |
| Citizen | `/citizen/complaint/submit` | POST | Creates complaint and stores evidence upload. |
| Citizen API | `/citizen/api/classify` | POST | Returns category, severity, and fix-time estimate from description text. |
| Citizen API | `/citizen/api/check-duplicates` | POST | Returns nearby duplicate complaints by GPS and category. |
| Citizen | `/citizen/complaint/{id}/verify` | GET/POST | Accepts or rejects worker resolution. |
| Citizen | `/citizen/perks` | GET | Karma marketplace. |
| Citizen | `/citizen/perks/redeem/{id}` | POST | Redeems perk if karma balance is sufficient. |
| Citizen | `/citizen/karma-history` | GET | Karma transaction ledger. |
| Official | `/official/dashboard` | GET | Command center with assignment queue. |
| Official | `/official/search` | GET | Search by ID, description, or address. |
| Official | `/official/advancedSearch` | GET | Hibernate Criteria API filtering by status, category, ward, and severity. |
| Official | `/official/complaint/{id}/assign` | POST | Assigns complaint to worker and updates status. |
| Official | `/official/export` | GET | Downloads complaint CSV. |
| Official | `/official/audit` | GET | City performance audit dashboard. |
| Official | `/official/heatmap` | GET | Ward health heatmap. |
| Worker | `/worker/dashboard` | GET | Worker metrics and quick actions. |
| Worker | `/worker/schedule` | GET | Assigned tasks and Leaflet map data. |
| Worker | `/worker/complaint/{id}/resolve` | POST | Uploads resolution proof and marks complaint resolved. |
| Worker | `/worker/history` | GET | Completed task history. |
| Files | `/files/evidence/{filename}` | GET | Authenticated evidence/resolution file serving. |
| Health | `/health` | GET | Deployment health check endpoint. |

## Authentication and Validation

- Passwords are hashed with SHA-256 and Base64 in `PasswordUtil`.
- `AuthController` stores the authenticated `User` in the HTTP session.
- Role-specific dashboards are selected after login: citizen, worker, and official.
- `AuthFilter` whitelists public pages and redirects unauthenticated private requests to `/login`.
- Controllers also enforce role checks before returning role-specific pages.
- Registration validates duplicate username and email through `UserDao`.
- Complaint submission relies on required JSP form fields and server-side entity persistence.
- File uploads are limited to 10 MB by `CommonsMultipartResolver`.
- `FileController` normalizes paths to block path traversal attacks.

## Installation

### Prerequisites

- Java 21 or newer
- Maven 3.9+
- MySQL 8.0, or Docker Desktop with Compose
- Apache Tomcat 9 if deploying the generated WAR manually

### Clone and Build

```bash
git clone <your-repository-url>
cd CivicFix
mvn clean package
```

The build generates:

```text
target/civicfix.war
```

## Configuration

Application properties are loaded from `src/main/resources/application.properties` and can be overridden with environment variables.

| Environment Variable | Default | Purpose |
| --- | --- | --- |
| `DB_URL` | `jdbc:h2:mem:civicfix_db;DB_CLOSE_DELAY=-1;MODE=MySQL` | JDBC connection URL. |
| `DB_USER` | `sa` | Database username. |
| `DB_PASSWORD` | empty | Database password. |
| `DB_DRIVER` | `org.h2.Driver` | JDBC driver class. |
| `DB_DIALECT` | `org.hibernate.dialect.H2Dialect` | Hibernate dialect. |

For MySQL:

```bash
DB_URL=jdbc:mysql://localhost:3309/civicfix_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
DB_USER=root
DB_PASSWORD=password
DB_DRIVER=com.mysql.cj.jdbc.Driver
DB_DIALECT=org.hibernate.dialect.MySQL8Dialect
```

## Run Locally

### Option 1: Docker Compose

```bash
docker compose up --build
```

Open:

```text
http://localhost:8090
```

Docker Compose starts:

- `db`: MySQL 8.0 with `schema.sql` mounted as initialization script.
- `app`: Tomcat-hosted CivicFix+ application.

### Option 2: Maven Jetty

```bash
mvn jetty:run -Djetty.http.port=8888 -Djetty.tempDirectory=target/tmp-local
```

Open:

```text
http://localhost:8888
```

### Option 3: Tomcat WAR Deployment

```bash
mvn clean package
```

Deploy `target/civicfix.war` to Tomcat 9.

## Demo Accounts

When using the MySQL seed data from `schema.sql`, these accounts are available:

| Role | Username | Password |
| --- | --- | --- |
| Citizen | `rajesh_kumar` | `admin123` |
| Worker | `worker_ravi` | `admin123` |
| Official | `official_sharma` | `admin123` |

## Testing

Run the automated tests:

```bash
mvn test
```

Current test coverage includes:

- `ComplaintClassifierServiceTest`
- `KarmaEngineServiceTest`
- `PublicControllerIntegrationTest`

Latest local verification: `mvn test` completed successfully with **10 tests, 0 failures, 0 errors**.

## Screenshots

Real website screenshots should be captured from the running application and saved into `screenshots/` using the filenames below. Generated placeholder images have intentionally been removed.

## Screenshots Required

| Screenshot File | Page to Capture | Why It Matters |
| --- | --- | --- |
| `screenshots/home-page.png` | `/` | Shows project branding and public entry point. |
| `screenshots/login-page.png` | `/login` | Demonstrates authentication workflow. |
| `screenshots/register-page.png` | `/register` | Shows role-based onboarding. |
| `screenshots/citizen-dashboard.png` | `/citizen/dashboard` | Highlights complaint tracking, notifications, evidence links, and karma. |
| `screenshots/complaint-form.png` | `/citizen/complaint/new` | Captures AI classification, duplicate checking, GPS, and evidence upload. |
| `screenshots/karma-ledger.png` | `/citizen/karma-history` | Shows the auditable reward transaction history. |
| `screenshots/resolution-verification.png` | `/citizen/complaint/{id}/verify` | Shows citizen acceptance/rejection of worker proof. |
| `screenshots/official-command-center.png` | `/official/dashboard` | Shows assignment workflow, search, priority score, workers, and CSV export. |
| `screenshots/official-audit.png` | `/official/audit` | Shows city performance metrics and ward health charts. |
| `screenshots/worker-dashboard.png` | `/worker/dashboard` | Shows field worker metrics and alerts. |
| `screenshots/worker-schedule-map.png` | `/worker/schedule` | Shows field task map and resolution proof upload. |
| `screenshots/worker-history.png` | `/worker/history` | Shows completed task history. |
| `screenshots/transparency-portal.png` | `/transparency` | Demonstrates public analytics and Chart.js reporting. |
| `screenshots/leaderboard.png` | `/leaderboard` | Shows ward health scores and community karma leaderboard. |
| `screenshots/ward-detail.png` | `/ward/{id}` | Shows ward-level performance and recent complaint activity. |
| `screenshots/predictive-heatmap.png` | `/official/heatmap` | Highlights predictive maintenance and ward risk visualization. |
| `screenshots/karma-marketplace.png` | `/citizen/perks` | Shows reward redemption tied to backend karma balance. |
| `screenshots/whistleblower-mode.png` | `/whistleblower` | Shows secure anonymous report workflow. |

## Screenshot Folder Structure

```text
screenshots/
`-- README.md
```

## Future Improvements

- Replace SHA-256 demo password hashing with BCrypt or Argon2.
- Externalize the AES encryption key through `AES_KEY` instead of a hardcoded utility key.
- Add Bean Validation annotations and structured validation error handling.
- Add CSRF protection for state-changing POST requests.
- Implement admin dashboard routes or remove the seeded admin redirect path.
- Persist notification read state from the UI.
- Add pagination for large complaint lists.
- Move uploaded files to cloud object storage such as S3, Cloudinary, or Firebase Storage.
- Add REST API endpoints for mobile clients.
- Add end-to-end tests for login, complaint submission, assignment, resolution, and verification.
- Add GitHub Actions for Maven test/build verification.

## Learning Outcomes

This project demonstrates:

- Designing a Java MVC application with Spring MVC and JSP.
- Implementing DAO and service layers around Hibernate ORM.
- Mapping relational data with JPA entities and MySQL foreign keys.
- Building role-specific workflows with session-based authentication.
- Handling multipart uploads and authenticated file serving.
- Creating business logic services for classification, duplicate detection, scheduling, and rewards.
- Using Hibernate Criteria API for dynamic search/filtering.
- Packaging a Java web application as a WAR.
- Containerizing a Tomcat/MySQL application with Docker Compose.
- Writing focused unit and integration tests with JUnit and Mockito.

## Portfolio Positioning

| Item | Recommendation |
| --- | --- |
| Better subtitle | Smart Civic Issue Resolution Platform for Transparent Municipal Operations |
| Repository description | Java Spring MVC web app for citizen complaints, worker assignment, public transparency, Hibernate/MySQL persistence, and JSP dashboards. |
| Resume bullet | Built a role-based civic issue management system using Java 21, Spring MVC, Hibernate, JSP, MySQL, Docker, and Maven with complaint lifecycle tracking, assignment workflows, file uploads, and analytics dashboards. |

## Contributing

Contributions are welcome for bug fixes, tests, UI polish, documentation, and new civic workflow modules.

```bash
git checkout -b feature/your-feature
mvn test
git commit -m "Add your feature"
git push origin feature/your-feature
```

Open a pull request with:

- Clear summary of the change.
- Screenshots for UI changes.
- Test results or explanation if tests were not applicable.

## License

This repository does not currently include a license file. For a public portfolio or open-source release, add a `LICENSE` file. MIT is a good default for this type of educational portfolio project.
