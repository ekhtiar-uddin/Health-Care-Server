--
-- PostgreSQL database dump
--

\restrict J0ZabmFnsPrijf4lrv8YNtFeJVSbYwCGnhegp661074v55HAL652doFuTD1hfHg

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: AppointmentStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."AppointmentStatus" AS ENUM (
    'SCHEDULED',
    'INPROGRESS',
    'COMPLETED',
    'CANCELED'
);


ALTER TYPE public."AppointmentStatus" OWNER TO postgres;

--
-- Name: BloodGroup; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."BloodGroup" AS ENUM (
    'A_POSITIVE',
    'B_POSITIVE',
    'O_POSITIVE',
    'AB_POSITIVE',
    'A_NEGATIVE',
    'B_NEGATIVE',
    'O_NEGATIVE',
    'AB_NEGATIVE'
);


ALTER TYPE public."BloodGroup" OWNER TO postgres;

--
-- Name: Gender; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


ALTER TYPE public."Gender" OWNER TO postgres;

--
-- Name: MaritalStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."MaritalStatus" AS ENUM (
    'MARRIED',
    'UNMARRIED'
);


ALTER TYPE public."MaritalStatus" OWNER TO postgres;

--
-- Name: PaymentStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PaymentStatus" AS ENUM (
    'PAID',
    'UNPAID'
);


ALTER TYPE public."PaymentStatus" OWNER TO postgres;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."UserRole" AS ENUM (
    'PATIENT',
    'DOCTOR',
    'ADMIN',
    'SUPER_ADMIN'
);


ALTER TYPE public."UserRole" OWNER TO postgres;

--
-- Name: UserStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."UserStatus" AS ENUM (
    'ACTIVE',
    'BLOCKED',
    'DELETED'
);


ALTER TYPE public."UserStatus" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "profilePhoto" text,
    "contactNumber" text NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "scheduleId" text NOT NULL,
    "videoCallingId" text NOT NULL,
    status public."AppointmentStatus" DEFAULT 'SCHEDULED'::public."AppointmentStatus" NOT NULL,
    "paymentStatus" public."PaymentStatus" DEFAULT 'UNPAID'::public."PaymentStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: doctor_schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor_schedules (
    "doctorId" text NOT NULL,
    "scheduleId" text NOT NULL,
    "isBooked" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.doctor_schedules OWNER TO postgres;

--
-- Name: doctor_specialties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor_specialties (
    "specialitiesId" text NOT NULL,
    "doctorId" text NOT NULL
);


ALTER TABLE public.doctor_specialties OWNER TO postgres;

--
-- Name: doctors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctors (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "profilePhoto" text,
    "contactNumber" text NOT NULL,
    address text,
    "registrationNumber" text NOT NULL,
    experience integer DEFAULT 0 NOT NULL,
    gender public."Gender" NOT NULL,
    "appointmentFee" integer NOT NULL,
    qualification text NOT NULL,
    "currentWorkingPlace" text NOT NULL,
    designation text NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "averageRating" double precision DEFAULT 0.0 NOT NULL
);


ALTER TABLE public.doctors OWNER TO postgres;

--
-- Name: madical_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.madical_reports (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "reportName" text NOT NULL,
    "reportLink" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.madical_reports OWNER TO postgres;

--
-- Name: patient_health_datas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_health_datas (
    id text NOT NULL,
    "patientId" text NOT NULL,
    gender public."Gender" NOT NULL,
    "dateOfBirth" text NOT NULL,
    "bloodGroup" public."BloodGroup" NOT NULL,
    "hasAllergies" boolean DEFAULT false,
    "hasDiabetes" boolean DEFAULT false,
    height text NOT NULL,
    weight text NOT NULL,
    "smokingStatus" boolean DEFAULT false,
    "dietaryPreferences" text,
    "pregnancyStatus" boolean DEFAULT false,
    "mentalHealthHistory" text,
    "immunizationStatus" text,
    "hasPastSurgeries" boolean DEFAULT false,
    "recentAnxiety" boolean DEFAULT false,
    "recentDepression" boolean DEFAULT false,
    "maritalStatus" public."MaritalStatus" DEFAULT 'UNMARRIED'::public."MaritalStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.patient_health_datas OWNER TO postgres;

--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "profilePhoto" text,
    address text,
    "isDeleted" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "contactNumber" text
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id text NOT NULL,
    "appointmentId" text NOT NULL,
    amount double precision NOT NULL,
    "transactionId" text NOT NULL,
    status public."PaymentStatus" DEFAULT 'UNPAID'::public."PaymentStatus" NOT NULL,
    "paymentGatewayData" jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptions (
    id text NOT NULL,
    "appointmentId" text NOT NULL,
    "doctorId" text NOT NULL,
    "patientId" text NOT NULL,
    instructions text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "followUpDate" timestamp(3) without time zone
);


ALTER TABLE public.prescriptions OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "appointmentId" text NOT NULL,
    rating integer NOT NULL,
    comment text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    id text NOT NULL,
    "startDateTime" timestamp(3) without time zone NOT NULL,
    "endDateTime" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: specialties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialties (
    id text NOT NULL,
    title text NOT NULL,
    icon text NOT NULL
);


ALTER TABLE public.specialties OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role public."UserRole" NOT NULL,
    "needPasswordChange" boolean DEFAULT true NOT NULL,
    status public."UserStatus" DEFAULT 'ACTIVE'::public."UserStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
230bd031-5ef2-4ed4-9f79-f1cc0fdd1964	89927f963bd25903dd135fc46ce5716fb4d07df9ee479db45ea57432970b0f66	2026-05-31 18:08:18.840447+06	20260531120818_appointment	\N	\N	2026-05-31 18:08:18.718018+06	1
2694b872-4252-4166-a342-4595f314fab9	6bf1e3a05d116a596edbf3e758ed4c7ed08b33929274f363ca961975093101ea	2026-05-22 16:32:50.988332+06	20260414201122_users	\N	\N	2026-05-22 16:32:50.928559+06	1
38301635-c811-44ef-844a-23c15ebda7ea	0f4e0b208dcf1a08577ba198cd6b4c503af97fbd7ab844a90b88007ae8d503dc	2026-05-22 16:32:51.003335+06	20260502071420_schedule	\N	\N	2026-05-22 16:32:50.990046+06	1
2079e2e5-0cd7-4a34-a803-68c129400457	d4799a3cf1d966b6b2adb9f88f733d154d7262297ae2f76b25a5915ae5f63bfa	2026-05-22 16:32:51.017551+06	20260503074948_specilities	\N	\N	2026-05-22 16:32:51.004037+06	1
5386803b-6452-4032-9235-04236942958d	6f4ab3255f9cb4a853dbd17dff46d7ca2ecbf98abcdc93c10a09562553595c27	2026-06-01 00:07:03.074589+06	20260531180703_other_gender_test	\N	\N	2026-06-01 00:07:03.047461+06	1
e953cb12-460d-4c27-925a-edbf3a456352	a3b5cd4d1cf0736525ad5a59e632b1fcc4c0552ff895bb6fe2f2381989bcc2a0	2026-05-22 16:32:51.050817+06	20260503181922_appoinment_payment_prescription	\N	\N	2026-05-22 16:32:51.018117+06	1
0940c3f7-24a5-4471-a15b-c83ae50de328	96c67464d7c24cd9491d3999eb39c81780a05d70b4c7b11b466f41f7e51c8cb1	2026-05-22 16:32:51.053525+06	20260503184837_set_default_value	\N	\N	2026-05-22 16:32:51.051338+06	1
a95c9935-5c30-4478-8452-02542b869305	83a7bc0a3c411f2f03c38d436e08c37b7c8fb15480e7b3a703dc3806badaf79c	2026-05-22 16:32:51.056451+06	20260503200720	\N	\N	2026-05-22 16:32:51.054231+06	1
d8437cc7-a537-4034-9c55-11c4793039c7	fefbedd7ed2718262874004d0a177264abdbe491c125f1199008efacec5c48a2	2026-05-22 16:32:51.059056+06	20260504133602_prescription_follow_update	\N	\N	2026-05-22 16:32:51.057014+06	1
8c15a16d-b812-4e4a-bbc5-c422a315e3dd	5079ce478695ce3805f5f3f20fb24ac258f4b21fcb0d2d10db02b0fa6d7313b3	2026-05-22 16:32:51.089351+06	20260504160550_review	\N	\N	2026-05-22 16:32:51.05963+06	1
c6f6709f-f810-4b5b-a773-23b38e4db112	cc6aa595b1fde2f08ea1646575f0bb9a677afaeb0e640f80d9a0499a53cbf9fa	2026-05-22 16:32:51.099743+06	20260504161226_float_rating_review	\N	\N	2026-05-22 16:32:51.089963+06	1
61c1331b-6a51-44b6-8942-a3fd0ce28dc8	f2d32c217a6fbeb75bdef5811d61c5ced2e1545e3de13dfbd9ac1b94aba1a279	2026-05-22 16:32:51.109993+06	20260504161805_made_int	\N	\N	2026-05-22 16:32:51.100234+06	1
743d30c8-9449-4a35-838d-c757d2aab8e3	811384e13e44828489c269d061cd19344beb2b48feac65cc40574c593fbf94b9	2026-05-22 16:32:51.112441+06	20260506170138_super_admin	\N	\N	2026-05-22 16:32:51.110645+06	1
c2d55d7b-3f9c-4edd-bfd2-9dbc753c4f0c	05ffd3d6ff05be70b470adc2870fa8e4afde695e8fa5496e6ba34858205d7692	2026-05-22 16:32:51.12542+06	20260518082745_user_doctor_update	\N	\N	2026-05-22 16:32:51.113459+06	1
63a759c4-3360-4a2e-a03a-f4e5a0232a99	197430346aa3018a4381898aae3dd123aa471e646597c638e4dd5a8b6dfbb244	2026-05-22 16:32:51.130277+06	20260522102635_user_prisma	\N	\N	2026-05-22 16:32:51.125997+06	1
\.


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, name, email, "profilePhoto", "contactNumber", "isDeleted", "createdAt", "updatedAt") FROM stdin;
68884e2d-1ee9-49cd-8987-df541b88b3b1	Souvik	admin.souvik@gmail.com	\N	01934567890	f	2026-05-30 10:16:27.39	2026-05-30 10:16:27.39
f85b253c-3eb6-43b6-8960-3274e03ab37d	Admin updated	admin1@gmail.com	https://res.cloudinary.com/dofbykuhh/image/upload/v1780156738/file-1780156740405-806361605.webp	+8801690183968	f	2026-05-30 15:59:03.299	2026-05-30 16:04:16.432
\.


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, "patientId", "doctorId", "scheduleId", "videoCallingId", status, "paymentStatus", "createdAt", "updatedAt") FROM stdin;
c374b05a-e9ae-4d52-9ada-551690560f6e	4f0090f2-62d0-4a77-979c-a07c58af0081	b9162985-5a28-44b2-928f-e0a3dfeb1ae3	a503624c-bcb5-49a8-8644-30861fd61ea8	40a9d488-9f11-4f1d-993f-95923f2027e4	CANCELED	UNPAID	2026-05-31 13:14:19.877	2026-05-31 19:24:00.051
978bc254-2d5d-4682-9f2b-863cb545c26e	4f0090f2-62d0-4a77-979c-a07c58af0081	b9162985-5a28-44b2-928f-e0a3dfeb1ae3	a1e6644b-7ec2-4f2d-a8ae-9c9cd70abf9a	8d4768fd-428f-4f20-8541-4c0dbf10c988	CANCELED	UNPAID	2026-05-31 13:14:47.693	2026-05-31 19:24:00.051
c866b6ee-0271-4501-bd4e-51ade27be770	8b1b78f4-e3c7-4e40-89fa-047339b71207	b9162985-5a28-44b2-928f-e0a3dfeb1ae3	8fd758ee-d834-4fa5-bc25-6b1ef8fdfb5a	9f482f1e-8261-4d69-99bc-81e760f60414	CANCELED	UNPAID	2026-05-31 15:21:43.265	2026-05-31 19:24:00.051
\.


--
-- Data for Name: doctor_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor_schedules ("doctorId", "scheduleId", "isBooked", "createdAt", "updatedAt") FROM stdin;
b9162985-5a28-44b2-928f-e0a3dfeb1ae3	a503624c-bcb5-49a8-8644-30861fd61ea8	f	2026-05-31 11:27:17.629	2026-05-31 19:24:00.056
b9162985-5a28-44b2-928f-e0a3dfeb1ae3	a1e6644b-7ec2-4f2d-a8ae-9c9cd70abf9a	f	2026-05-31 11:29:02.13	2026-05-31 19:24:00.058
b9162985-5a28-44b2-928f-e0a3dfeb1ae3	8fd758ee-d834-4fa5-bc25-6b1ef8fdfb5a	f	2026-05-31 11:27:23.198	2026-05-31 19:24:00.058
\.


--
-- Data for Name: doctor_specialties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor_specialties ("specialitiesId", "doctorId") FROM stdin;
\.


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctors (id, name, email, "profilePhoto", "contactNumber", address, "registrationNumber", experience, gender, "appointmentFee", qualification, "currentWorkingPlace", designation, "isDeleted", "createdAt", "updatedAt", "averageRating") FROM stdin;
b9162985-5a28-44b2-928f-e0a3dfeb1ae3	Reuben Combs	doctor1@gmail.com	https://res.cloudinary.com/dofbykuhh/image/upload/v1780160203/file-1780160205933-448025873.webp	17032423423	Ex natus consequatur	801	1984	FEMALE	25	Dolore dolores fugia	Consequatur Excepte	Ea velit necessitati	f	2026-05-30 16:56:48.462	2026-05-30 16:56:48.462	0
\.


--
-- Data for Name: madical_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.madical_reports (id, "patientId", "reportName", "reportLink", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: patient_health_datas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient_health_datas (id, "patientId", gender, "dateOfBirth", "bloodGroup", "hasAllergies", "hasDiabetes", height, weight, "smokingStatus", "dietaryPreferences", "pregnancyStatus", "mentalHealthHistory", "immunizationStatus", "hasPastSurgeries", "recentAnxiety", "recentDepression", "maritalStatus", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (id, name, email, "profilePhoto", address, "isDeleted", "createdAt", "updatedAt", "contactNumber") FROM stdin;
4f0090f2-62d0-4a77-979c-a07c58af0081	Quyn Brooks	patient1@gmail.com	\N	Cupiditate minim exe	f	2026-05-31 11:39:02.811	2026-05-31 11:39:02.811	\N
8b1b78f4-e3c7-4e40-89fa-047339b71207	Louis Newton	patient2@gmail.com	\N	Ea veniam fugiat de	f	2026-05-31 15:21:01.98	2026-05-31 15:21:01.98	\N
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, "appointmentId", amount, "transactionId", status, "paymentGatewayData", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptions (id, "appointmentId", "doctorId", "patientId", instructions, "createdAt", "updatedAt", "followUpDate") FROM stdin;
2beeb207-91ae-4eac-89e6-1a670c239eab	c866b6ee-0271-4501-bd4e-51ade27be770	b9162985-5a28-44b2-928f-e0a3dfeb1ae3	8b1b78f4-e3c7-4e40-89fa-047339b71207	Officiis dolor paria sdfsdfsfd	2026-05-31 15:23:42.417	2026-05-31 15:23:42.417	2004-12-11 10:35:00
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, "patientId", "doctorId", "appointmentId", rating, comment, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (id, "startDateTime", "endDateTime", "createdAt", "updatedAt") FROM stdin;
a1e6644b-7ec2-4f2d-a8ae-9c9cd70abf9a	2026-05-31 10:30:00	2026-05-31 11:00:00	2026-05-31 10:29:13.064	2026-05-31 10:29:13.064
8fd758ee-d834-4fa5-bc25-6b1ef8fdfb5a	2026-05-31 11:00:00	2026-05-31 11:30:00	2026-05-31 10:29:13.08	2026-05-31 10:29:13.08
a503624c-bcb5-49a8-8644-30861fd61ea8	2026-05-31 11:30:00	2026-05-31 12:00:00	2026-05-31 10:29:13.082	2026-05-31 10:29:13.082
13d43fb1-8658-4919-a36a-ae16c9b1fef4	2026-06-01 10:30:00	2026-06-01 11:00:00	2026-05-31 10:29:13.084	2026-05-31 10:29:13.084
ea712e7a-b6a8-41b1-8f5d-192a265699d5	2026-06-01 11:00:00	2026-06-01 11:30:00	2026-05-31 10:29:13.086	2026-05-31 10:29:13.086
f899797e-218c-4c8f-88e5-0a89495a8a74	2026-06-01 11:30:00	2026-06-01 12:00:00	2026-05-31 10:29:13.088	2026-05-31 10:29:13.088
\.


--
-- Data for Name: specialties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialties (id, title, icon) FROM stdin;
62aae1d8-01e9-40f7-8528-803e9084a1d2	Cardiology	https://res.cloudinary.com/dofbykuhh/image/upload/v1780160102/file-1780160104773-352093541.png
befaa61a-6605-4a20-b0f5-201e7330252c	Sergery	https://res.cloudinary.com/dofbykuhh/image/upload/v1780160126/file-1780160128635-302684594.png
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, role, "needPasswordChange", status, "createdAt", "updatedAt") FROM stdin;
2604ea49-6a40-4465-a099-b533974032b9	admin.souvik@gmail.com	$2b$10$CSnET0qndZPb1R8J39I61u46jhEL7lx/HEhQ84apt1SXuIhJqImVG	ADMIN	f	ACTIVE	2026-05-30 10:16:27.373	2026-05-30 11:28:20.7
3c476742-ae57-40cd-a49f-f4a57faec7f0	admin1@gmail.com	$2b$10$hoi.JUzt6ySwPrWcvhkbDO8iUuyLN4O5prOCapZrhpmGpRPEcHZCi	ADMIN	f	ACTIVE	2026-05-30 15:59:03.279	2026-05-30 16:01:18.473
7353f5c6-0ccc-48a7-988b-15b846f01feb	doctor1@gmail.com	$2b$10$C3X2fzQeEjYEFRWC3pT.sOHuFoQNWa6YUsPCxbIMZt5oYLWEP0Tjq	DOCTOR	f	ACTIVE	2026-05-30 16:56:48.452	2026-05-31 10:41:44.937
b1ff7939-0530-4a39-9c90-2c902777c004	patient1@gmail.com	$2b$10$l.hN7r0sLFhjBCUiy9hOa.0db2KemQbKUGqUKW.Uv3YDmXJSj53zK	PATIENT	f	ACTIVE	2026-05-31 11:39:02.8	2026-05-31 11:39:02.8
2cbf07bc-5be6-4df0-b151-ab7853462cf7	patient2@gmail.com	$2b$10$2t.rwU1Vag4PLJB9TPVvbuIbFUIQfuddgaUsc1QyIpOi7a8V6o8fu	PATIENT	f	ACTIVE	2026-05-31 15:21:01.974	2026-05-31 15:21:01.974
\.


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: doctor_schedules doctor_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedules
    ADD CONSTRAINT doctor_schedules_pkey PRIMARY KEY ("doctorId", "scheduleId");


--
-- Name: doctor_specialties doctor_specialties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_specialties
    ADD CONSTRAINT doctor_specialties_pkey PRIMARY KEY ("specialitiesId", "doctorId");


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);


--
-- Name: madical_reports madical_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.madical_reports
    ADD CONSTRAINT madical_reports_pkey PRIMARY KEY (id);


--
-- Name: patient_health_datas patient_health_datas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_health_datas
    ADD CONSTRAINT patient_health_datas_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: specialties specialties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: admins_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX admins_email_key ON public.admins USING btree (email);


--
-- Name: doctors_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX doctors_email_key ON public.doctors USING btree (email);


--
-- Name: patient_health_datas_patientId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "patient_health_datas_patientId_key" ON public.patient_health_datas USING btree ("patientId");


--
-- Name: patients_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX patients_email_key ON public.patients USING btree (email);


--
-- Name: patients_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX patients_id_key ON public.patients USING btree (id);


--
-- Name: payments_appointmentId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "payments_appointmentId_key" ON public.payments USING btree ("appointmentId");


--
-- Name: payments_transactionId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "payments_transactionId_key" ON public.payments USING btree ("transactionId");


--
-- Name: prescriptions_appointmentId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "prescriptions_appointmentId_key" ON public.prescriptions USING btree ("appointmentId");


--
-- Name: reviews_appointmentId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "reviews_appointmentId_key" ON public.reviews USING btree ("appointmentId");


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: admins admins_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: appointments appointments_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "appointments_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.doctors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: appointments appointments_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "appointments_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patients(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: appointments appointments_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "appointments_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public.schedules(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: doctor_schedules doctor_schedules_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedules
    ADD CONSTRAINT "doctor_schedules_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.doctors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: doctor_schedules doctor_schedules_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedules
    ADD CONSTRAINT "doctor_schedules_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public.schedules(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: doctor_specialties doctor_specialties_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_specialties
    ADD CONSTRAINT "doctor_specialties_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.doctors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: doctor_specialties doctor_specialties_specialitiesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_specialties
    ADD CONSTRAINT "doctor_specialties_specialitiesId_fkey" FOREIGN KEY ("specialitiesId") REFERENCES public.specialties(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: doctors doctors_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: madical_reports madical_reports_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.madical_reports
    ADD CONSTRAINT "madical_reports_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patients(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: patient_health_datas patient_health_datas_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_health_datas
    ADD CONSTRAINT "patient_health_datas_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patients(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: patients patients_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: payments payments_appointmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT "payments_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES public.appointments(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: prescriptions prescriptions_appointmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT "prescriptions_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES public.appointments(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: prescriptions prescriptions_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT "prescriptions_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.doctors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: prescriptions prescriptions_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT "prescriptions_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patients(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reviews reviews_appointmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "reviews_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES public.appointments(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reviews reviews_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "reviews_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.doctors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reviews reviews_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "reviews_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patients(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict J0ZabmFnsPrijf4lrv8YNtFeJVSbYwCGnhegp661074v55HAL652doFuTD1hfHg

