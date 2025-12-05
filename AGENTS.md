# AGENTS: MusicShop Project

This file defines how AI agents (Codex) should work on this repository.

---

## 1. Project Overview

**Name:** MusicShop  
**Type:** Small e-commerce web app  
**Stack:**
- Frontend: HTML, CSS, JavaScript
- Backend: PHP (procedural style), REST-like APIs in `/api`
- Database: MariaDB/MySQL (schema in `localhost.sql`)
- Hosting path (local dev): `/srv/http/musicshop`

**Key features:**
- User registration & login
- User roles: `user` and `admin`
- Product catalog with categories & filters
- Favorites
- Cart & order placement
- Orders history
- Admin panel: manage products, orders, news

---

## 2. Repository Layout (expected)

- `/index.html` – main entry page
- `/login.html`, `/register.html` – auth UI
- `/products.html` – product listing, filters, add to cart/favorites
- `/favorites.html` – favorites listing
- `/orders.html` – cart + checkout + order history
- `/news.html` – public news
- `/admin.html` – admin panel: products, orders, news
- `/css/style.css` – styling
- `/js/script.js` – shared frontend JS
- `/api/*.php` – backend endpoints
- `/localhost.sql` – DB schema / sample data (DEV only)
- `/start_stack.py`, `/stop_stack.py` – local dev scripts

When creating new files, follow the same structure.

---

## 3. Coding Style & Conventions

### 3.1. General

- Prefer **clear, simple code** over “clever” solutions.
- Keep functions short and focused on a single responsibility.
- Use **English** for code, comments, and messages.
- Add comments where the logic is not obvious.

### 3.2. PHP

- Use `<?php` (no short tags).
- Use **procedural style** for now (no frameworks).
- Use **strict types only if you can apply them consistently**.
- Follow this basic structure in API files:
  1. `session_start();`
  2. `header('Content-Type: application/json');`
  3. include shared files (DB, auth helpers, etc.)
  4. auth checks (`requireLogin()`, `requireAdmin()`)
  5. read+validate input
  6. perform DB operations (prepared statements)
  7. return JSON `{ ok: true/false, data... }`

### 3.3. JavaScript

- Prefer **vanilla JS** (no frameworks).
- Use `const` and `let`, avoid `var`.
- Prefer `textContent` over `innerHTML` unless you **must** use HTML and you **sanitize** it.
- Group reusable helpers in `/js/script.js` or small modules.

### 3.4. HTML/CSS

- HTML should be valid and semantic where possible.
- Keep inline JS minimal; prefer `<script src="js/script.js"></script>`.
- Keep layout changes in CSS instead of inline `style` attributes.

---

## 4. Security Rules (VERY IMPORTANT)

When modifying or adding backend code, **always enforce**:

### 4.1. Authentication & Authorization

- All endpoints under `/api` that deal with user data or changes must:
  - Call `session_start()` at the top.
  - Use helpers:
    - `requireLogin()` – for endpoints that require a logged-in user.
    - `requireAdmin()` – for admin-only endpoints (e.g. `get_all_orders.php`, admin product/news/management).
- Admin-only endpoints **must not** be available to normal users:
  - `get_all_orders.php`
  - admin product endpoints
  - admin news endpoints
  - any future admin tools

### 4.2. SQL Safety

- **No raw SQL with interpolated user input. Ever.**
- Always use prepared statements:
  - `prepare()`, `bind_param()`, `execute()`, `get_result()`.
- Treat **all** external input as tainted:
  - `$_GET`, `$_POST`, `php://input`, `$_SESSION`, cookies.

### 4.3. Session Security

- After a successful login:
  - Call `session_regenerate_id(true)` to prevent session fixation.
- Never store passwords in plain text:
  - Use `password_hash()` when creating users.
  - Use `password_verify()` when logging in.

### 4.4. XSS Protection

- Do **not** inject untrusted strings into HTML via `.innerHTML`.
- Use `.textContent` for plain text.
- If HTML rendering is needed, either:
  - sanitize on write (server side), or
  - properly escape values before inserting into the DOM.
- Be careful with:
  - product names, descriptions
  - news titles and content
  - any content that comes from DB and can be edited by users/admins

### 4.5. CSRF Protection

- State-changing endpoints must use **POST** + anti-CSRF measures.
- Don’t use GET for destructive actions (e.g. delete product, delete news).
- Recommended:
  - Use SameSite cookies (where applicable) **and**
  - Use a CSRF token stored in `$_SESSION` and sent as a header or form field.
  - Verify the CSRF token on every state-changing request.

### 4.6. Secrets & Error Messages

- Do **not** commit real database passwords or secrets into Git.
- `api/db.php` should load credentials from environment or config files that are **gitignored**.
- Do **not** echo raw DB error messages to clients; log them (if needed) and return a generic error:  
  `["ok" => false, "error" => "Internal server error"]`.

### 4.7. “Test” endpoints

- Files like `api/test_db.php` must **not** be exposed in production.
- Either delete them or guard them behind `requireAdmin()` and never return sensitive info.

---

## 5. Roles and Permissions

### 5.1. Roles

- Use a single, consistent role model:
  - DB field: `role` (e.g. `'user'` or `'admin'`).
- On login, set:
  - `$_SESSION['user_id']`
  - `$_SESSION['email']`
  - `$_SESSION['role']`

### 5.2. Helpers

Define reusable helpers (in a shared PHP file, e.g. `_auth.php`):

```php
function requireLogin() {
    if (empty($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(["ok" => false, "error" => "Not logged in"]);
        exit;
    }
}

function requireAdmin() {
    requireLogin();
    if (($_SESSION['role'] ?? null) !== 'admin') {
        http_response_code(403);
        echo json_encode(["ok" => false, "error" => "Admin only"]);
        exit;
    }
}
