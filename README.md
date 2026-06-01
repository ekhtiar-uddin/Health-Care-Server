# Reach Doc Server

Reach Doc Server is a production-ready backend for a telemedicine platform. It powers user onboarding, doctor discovery, scheduling, appointments, payments, prescriptions, and reviews with a secure, role-based API.

## Highlights

- Role-based authentication for Super Admin, Admin, Doctor, and Patient
- Appointment lifecycle with payment flow (Stripe) and automated cleanup
- Doctor scheduling, specialties, and discovery (including AI suggestions)
- Patient health data, prescriptions, and reviews
- File uploads with Cloudinary integration
- Prisma + PostgreSQL with structured migrations

## Tech Stack

- Runtime: Node.js + TypeScript
- Framework: Express
- Database: PostgreSQL + Prisma ORM
- Auth: JWT (cookie-based access token)
- Payments: Stripe
- AI: OpenRouter (OpenAI-compatible)
- Uploads: Multer + Cloudinary

## API Base URL

```
/api/v1
```

## Core Modules

- Auth: /auth
- Users: /user
- Admins: /admin
- Doctors: /doctor
- Patients: /patient
- Schedules: /schedule
- Doctor Schedules: /doctor-schedule
- Specialties: /specialties
- Appointments: /appointment
- Prescriptions: /prescription
- Reviews: /review
- Metadata: /metadata
- Stripe Webhook: /webhook

## Selected Endpoints

Auth

- POST /auth/login
- POST /auth/refresh-token
- POST /auth/change-password
- POST /auth/forgot-password
- POST /auth/reset-password
- GET /auth/me

Users

- GET /user (admin only)
- GET /user/me
- POST /user/create-admin
- POST /user/create-doctor
- POST /user/create-patient
- PATCH /user/:id/status
- PATCH /user/update-my-profile

Doctors

- POST /doctor/suggestion
- GET /doctor
- GET /doctor/:id
- PATCH /doctor/:id
- DELETE /doctor/:id
- DELETE /doctor/soft/:id

Patients

- GET /patient
- GET /patient/:id
- PATCH /patient
- DELETE /patient/soft/:id

Schedules

- GET /schedule
- GET /schedule/:id
- POST /schedule
- DELETE /schedule/:id

Doctor Schedules

- GET /doctor-schedule
- POST /doctor-schedule
- GET /doctor-schedule/my-schedule
- DELETE /doctor-schedule/:id

Specialties

- GET /specialties
- POST /specialties
- DELETE /specialties/:id

Appointments

- GET /appointment
- GET /appointment/my-appointment
- POST /appointment
- POST /appointment/pay-later
- POST /appointment/:id/initiate-payment
- PATCH /appointment/status/:id

Prescriptions

- GET /prescription
- GET /prescription/my-prescription
- POST /prescription

Reviews

- GET /review
- POST /review

Metadata

- GET /metadata

## Environment Variables

Create a `.env` file at the project root. The following variables are required or recommended:

```
NODE_ENV=development
PORT=5000
DATABASE_URL=postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=public

JWT_SECRET=your_jwt_secret
EXPIRES_IN=1d
REFRESH_TOKEN_SECRET=your_refresh_secret
REFRESH_TOKEN_EXPIRES_IN=7d
RESET_PASS_TOKEN=your_reset_token_secret
RESET_PASS_TOKEN_EXPIRES_IN=15m
RESET_PASS_LINK=https://your-frontend/reset-password

STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

OPENROUTER_API_KEY=your_openrouter_key

EMAIL=your_email@example.com
APP_PASS=your_email_app_password

CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_cloud_key
CLOUDINARY_API_SECRET=your_cloud_secret

SALT_ROUND=10
```

## Getting Started

1. Install dependencies

```
npm install
```

2. Generate Prisma client

```
npx prisma generate --schema=./prisma/schema
```

3. Run database migrations

```
npx prisma migrate dev
```

4. Start the API

```
npm run dev
```

The server starts on the configured port and exposes a health response at:

```
GET /
```

## Stripe Webhook (Local)

If you use Stripe CLI:

```
stripe listen --forward-to localhost:5000/webhook
```

## Background Jobs

A cron job runs every minute to cancel unpaid appointments.

## Project Structure

```
src/
  app.ts            # Express app and routes
  server.ts         # Server bootstrap
  app/
    modules/        # Domain modules (auth, user, doctor, appointment, etc.)
    middlewares/    # Auth, rate limiting, validation, error handling
    helper/         # Stripe, file upload, AI clients
    payment/        # Payment webhook handlers
prisma/
  schema/           # Modular Prisma models
  migrations/       # Migration history
```

## Scripts

- npm run dev: Start in development mode
- npm run build: Compile TypeScript to dist/
- npm run start: Run compiled server
- npm run migrate: Prisma migrate dev
- npm run generate: Prisma generate
- npm run reset: Prisma migrate reset
- npm run studio: Prisma Studio

## Deployment Notes

A Render-friendly build script is available at `render-build.sh` and runs:

- npm install
- npm run build
- npx prisma generate
- npx prisma migrate deploy

## Security Notes

- Auth is enforced via JWT stored in HTTP cookies
- Rate limiting is enabled for auth and payment endpoints
- Input validation uses Zod

## License

MIT
