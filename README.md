# Dynamic Personal Portfolio Website


---

## Overview

A fully dynamic personal portfolio website built with **Java Servlets, JSP, JDBC,
and MySQL**. The portfolio displays personal information, skills, projects, and
education — all sourced from a live MySQL database — and includes a protected admin
dashboard for full CRUD management of all content.

The frontend features a clean, minimal design with full **dark/light mode support**,
responsive layout for all screen sizes, and live project search. The backend is built
entirely on the Java EE stack using Jakarta Servlets and JSP with JSTL, deployed on
Apache Tomcat 10.1.

---

## Features

### Public Portfolio
- **Home** — Hero section with tagline, bio preview, and CTA buttons
- **About** — Full biography, profile photo, and stat counters (clients, projects, experience)
- **Skills** — Dynamically rendered from DB, grouped by category with proficiency bars
- **Projects** — Featured project card + full project grid, rendered from DB
- **Education** — Academic qualifications with year range and GPA
- **Contact** — Contact form with client-side and server-side validation, saves to DB

### JavaScript Interactivity
- **Dark / Light theme toggle** — persists preference to localStorage, respects system preference on first visit
- **Live project search** — filters project cards in real time by title or technology
- **Contact form validation** — real-time per-field validation with error messages on blur

### Admin Panel
- **Register / Login / Logout** — full authentication flow with BCrypt password hashing
- **Session protection** — every admin route guarded, unauthenticated users redirected to login
- **Dashboard** — overview stats (project count, skill count, message count, unread count)
- **Projects CRUD** — Add, Edit, Delete projects with featured flag support
- **Skills CRUD** — Add, Edit, Delete skills with category and proficiency level
- **Messages inbox** — view all contact form submissions with read/unread status

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML5, CSS3, Vanilla JavaScript |
| Templating | JSP (Jakarta Server Pages) + JSTL 3.x |
| Backend | Java 17, Jakarta Servlets |
| Database | MySQL 8.x |
| JDBC Driver | MySQL Connector/J 8.3.0 |
| Security | BCrypt (jBCrypt 0.4), HttpSession |
| Build Tool | Apache Maven (WAR packaging) |
| Server | Apache Tomcat 10.1 |
| Fonts | Bricolage Grotesque + DM Sans (Google Fonts) |

---

## Project Structure
```
portfolio/
│
├── .gitignore                            ← Git ignore file
├── .env.example                          ← Environment variables sample configuration
├── pom.xml                               ← Maven build (dependencies, WAR config)
├── portfolio_db.sql                      ← Full DB schema + sample seed data
├── Dockerfile                            ← Docker image configuration
├── docker-compose.yml                    ← Docker Compose configuration
├── README.md                             ← Project documentation
│
└── src/main/
    ├── java/com/portfolio/
    │   │
    │   ├── model/                        ← Plain Java POJOs (Data structures)
    │   │   ├── User.java
    │   │   ├── About.java
    │   │   ├── Skill.java
    │   │   ├── Project.java
    │   │   ├── Education.java
    │   │   └── Message.java
    │   │
    │   ├── dao/                          ← Data Access Objects (DB operations)
    │   │   ├── UserDAO.java
    │   │   ├── AboutDAO.java
    │   │   ├── SkillDAO.java
    │   │   ├── ProjectDAO.java
    │   │   ├── EducationDAO.java
    │   │   └── MessageDAO.java
    │   │
    │   ├── servlet/                      ← Controller layer (Request handling)
    │   │   ├── auth/                     ← Authentication (Login, Register, Logout)
    │   │   │   ├── LoginServlet.java
    │   │   │   ├── RegisterServlet.java
    │   │   │   └── LogoutServlet.java
    │   │   ├── public_/                  ← Publicly accessible pages
    │   │   │   ├── HomeServlet.java
    │   │   │   ├── AboutServlet.java
    │   │   │   ├── SkillsServlet.java
    │   │   │   ├── ProjectsServlet.java
    │   │   │   ├── EducationServlet.java
    │   │   │   └── ContactServlet.java
    │   │   └── admin/                    ← Protected admin dashboard & CRUD
    │   │       ├── AdminBaseServlet.java ← Session guard base class
    │   │       ├── DashboardServlet.java
    │   │       ├── EducationCRUDServlet.java
    │   │       ├── ProjectCRUDServlet.java
    │   │       └── SkillCRUDServlet.java
    │   │
    │   └── util/                         ← Utilities (Connection, Password)
    │       ├── DBConnection.java
    │       └── PasswordUtil.java
    │
    └── webapp/                           ← Web resources (JSP, CSS, JS, Images)
        ├── WEB-INF/
        │   └── web.xml                   ← Servlet and mapping configuration
        ├── assets/
        │   ├── css/
        │   │   ├── style.css             ← Main stylesheet (Public pages)
        │   │   └── admin.css             ← Admin panel styles
        │   ├── js/
        │   │   ├── theme.js              ← Dark/Light mode logic
        │   │   └── validation.js         ← Contact form validation
        │   ├── images/
        │   │   ├── profile.png           ← Main profile picture
        │   │   └── profile.jpg           ← Backup profile picture
        │   └── files/
        │       └── resume.pdf            ← Career resume for download
        ├── pages/                        ← Public JSP views
        │   ├── includes/                 ← Partials (Head, Nav)
        │   │   ├── head.jsp
        │   │   └── nav.jsp
        │   ├── index.jsp                 ← Home page
        │   ├── about.jsp
        │   ├── skills.jsp
        │   ├── projects.jsp
        │   ├── education.jsp
        │   └── contact.jsp
        ├── auth/                         ← Authentication JSP views
        │   ├── login.jsp
        │   └── register.jsp
        └── admin/                        ← Admin Dashboard JSP views
            ├── includes/
            │   └── sidebar.jsp
            ├── education/                ← Education CRUD views
            │   ├── list.jsp
            │   ├── add.jsp
            │   └── edit.jsp
            ├── projects/                 ← Projects CRUD views
            │   ├── list.jsp
            │   ├── add.jsp
            │   └── edit.jsp
            ├── skills/                   ← Skills CRUD views
            │   ├── list.jsp
            │   ├── add.jsp
            │   └── edit.jsp
            └── dashboard.jsp             ← Admin homepage
```
---

## Database Design

**Database name:** `portfolio_db`

### Table: `users`
Stores admin login credentials.

| Column | Type | Constraints |
|---|---|---|
| id | INT | PK, AUTO_INCREMENT |
| username | VARCHAR(50) | NOT NULL, UNIQUE |
| email | VARCHAR(100) | NOT NULL, UNIQUE |
| password_hash | VARCHAR(255) | NOT NULL — BCrypt |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Table: `about`
Stores the portfolio owner's biography and stat counters.

| Column | Type | Constraints |
|---|---|---|
| id | INT | PK, AUTO_INCREMENT |
| user_id | INT | FK → users(id) CASCADE |
| tagline | VARCHAR(150) | NOT NULL |
| bio | TEXT | NOT NULL |
| profile_img | VARCHAR(255) | Path to image |
| clients | INT | Default 0 |
| projects_count | INT | Default 0 |
| years_exp | INT | Default 0 |

### Table: `skills`
One row per skill, grouped by category.

| Column | Type | Constraints |
|---|---|---|
| id | INT | PK, AUTO_INCREMENT |
| user_id | INT | FK → users(id) CASCADE |
| name | VARCHAR(100) | NOT NULL |
| category | VARCHAR(50) | e.g. Frontend, Backend |
| proficiency_level | TINYINT | 1–100 |

### Table: `projects`
One row per project.

| Column | Type | Constraints |
|---|---|---|
| id | INT | PK, AUTO_INCREMENT |
| user_id | INT | FK → users(id) CASCADE |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | NOT NULL |
| tech_stack | VARCHAR(255) | Comma-separated tags |
| github_url | VARCHAR(255) | Nullable |
| live_url | VARCHAR(255) | Nullable |
| featured | TINYINT(1) | 0 or 1 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Table: `education`
One row per qualification.

| Column | Type | Constraints |
|---|---|---|
| id | INT | PK, AUTO_INCREMENT |
| user_id | INT | FK → users(id) CASCADE |
| institution | VARCHAR(200) | NOT NULL |
| degree | VARCHAR(100) | NOT NULL |
| field | VARCHAR(100) | NOT NULL |
| start_year | YEAR | NOT NULL |
| end_year | YEAR | NULL = ongoing |
| gpa | DECIMAL(3,1) | Nullable |

### Table: `messages`
Stores contact form submissions. No FK — independent of user accounts.

| Column | Type | Constraints |
|---|---|---|
| id | INT | PK, AUTO_INCREMENT |
| name | VARCHAR(100) | NOT NULL |
| email | VARCHAR(100) | NOT NULL |
| message | TEXT | NOT NULL |
| sent_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| is_read | TINYINT(1) | 0 = unread, default 0 |

> **Note:** `about`, `skills`, `projects`, and `education` all use
> `ON DELETE CASCADE` so removing a user account cleans up all related data.

---

## Setup Instructions

### Prerequisites

- **Docker Desktop** or **Docker Engine**
- **Docker Compose**

---

### Step 1 — Prepare the Project

1. Navigate into the project folder:
   ```bash
   cd portfolio-v1
   ```

2. Create a `.env` file from the provided example:
   ```bash
   cp .env.example .env
   ```

3. Open `.env` and set your desired database credentials. For Docker, ensure `DB_HOST` is set to `db`.

   ```env
   DB_HOST=db
   DB_PORT=3306
   DB_NAME=portfolio_db
   DB_USER=root
   DB_PASSWORD='your_password'
   MYSQL_ROOT_PASSWORD='your_password'
   ```

---

### Step 2 — Launch with Docker

Run the following command in the project root:

```bash
docker-compose up --build -d
```

This will:
- Spin up a **MySQL 8.0** container and automatically import `portfolio_db.sql` with sample data.
- Build the **Java WAR** using a Maven multi-stage build.
- Deploy the WAR to a **Tomcat 10.1** container as the **ROOT** application.
- Create a persistent volume for project cover images in `./project-media/uploads`.

---

### Step 3 — Open the Application

Visit the following URL in your browser: [http://localhost:8080/home](http://localhost:8080/home)

---

## Application Layout

> [!NOTE]
> The application is deployed as the **ROOT** context in Docker. All URLs are relative to `http://localhost:8080/`.

### Public Pages

| URL | Page |
|---|---|
| `http://localhost:8080/home` | Home |
| `http://localhost:8080/about` | About |
| `http://localhost:8080/skills` | Skills |
| `http://localhost:8080/projects` | Projects |
| `http://localhost:8080/education` | Education |
| `http://localhost:8080/contact` | Contact |

### Auth Pages

| URL | Page |
|---|---|
| `http://localhost:8080/register` | Create admin account |
| `http://localhost:8080/login` | Admin login |
| `http://localhost:8080/logout` | Logout |

### Admin Pages (login required)

| URL | Page |
|---|---|
| `http://localhost:8080/admin/dashboard` | Dashboard overview |
| `http://localhost:8080/admin/projects` | Manage projects |
| `http://localhost:8080/admin/projects?action=add` | Add project |
| `http://localhost:8080/admin/skills` | Manage skills |
| `http://localhost:8080/admin/skills?action=add` | Add skill |

---

## Creating the Admin Account

The registration page is intentionally accessible without login so the
portfolio owner can create their account on first setup:

1. Go to the registration page ([http://localhost:8080/register](http://localhost:8080/register))
2. Enter a username, email, and password (minimum 8 characters)
3. You will be redirected to the login page on success
4. Sign in — you will land on the admin dashboard

> [!TIP]
> Passwords are stored as **BCrypt hashes** (cost factor 12).
> Plain text passwords are never stored or logged anywhere.

---

## Security Implementation

| Mechanism | Where | Details |
|---|---|---|
| BCrypt password hashing | `PasswordUtil.java` | Cost factor 12, never stores plain text |
| Session authentication | `LoginServlet.java` | Creates `HttpSession` on successful login |
| Session invalidation | `LogoutServlet.java` | Calls `session.invalidate()` + cache-control headers |
| Admin route protection | `AdminBaseServlet.java` | `requireLogin()` called before every admin request |
| Input sanitization | All Servlets | `&`, `<`, `>`, `"` escaped before processing |
| Server-side validation | `ContactServlet.java`, `RegisterServlet.java` | Fields validated independently of JS |
| Client-side validation | `validation.js` | Real-time blur validation + submit guard |
| SQL injection prevention | All DAOs | `PreparedStatement` used exclusively, no string concatenation |
| Output escaping | All JSP pages | `<c:out>` used for all dynamic content output |

---

## Module Completion

| Module | Description | Marks Available | Status |
|---|---|---|---|
| **M1** | 6 responsive public pages with semantic HTML and CSS | 6 | Complete |
| **M2** | Contact form validation + dark/light toggle + project search | 5 | Complete |
| **M3** | MySQL schema — 6 tables with PKs, FKs, sample records | 5 | Complete |
| **M4** | JDBC via `DBConnection.java` + `PreparedStatement` throughout | 3 | Complete |
| **M5** | `RegisterServlet`, `LoginServlet`, `LogoutServlet` + redirect | 4 | Complete |
| **M6** | Full Projects CRUD + full Skills CRUD in admin dashboard | 6 | Complete |
| **M7** | Skills and Projects pages render live data from DB via JSP | 2 | Complete |
| **M8** | Session guard + BCrypt hashing + input validation + escaping | 4 | Complete |
| **Total** | | **35** | ✅ |

---

## Implemented Features Summary

- [x] Home page with dynamic tagline and bio from database
- [x] About page with bio, photo, and stat counters from database
- [x] Skills page — grouped by category, proficiency bars — dynamic from DB
- [x] Projects page — featured card + grid — dynamic from DB
- [x] Education page with year range and GPA display
- [x] Contact form — client-side validation + server-side validation + saves to DB
- [x] Dark / Light mode toggle with localStorage persistence
- [x] Live project search/filter by title or technology
- [x] Admin registration with duplicate username/email check
- [x] Admin login with BCrypt password verification
- [x] Admin logout with session invalidation + cache-control headers
- [x] Admin dashboard with stats and contact message inbox
- [x] Projects CRUD — Add, Edit, Delete, Featured flag
- [x] Project Cover Images — Upload custom images for featured projects (Persists via Docker volume)
- [x] Skills CRUD — Add, Edit, Delete, Category + Proficiency
- [x] Education CRUD — Add, Edit, Delete, Degree + GPA + Dates
- [x] Session guard on all admin routes
- [x] PreparedStatement used for all database queries
- [x] Input sanitization and output escaping throughout
- [x] Fully responsive layout (mobile, tablet, desktop)

---

## Troubleshooting

| Problem | Likely Cause | Fix |
|---|---|---|
| `500` on JSP pages | DB connection failed | Check `.env` credentials and verify `DB_HOST=db` |
| `Docker port conflict` | Port 8080 or 3307 already in use | Stop local processes or change host ports in `docker-compose.yml` |
| `Docker changes not reflecting` | Container using old build | Run `docker-compose up --build -d` |
| `Communications link failure` | MySQL container not ready | Check `docker-compose ps` — `portfolio_db` must be healthy |
| `Access denied for user` | Wrong DB password | Update `.env` and restart containers |
| Admin login not working | BCrypt hash mismatch | Re-register via `/register` to generate a fresh hash |
| Pages show no data | DB empty or wrong user_id | Re-import `portfolio_db.sql` or check Docker volumes |

---

## Author

**Soumasish Dasgupta**
B.Tech Computer Science and Engineering
Techno India University, Kolkata — 2023–2027 (Expected)
GPA: 9.8

- GitHub: [github.com/Soumasish2005](https://github.com/Soumasish2005)
- Email: dasguptasoumasish@gmail.com
- LinkedIn: [linkedin.com/in/soumasish-dasgupta](https://www.linkedin.com/in/soumasish-dasgupta)

---

*Submitted for Web Technology (TIU-UCS-E322) Assignment — Techno India University*

