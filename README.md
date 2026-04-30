# Fitness Guide and Class Reservation Web App

A Java EE web application for fitness guidance and class booking.  
The app combines public fitness tools (BMI, calorie calculator/tracker, guides) with authenticated booking features for users and admins.

## Overview

This project is built with:

- Java Servlet/JSP (Java 8 style project)
- Apache Ant (NetBeans web project structure)
- GlassFish server (project configured for GlassFish 5 / Java EE 8 Web)
- Apache Derby database (`jdbc:derby://localhost:1527/project`)

Main capabilities:

- User signup and login
- Role-based dashboards (`user`, `admin`)
- Browse and book fitness classes
- Search classes by name, max price, and seat availability
- View purchase history
- Update profile and wallet balance
- Admin class management (add and update classes)

## Project Structure

- `web/`: JSP pages, static HTML/CSS, and DB setup SQL
- `src/java/`: Servlet classes
- `web/WEB-INF/web.xml`: Servlet registration and URL mappings
- `web/sql.txt`: Database schema and seed data
- `build.xml`: Ant build/deploy file

## Prerequisites

Install the following before running:

1. JDK 8 (or compatible with Java EE 8 tooling)
2. Apache NetBeans (recommended, since this is a NetBeans project)
3. GlassFish Server 5.x
4. Apache Derby running in network mode on port `1527`

## Database Setup

1. Start Derby network server.
2. Create database: `project`.
3. Execute SQL from `web/sql.txt` to create tables:
   - `users`
   - `classes`
   - `purchases`
4. Seed initial users/classes using the inserts in `web/sql.txt`.

### Important Notes About `sql.txt`

- The file contains sample seed statements; review them before executing.
- One sample user insert line has a syntax issue due to an extra semicolon before the next row.
- Use Derby SQL syntax when executing timestamps and inserts.

## Configure and Run

### Option A (Recommended): NetBeans + GlassFish

1. Open the project folder in NetBeans.
2. Ensure the project target server is set to GlassFish.
3. Start GlassFish from NetBeans or separately.
4. Build and run the project.
5. Open the app landing page:
   - `http://localhost:8080/Project/`
   - WAR/project name is configured as `Project.war`.

### Option B: Ant Build

From project root:

```bash
ant clean
ant
```

Then deploy the generated WAR from `dist/Project.war` to your servlet container.

## How to Use the Web App

### Public (No Login)

From `index.html`, users can access:

- Fitness guide
- BMI calculator
- Calorie calculator
- Calorie tracker
- FAQs

To use booking and account features, go to `signup.jsp` or `login.jsp`.

### User Flow

1. Register via `signup.jsp` (creates a `user` account).
2. Login via `login.jsp`.
3. Open `UserDashboard.jsp`.
4. Click **Book** to browse classes (`browse_classes`).
5. Choose class and quantity, then confirm booking.
6. After success, check:
   - `history.jsp` for transactions
   - `updateProfile.jsp` to update details or add balance

### Admin Flow

1. Login with an account that has role `admin`.
2. Open `AdminDashboard.jsp`.
3. Admin options:
   - `add.jsp`: create new classes
   - `updateClass.jsp`: update class details
   - Access search/history/profile pages

## Main Routes

### JSP/HTML Pages

- `index.html` - landing page
- `login.jsp` - login
- `signup.jsp` - registration
- `UserDashboard.jsp` - user dashboard
- `AdminDashboard.jsp` - admin dashboard
- `search.jsp` - class search
- `history.jsp` - purchase history
- `updateProfile.jsp` - profile update form
- `purchase.jsp` - booking confirmation
- `purchaseSuccess.jsp` - booking success page

### Servlet Endpoints (from `web.xml`)

- `/SignupServlet`
- `/LoginServlet`
- `/browse_classes`
- `/purchaseServlet`
- `/updateclassservlet`

Note: Current UI pages mostly process login/signup/admin updates directly in JSPs, while browse and purchase features rely on servlet endpoints.

## Default Seed Accounts

Based on `web/sql.txt` sample data:

- User: `ahmad` / `123`
- Admin: `admin` / `123`

If seed data differs in your local DB, use the credentials currently stored in your `users` table.

## Known Limitations

- Passwords are stored in plain text (no hashing) in current implementation.
- Authentication is cookie-based without advanced session security controls.
- Some servlet classes and JSP routes overlap in responsibility (mixed architecture).
- Derby connection settings are hardcoded in multiple JSP/Servlet files.

## Troubleshooting

- **`No suitable driver` / DB errors**: Ensure Derby driver is available to GlassFish and Derby network server is running.
- **Cannot login after signup**: Verify DB contents in `users` table and that cookies are enabled.
- **Blank class list**: Confirm `classes` table has data and DB URL is reachable.
- **404 on pages/endpoints**: Confirm app context path is `Project` and server deploy succeeded.

## Suggested Improvements

- Move all DB and business logic from JSP into servlets/services.
- Add password hashing (e.g., BCrypt) and secure session handling.
- Externalize DB config to environment or server resources.
- Add input validation and centralized error handling.
- Add automated tests for booking flow and profile updates.

