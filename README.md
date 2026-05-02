# Fitness Guide and Class Reservation Web App

A Java EE web application for fitness guidance and class booking.
The app combines public fitness tools (BMI calculator, calorie tracker, fitness guides) with authenticated booking features for users and admins.

---

## Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Database Setup](#database-setup)
- [Configure and Run](#configure-and-run)
- [How to Use the Web App](#how-to-use-the-web-app)
- [Main Routes](#main-routes)
- [Default Seed Accounts](#default-seed-accounts)
- [Known Limitations](#known-limitations)
- [Troubleshooting](#troubleshooting)
- [Suggested Improvements](#suggested-improvements)

---

## Overview

This project is a role-based fitness web application that allows users to browse, search, and book fitness classes, while admins can manage class listings. A set of public tools is available without login.

**Key capabilities:**

- User registration and login
- Role-based dashboards (`user`, `admin`)
- Browse and book fitness classes
- Search classes by name, max price, and seat availability
- View purchase and booking history
- Update profile and wallet balance
- Admin class management (add and update classes)
- Public fitness tools: BMI calculator, calorie calculator, calorie tracker, fitness guide, FAQs

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java Servlets / JSP (Java EE 8) |
| Build Tool | Apache Ant (NetBeans project structure) |
| Server | GlassFish 5.x |
| Database | Apache Derby (`jdbc:derby://localhost:1527/project`) |
| Frontend | JSP, HTML, CSS |

---

## Project Structure

```
project-root/
├── src/java/              # Servlet classes
├── web/
│   ├── *.jsp              # JSP pages (user, admin, booking flows)
│   ├── index.html         # Public landing page
│   ├── sql.txt            # Database schema and seed data
│   └── WEB-INF/
│       └── web.xml        # Servlet registration and URL mappings
└── build.xml              # Ant build and deploy configuration
```

---

## Prerequisites

Install the following before running the project:

1. **JDK 8** — compatible with Java EE 8 tooling
2. **Apache NetBeans** — recommended IDE, as this is a NetBeans project
3. **GlassFish Server 5.x** — the configured target server
4. **Apache Derby** — must be running in network mode on port `1527`

---

## Database Setup

1. Start the Derby network server.
2. Create a database named `project`.
3. Execute the SQL from `web/sql.txt` to create the following tables:

| Table | Purpose |
|---|---|
| `users` | Stores registered user accounts and roles |
| `classes` | Stores available fitness classes |
| `purchases` | Records class booking transactions |

4. Run the insert statements in `web/sql.txt` to seed initial users and classes.

### Notes on `sql.txt`

- Review the file before executing — it contains sample seed data that may need adjustment for your environment.
- One sample user insert contains a syntax issue (an extra semicolon before the next row); fix this before running.
- Use Derby-compatible SQL syntax for timestamps and inserts.

---

## Configure and Run

### Option A (Recommended): NetBeans + GlassFish

1. Open the project folder in Apache NetBeans.
2. Confirm the target server is set to GlassFish 5.
3. Start GlassFish from within NetBeans or separately.
4. Build and run the project from NetBeans.
5. Access the app at:

```
http://localhost:8080/Project/
```

> The WAR is deployed as `Project.war`, so the context path is `/Project`.

### Option B: Ant Build

From the project root, run:

```bash
ant clean
ant
```

Then deploy the generated file at `dist/Project.war` to your servlet container manually.

---

## How to Use the Web App

### Public Access (No Login Required)

From `index.html`, anyone can access:

- Fitness guide
- BMI calculator
- Calorie calculator
- Calorie tracker
- FAQs

To access booking and account features, navigate to `signup.jsp` or `login.jsp`.

---

### User Flow

1. Register at `signup.jsp` — creates an account with the `user` role.
2. Log in at `login.jsp`.
3. You will be directed to `UserDashboard.jsp`.
4. Click **Book** to browse available classes (`/browse_classes`).
5. Select a class and quantity, then confirm the booking.
6. After a successful booking:
   - View transaction history at `history.jsp`
   - Update your profile or add wallet balance at `updateProfile.jsp`

---

### Admin Flow

1. Log in with an account that has the `admin` role.
2. You will be directed to `AdminDashboard.jsp`.
3. Available admin actions:
   - `add.jsp` — create new fitness classes
   - `updateClass.jsp` — edit existing class details
   - Access search, history, and profile pages as normal

---

## Main Routes

### Pages

| Path | Description |
|---|---|
| `index.html` | Public landing page |
| `login.jsp` | Login form |
| `signup.jsp` | Registration form |
| `UserDashboard.jsp` | Authenticated user dashboard |
| `AdminDashboard.jsp` | Admin dashboard |
| `search.jsp` | Class search |
| `history.jsp` | Purchase and booking history |
| `updateProfile.jsp` | Profile and wallet update |
| `purchase.jsp` | Booking confirmation |
| `purchaseSuccess.jsp` | Booking success page |
| `add.jsp` | Admin: add new class |
| `updateClass.jsp` | Admin: edit class |

### Servlet Endpoints

| Endpoint | Purpose |
|---|---|
| `/SignupServlet` | Handles user registration |
| `/LoginServlet` | Handles authentication |
| `/browse_classes` | Returns class listings |
| `/purchaseServlet` | Processes booking transactions |
| `/updateclassservlet` | Handles admin class updates |

> **Note:** Login, signup, and some admin updates are currently handled directly in JSPs. Browse and purchase features route through servlet endpoints.

---

## Default Seed Accounts

The following accounts are included in the sample seed data from `web/sql.txt`:

| Role | Username | Password |
|---|---|---|
| User | `ahmad` | `123` |
| Admin | `admin` | `123` |

> If you have modified the seed data or your local database differs, use the credentials currently stored in your `users` table.

---

## Known Limitations

- **Plain-text passwords** — no hashing or encryption is applied to stored passwords.
- **Basic session handling** — authentication relies on cookies without advanced session security controls.
- **Mixed architecture** — some servlet classes and JSP pages share overlapping responsibilities, making the codebase harder to maintain.
- **Hardcoded database config** — the Derby connection URL and credentials are hardcoded across multiple JSP and Servlet files.

---

## Troubleshooting

| Symptom | Solution |
|---|---|
| `No suitable driver` / DB connection errors | Ensure the Derby JDBC driver is available to GlassFish and the Derby network server is running on port `1527` |
| Cannot log in after signup | Verify the `users` table contains the registered entry and that cookies are enabled in the browser |
| Blank class list | Confirm the `classes` table has data and the DB URL is reachable from the server |
| 404 on pages or endpoints | Verify the app context path is `/Project` and that the deployment completed successfully |

---

## Suggested Improvements

- **Separate concerns** — move all database queries and business logic out of JSPs and into dedicated servlet or service classes.
- **Password security** — implement password hashing (e.g., BCrypt) and use secure, server-side session management.
- **Externalize configuration** — move the database URL and credentials to server resources (JNDI) or environment variables instead of hardcoding them.
- **Input validation** — add server-side validation and centralized error handling across all forms.
- **Automated testing** — write unit and integration tests covering the booking flow, authentication, and profile updates.
- **Upgrade stack** — consider migrating to a modern framework (e.g., Jakarta EE 10, Spring Boot) with a more actively maintained database driver.
