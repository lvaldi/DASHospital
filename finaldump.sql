--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Books" (
    "FID" character(8) NOT NULL,
    "AppointmentID" integer NOT NULL
);


ALTER TABLE public."Books" OWNER TO postgres;

--
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    id integer NOT NULL,
    availableforemergency boolean
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    email character varying(30) NOT NULL,
    name character varying(20) NOT NULL,
    license character(8) NOT NULL,
    phone character(13)
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: a; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.a AS
 SELECT doctor.availableforemergency,
    doctor.id,
    staff.name
   FROM public.doctor,
    public.staff
  WHERE ((doctor.id = staff.id) AND (doctor.availableforemergency = true));


ALTER TABLE public.a OWNER TO postgres;

--
-- Name: ae; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ae AS
 SELECT doctor.availableforemergency,
    doctor.id,
    staff.name
   FROM public.doctor,
    public.staff
  WHERE ((doctor.id = staff.id) AND (doctor.availableforemergency = true));


ALTER TABLE public.ae OWNER TO postgres;

--
-- Name: allavailable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.allavailable AS
 SELECT doctor.id,
    staff.name,
    doctor.availableforemergency,
    staff.email,
    staff.phone
   FROM public.doctor,
    public.staff
  WHERE ((doctor.id = staff.id) AND (doctor.availableforemergency = true));


ALTER TABLE public.allavailable OWNER TO postgres;

--
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    appointmentid integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    pid integer NOT NULL,
    did integer NOT NULL
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- Name: appointment_appointmentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_appointmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment_appointmentid_seq OWNER TO postgres;

--
-- Name: appointment_appointmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_appointmentid_seq OWNED BY public.appointment.appointmentid;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: available; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.available AS
 SELECT doctor.availableforemergency,
    doctor.id,
    staff.name
   FROM public.doctor,
    public.staff
  WHERE ((doctor.id = staff.id) AND (doctor.availableforemergency = true));


ALTER TABLE public.available OWNER TO postgres;

--
-- Name: contains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contains (
    prescriptionid integer NOT NULL,
    din character(8) NOT NULL
);


ALTER TABLE public.contains OWNER TO postgres;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facility (
    id character(8) NOT NULL,
    type character varying(20) NOT NULL
);


ALTER TABLE public.facility OWNER TO postgres;

--
-- Name: generalpracticioner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generalpracticioner (
    id integer NOT NULL
);


ALTER TABLE public.generalpracticioner OWNER TO postgres;

--
-- Name: lab_technician; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_technician (
    id integer NOT NULL,
    fid character(8) NOT NULL
);


ALTER TABLE public.lab_technician OWNER TO postgres;

--
-- Name: medicine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicine (
    din character(8) NOT NULL,
    brand character varying(20) NOT NULL,
    ingredients character varying(20),
    sideeffect character varying(80)
);


ALTER TABLE public.medicine OWNER TO postgres;

--
-- Name: nurse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nurse (
    id integer NOT NULL,
    did integer NOT NULL
);


ALTER TABLE public.nurse OWNER TO postgres;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    id integer NOT NULL,
    email character(30) NOT NULL,
    name character(20) NOT NULL,
    healthcard character varying(20) NOT NULL,
    phone character(13)
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- Name: patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patient_id_seq OWNER TO postgres;

--
-- Name: patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patient_id_seq OWNED BY public.patient.id;


--
-- Name: prescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescription (
    prescriptionid integer NOT NULL,
    instruction character varying(30),
    substitutable boolean
);


ALTER TABLE public.prescription OWNER TO postgres;

--
-- Name: prescription_prescriptionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescription_prescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prescription_prescriptionid_seq OWNER TO postgres;

--
-- Name: prescription_prescriptionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescription_prescriptionid_seq OWNED BY public.prescription.prescriptionid;


--
-- Name: scheduled_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scheduled_time (
    date date NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    wid character(8) NOT NULL,
    notes character varying(60)
);


ALTER TABLE public.scheduled_time OWNER TO postgres;

--
-- Name: specialist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialist (
    id integer NOT NULL,
    specialization character varying(20)
);


ALTER TABLE public.specialist OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: treats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treats (
    did integer NOT NULL,
    pid integer NOT NULL,
    prescriptionid integer NOT NULL
);


ALTER TABLE public.treats OWNER TO postgres;

--
-- Name: weeklyschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weeklyschedule (
    id character(8) NOT NULL,
    sid integer NOT NULL
);


ALTER TABLE public.weeklyschedule OWNER TO postgres;

--
-- Name: appointment appointmentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN appointmentid SET DEFAULT nextval('public.appointment_appointmentid_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: patient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient ALTER COLUMN id SET DEFAULT nextval('public.patient_id_seq'::regclass);


--
-- Name: prescription prescriptionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription ALTER COLUMN prescriptionid SET DEFAULT nextval('public.prescription_prescriptionid_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Data for Name: Books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Books" ("FID", "AppointmentID") FROM stdin;
ECG00001	10000001
MRI00001	10000002
MRI00001	10000003
XRAY0002	10000001
XRAY0001	10000005
\.


--
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment (appointmentid, date, "time", pid, did) FROM stdin;
10000000	2019-01-06	16:00:00	100012	1004
10000001	2019-01-04	10:00:00	100032	1003
10000002	2019-01-02	10:00:00	100011	1009
10000003	2019-01-06	11:00:00	100001	1008
10000004	2019-01-04	17:00:00	100004	1010
10000015	2019-01-03	18:00:00	100002	1013
10000005	2019-01-04	19:00:00	100000	1000
10000006	2018-11-20	12:00:00	100000	1001
10000007	2018-10-24	13:00:00	100001	1002
10000008	2019-01-03	14:00:00	100002	1005
10000009	2019-11-21	15:00:00	100005	1006
10000010	2019-11-08	11:00:00	100006	1007
10000011	2019-04-03	14:00:00	100007	1008
10000012	2019-04-01	18:00:00	100008	1011
10000013	2019-02-01	19:00:00	100009	1012
10000014	2019-03-04	13:00:00	100010	1000
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add appointment	7	add_appointment
26	Can change appointment	7	change_appointment
27	Can delete appointment	7	delete_appointment
28	Can view appointment	7	view_appointment
29	Can add auth group	8	add_authgroup
30	Can change auth group	8	change_authgroup
31	Can delete auth group	8	delete_authgroup
32	Can view auth group	8	view_authgroup
33	Can add auth group permissions	9	add_authgrouppermissions
34	Can change auth group permissions	9	change_authgrouppermissions
35	Can delete auth group permissions	9	delete_authgrouppermissions
36	Can view auth group permissions	9	view_authgrouppermissions
37	Can add auth permission	10	add_authpermission
38	Can change auth permission	10	change_authpermission
39	Can delete auth permission	10	delete_authpermission
40	Can view auth permission	10	view_authpermission
41	Can add auth user	11	add_authuser
42	Can change auth user	11	change_authuser
43	Can delete auth user	11	delete_authuser
44	Can view auth user	11	view_authuser
45	Can add auth user groups	12	add_authusergroups
46	Can change auth user groups	12	change_authusergroups
47	Can delete auth user groups	12	delete_authusergroups
48	Can view auth user groups	12	view_authusergroups
49	Can add auth user user permissions	13	add_authuseruserpermissions
50	Can change auth user user permissions	13	change_authuseruserpermissions
51	Can delete auth user user permissions	13	delete_authuseruserpermissions
52	Can view auth user user permissions	13	view_authuseruserpermissions
53	Can add django admin log	14	add_djangoadminlog
54	Can change django admin log	14	change_djangoadminlog
55	Can delete django admin log	14	delete_djangoadminlog
56	Can view django admin log	14	view_djangoadminlog
57	Can add django content type	15	add_djangocontenttype
58	Can change django content type	15	change_djangocontenttype
59	Can delete django content type	15	delete_djangocontenttype
60	Can view django content type	15	view_djangocontenttype
61	Can add django migrations	16	add_djangomigrations
62	Can change django migrations	16	change_djangomigrations
63	Can delete django migrations	16	delete_djangomigrations
64	Can view django migrations	16	view_djangomigrations
65	Can add django session	17	add_djangosession
66	Can change django session	17	change_djangosession
67	Can delete django session	17	delete_djangosession
68	Can view django session	17	view_djangosession
69	Can add medicine	18	add_medicine
70	Can change medicine	18	change_medicine
71	Can delete medicine	18	delete_medicine
72	Can view medicine	18	view_medicine
73	Can add patient	19	add_patient
74	Can change patient	19	change_patient
75	Can delete patient	19	delete_patient
76	Can view patient	19	view_patient
77	Can add scheduled time	20	add_scheduledtime
78	Can change scheduled time	20	change_scheduledtime
79	Can delete scheduled time	20	delete_scheduledtime
80	Can view scheduled time	20	view_scheduledtime
81	Can add weeklyschedule	21	add_weeklyschedule
82	Can change weeklyschedule	21	change_weeklyschedule
83	Can delete weeklyschedule	21	delete_weeklyschedule
84	Can view weeklyschedule	21	view_weeklyschedule
85	Can add facility	22	add_facility
86	Can change facility	22	change_facility
87	Can delete facility	22	delete_facility
88	Can view facility	22	view_facility
89	Can add books	23	add_books
90	Can change books	23	change_books
91	Can delete books	23	delete_books
92	Can view books	23	view_books
93	Can add contains	24	add_contains
94	Can change contains	24	change_contains
95	Can delete contains	24	delete_contains
96	Can view contains	24	view_contains
97	Can add prescription	25	add_prescription
98	Can change prescription	25	change_prescription
99	Can delete prescription	25	delete_prescription
100	Can view prescription	25	view_prescription
101	Can add staff	26	add_staff
102	Can change staff	26	change_staff
103	Can delete staff	26	delete_staff
104	Can view staff	26	view_staff
105	Can add nurse	27	add_nurse
106	Can change nurse	27	change_nurse
107	Can delete nurse	27	delete_nurse
108	Can view nurse	27	view_nurse
109	Can add doctor	28	add_doctor
110	Can change doctor	28	change_doctor
111	Can delete doctor	28	delete_doctor
112	Can view doctor	28	view_doctor
113	Can add specialist	29	add_specialist
114	Can change specialist	29	change_specialist
115	Can delete specialist	29	delete_specialist
116	Can view specialist	29	view_specialist
117	Can add treats	30	add_treats
118	Can change treats	30	change_treats
119	Can delete treats	30	delete_treats
120	Can view treats	30	view_treats
121	Can add generalpracticioner	31	add_generalpracticioner
122	Can change generalpracticioner	31	change_generalpracticioner
123	Can delete generalpracticioner	31	delete_generalpracticioner
124	Can view generalpracticioner	31	view_generalpracticioner
125	Can add lab technician	32	add_labtechnician
126	Can change lab technician	32	change_labtechnician
127	Can delete lab technician	32	delete_labtechnician
128	Can view lab technician	32	view_labtechnician
129	Can add patient	33	add_patient
130	Can change patient	33	change_patient
131	Can delete patient	33	delete_patient
132	Can view patient	33	view_patient
133	Can add scheduled time	34	add_scheduledtime
134	Can change scheduled time	34	change_scheduledtime
135	Can delete scheduled time	34	delete_scheduledtime
136	Can view scheduled time	34	view_scheduledtime
137	Can add weeklyschedule	35	add_weeklyschedule
138	Can change weeklyschedule	35	change_weeklyschedule
139	Can delete weeklyschedule	35	delete_weeklyschedule
140	Can view weeklyschedule	35	view_weeklyschedule
141	Can add appointment	36	add_appointment
142	Can change appointment	36	change_appointment
143	Can delete appointment	36	delete_appointment
144	Can view appointment	36	view_appointment
145	Can add facility	37	add_facility
146	Can change facility	37	change_facility
147	Can delete facility	37	delete_facility
148	Can view facility	37	view_facility
149	Can add medicine	38	add_medicine
150	Can change medicine	38	change_medicine
151	Can delete medicine	38	delete_medicine
152	Can view medicine	38	view_medicine
153	Can add prescription	39	add_prescription
154	Can change prescription	39	change_prescription
155	Can delete prescription	39	delete_prescription
156	Can view prescription	39	view_prescription
157	Can add staff	40	add_staff
158	Can change staff	40	change_staff
159	Can delete staff	40	delete_staff
160	Can view staff	40	view_staff
161	Can add books	41	add_books
162	Can change books	41	change_books
163	Can delete books	41	delete_books
164	Can view books	41	view_books
165	Can add contains	42	add_contains
166	Can change contains	42	change_contains
167	Can delete contains	42	delete_contains
168	Can view contains	42	view_contains
169	Can add doctor	43	add_doctor
170	Can change doctor	43	change_doctor
171	Can delete doctor	43	delete_doctor
172	Can view doctor	43	view_doctor
173	Can add lab technician	44	add_labtechnician
174	Can change lab technician	44	change_labtechnician
175	Can delete lab technician	44	delete_labtechnician
176	Can view lab technician	44	view_labtechnician
177	Can add nurse	45	add_nurse
178	Can change nurse	45	change_nurse
179	Can delete nurse	45	delete_nurse
180	Can view nurse	45	view_nurse
181	Can add generalpracticioner	46	add_generalpracticioner
182	Can change generalpracticioner	46	change_generalpracticioner
183	Can delete generalpracticioner	46	delete_generalpracticioner
184	Can view generalpracticioner	46	view_generalpracticioner
185	Can add specialist	47	add_specialist
186	Can change specialist	47	change_specialist
187	Can delete specialist	47	delete_specialist
188	Can view specialist	47	view_specialist
189	Can add treats	48	add_treats
190	Can change treats	48	change_treats
191	Can delete treats	48	delete_treats
192	Can view treats	48	view_treats
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$120000$2z2frgJ8xPTL$9I8F2CkusmnmwvwREN3S+3pAJmtJE0KPN7ra9jbjk4s=	2018-11-15 13:16:00.784484-08	t	admin			adel-s@outlook.com	t	t	2018-11-11 16:18:00.360872-08
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: contains; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contains (prescriptionid, din) FROM stdin;
10000	34649775
10001	35068649
10002	35164372
10003	38253422
10004	38863136
10000	39815526
10001	39832412
10002	40188222
10003	41474553
10004	41984720
10000	45227865
10001	45716327
10002	47283530
10003	50589752
10004	51375902
10003	51483068
10000	27355705
10001	27355705
10002	27355705
10003	27355705
10004	27355705
10005	27355705
10006	27355705
10007	27355705
10008	27355705
10009	27355705
10010	27355705
10011	27355705
10012	27355705
10013	27355705
10014	27355705
10004	21044495
10006	21044495
10008	90147511
10010	91534855
10011	91962435
10000	92207285
10012	93224755
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-11-15 14:23:17.927116-08	100049	Patient object (100049)	3		33	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	doctor	appointment
8	doctor	authgroup
9	doctor	authgrouppermissions
10	doctor	authpermission
11	doctor	authuser
12	doctor	authusergroups
13	doctor	authuseruserpermissions
14	doctor	djangoadminlog
15	doctor	djangocontenttype
16	doctor	djangomigrations
17	doctor	djangosession
18	doctor	medicine
19	doctor	patient
20	doctor	scheduledtime
21	doctor	weeklyschedule
22	doctor	facility
23	doctor	books
24	doctor	contains
25	doctor	prescription
26	doctor	staff
27	doctor	nurse
28	doctor	doctor
29	doctor	specialist
30	doctor	treats
31	doctor	generalpracticioner
32	doctor	labtechnician
33	Patient	patient
34	WeeklySchedule	scheduledtime
35	WeeklySchedule	weeklyschedule
36	Staff	appointment
37	Staff	facility
38	Staff	medicine
39	Staff	prescription
40	Staff	staff
41	Staff	books
42	Staff	contains
43	Staff	doctor
44	Staff	labtechnician
45	Staff	nurse
46	Staff	generalpracticioner
47	Staff	specialist
48	Staff	treats
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-11-11 16:17:06.657532-08
2	auth	0001_initial	2018-11-11 16:17:07.022589-08
3	admin	0001_initial	2018-11-11 16:17:07.104336-08
4	admin	0002_logentry_remove_auto_add	2018-11-11 16:17:07.118299-08
5	admin	0003_logentry_add_action_flag_choices	2018-11-11 16:17:07.140246-08
6	contenttypes	0002_remove_content_type_name	2018-11-11 16:17:07.201079-08
7	auth	0002_alter_permission_name_max_length	2018-11-11 16:17:07.21006-08
8	auth	0003_alter_user_email_max_length	2018-11-11 16:17:07.223019-08
9	auth	0004_alter_user_username_opts	2018-11-11 16:17:07.237979-08
10	auth	0005_alter_user_last_login_null	2018-11-11 16:17:07.256929-08
11	auth	0006_require_contenttypes_0002	2018-11-11 16:17:07.258924-08
12	auth	0007_alter_validators_add_error_messages	2018-11-11 16:17:07.286849-08
13	auth	0008_alter_user_username_max_length	2018-11-11 16:17:07.339708-08
14	auth	0009_alter_user_last_name_max_length	2018-11-11 16:17:07.350678-08
15	sessions	0001_initial	2018-11-11 16:17:07.427475-08
16	doctor	0001_initial	2018-11-12 00:34:14.132002-08
17	Patient	0001_initial	2018-11-14 13:09:35.215007-08
18	Staff	0001_initial	2018-11-14 13:09:35.278341-08
19	Staff	0002_auto_20181114_1142	2018-11-14 13:09:35.283383-08
20	WeeklySchedule	0001_initial	2018-11-14 13:09:35.289436-08
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
sv7pui0p5k74l51pmy3godak1mae6tge	NDdkZTAzYWFhM2JjNTAwMDE5N2NkOTQ1OTM1MjY0MzFkMmViZmU5MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhMjFjMjVjYjFkNWI4MjJjOWU0OWIxMDE4MDg5MzY4YjQ5MDk1ODQ5In0=	2018-11-25 16:20:16.775146-08
yfig31oufevtlt9cu2zk28xkzy96bni9	NDdkZTAzYWFhM2JjNTAwMDE5N2NkOTQ1OTM1MjY0MzFkMmViZmU5MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhMjFjMjVjYjFkNWI4MjJjOWU0OWIxMDE4MDg5MzY4YjQ5MDk1ODQ5In0=	2018-11-26 00:36:37.924852-08
gaw236bbo0vwev0sdrcu8tj5qa7bwn9o	NDdkZTAzYWFhM2JjNTAwMDE5N2NkOTQ1OTM1MjY0MzFkMmViZmU5MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhMjFjMjVjYjFkNWI4MjJjOWU0OWIxMDE4MDg5MzY4YjQ5MDk1ODQ5In0=	2018-11-29 13:16:00.793151-08
\.


--
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (id, availableforemergency) FROM stdin;
1000	t
1001	f
1002	f
1003	f
1004	f
1005	f
1006	t
1007	t
1008	t
1009	t
1010	f
1011	f
1012	t
1013	f
1014	t
\.


--
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facility (id, type) FROM stdin;
ECG00001	ElectroCardiography
CT000001	CT
MRI00001	MRI
XRAY0001	X-RAY
EEG00001	EEG
BT000001	Blood Test
BT000002	Blood Test
XRAY0002	X-RAY
CT000002	CT
\.


--
-- Data for Name: generalpracticioner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generalpracticioner (id) FROM stdin;
1000
1001
1002
1003
1004
1005
1006
1007
1008
1009
\.


--
-- Data for Name: lab_technician; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab_technician (id, fid) FROM stdin;
1040	ECG00001
1041	CT000001
1042	MRI00001
1043	XRAY0001
1044	EEG00001
1045	BT000001
1046	BT000002
1047	XRAY0002
1048	CT000002
1049	ECG00001
1050	CT000001
1051	MRI00001
1052	XRAY0001
1053	EEG00001
1054	BT000001
1055	BT000002
1056	XRAY0002
1057	CT000002
1058	CT000001
1059	BT000001
\.


--
-- Data for Name: medicine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicine (din, brand, ingredients, sideeffect) FROM stdin;
12947395	Cummerata	acetaminophen	nisi
20021345	Bauch	ibuprofen	praesentium
23080415	Vandervort	acetaminophen	tempore
27355705	Boyer	ibuprofen	dolores
33403675	Beahan	acetaminophen	quo
36748925	Denesik	ibuprofen	fugit
52223165	Blanda	ibuprofen	harum
63210235	Huels	Actinomycin	sint
65884735	Cummerata	Amethocaine	tempora
72190365	Bauch	Amphotericin	dignissimos
96656435	Vandervort	Amylobarbitone	at
11510228	Boyer	Bacillus	consequuntur
11822364	Beahan	Benzhexol	cumque
12363454	Denesik	Colaspase	consequatur
14448489	Blanda	Comethylcobalamin	repudiandae
14679459	Huels	Crystal	a
15819656	Cummerata	Cysteamine	facere
16550061	Bauch	Dothiepin	qui
17596605	Vandervort	Doxycycline	omnis
21044495	Boyer	Eformoterol	quae
22997000	Beahan	Eformoterol	sit
24332151	Denesik	Eformoterol	minima
24562075	Blanda	Frusemide	veniam
25438471	Huels	Frusemide	voluptate
25981698	Cummerata	Glycopyrrolate	perspiciatis
26065518	Bauch	Hydroxyurea	aut
26600339	Vandervort	Lignocaine	vel
27794521	Boyer	Co methylcobalamin	fugiat
28198250	Beahan	Crystal	officia
29394630	Denesik	Cysteamine	temporibus
30244514	Blanda	Dothiepin	illo
31553088	Huels	Doxycycline	corrupti
31900836	Marquardt	Eformoterol	autem
32864793	Predovic	Eformoterol	sunt
32911417	Bogisich	Eformoterol	aut
34649775	Mertz	Frusemide	quis
35068649	Mayert	Frusemide	numquam
35164372	Fisher	Glycopyrrolate	ratione
38253422	Hermiston	Hydroxyurea	facilis
38863136	Kassulke	Lignocaine	eum
39815526	Pouros	Co methylcobalamin	et
39832412	Homenick	Crystal	deserunt
40188222	Oberbrunner	Cysteamine	maxime
41474553	Baumbach	Dothiepin	esse
41984720	Oberbrunner	Doxycycline	dolorem
45227865	Hegmann	Eformoterol	quidem
45716327	Bergstrom	Eformoterol	deleniti
47283530	Crist	Eformoterol	vitae
50589752	Williamson	Frusemide	officiis
51375902	Predovic	Frusemide	perferendis
51483068	Bogisich	Glycopyrrolate	iusto
51805419	Mertz	Hydroxyurea	doloribus
51978333	Mayert	Lignocaine	aut
51982126	Fisher	Comethylcobalamin	et
52388528	Hermiston	Crystal	nisi
56344275	Kassulke	Cysteamine	repudiandae
58019659	Pouros	Dothiepin	accusantium
58544238	Homenick	Doxycycline	assumenda
59758574	Oberbrunner	Eformoterol	neque
60666979	Baumbach	Eformoterol	ipsum
60962130	Osinski	Eformoterol	totam
61707737	West	Frusemide	nostrum
63861349	Runolfsdottir	Frusemide	id
64346312	Kozey	Glycopyrrolate	qui
64392215	Stark	Hydroxyurea	veniam
65842507	Bartell	Lignocaine	exercitationem
65918109	Osinski	acetaminophen	doloremque
67348842	Oberbrunner	ibuprofen	dolor
70497739	Osinski	acetaminophen	magnam
72158888	Osinski	ibuprofen	exercitationem
72440000	Osinski	ibuprofen	tempore
74319507	Osinski	acetaminophen	error
74336227	Osinski	ibuprofen	quas
74366260	Osinski	acetaminophen	sunt
77572352	Osinski	ibuprofen	dolorem
78052795	Osinski	ibuprofen	sed
78534506	Osinski	ibuprofen	quasi
78661092	Osinski	acetaminophen	cum
78777326	Osinski	ibuprofen	et
79213965	Osinski	acetaminophen	dignissimos
81613556	Osinski	ibuprofen	et
82067282	Osinski	ibuprofen	est
82275515	Osinski	Cephalothin	rerum
82374108	Kassulke	Cephamandole	explicabo
85728409	Osinski	Cephazolin	autem
87082092	Osinski	Cephazolin	consequatur
88146715	Osinski	Chlorthalidone	at
89226901	Osinski	Cholecalciferol	harum
90147511	Osinski	Cholestyramine	excepturi
91534855	Osinski	Cisatracurium	voluptatibus
91962435	Osinski	Clomiphene	commodi
92207285	Osinski	Cyclosporin	eos
93224755	Osinski	Cephalothin	blanditiis
93301504	Osinski	Cephamandole	quia
94614839	Osinski	Cephazolin	ad
95907418	Osinski	Cephazolin	asperiores
96538813	Osinski	Chlorthalidone	ea
97351926	Osinski	Cholecalciferol	nihil
98706697	Osinski	Cholestyramine	nostrum
99893527	Osinski	Cisatracurium	non
\.


--
-- Data for Name: nurse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nurse (id, did) FROM stdin;
1015	1000
1016	1001
1017	1002
1018	1003
1019	1005
1020	1006
1021	1008
1022	1010
1023	1011
1024	1012
1025	1013
1026	1002
1027	1003
1028	1005
1029	1006
1030	1008
1031	1010
1032	1002
1033	1000
1034	1001
1035	1002
1036	1003
1037	1005
1038	1006
1039	1008
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient (id, email, name, healthcard, phone) FROM stdin;
100000	wiegand.barbara@yahoo.com     	Prof. Francesca Glei	947-19958-574125	(170)729-3042
100001	hjohnson@yahoo.com            	Melissa Mitchell    	415-43225-516703	(374)610-7716
100002	lbeahan@gmail.com             	Mr. Lindsey Wisoky D	443-12209-146908	(534)342-8808
100003	athena.donnelly@hotmail.com   	Justice Adams       	036-27765-540455	(109)030-7267
100005	pgibson@yahoo.com             	Edison Douglas      	184-14763-376757	(340)460-0077
100006	cristina73@gmail.com          	Lane Dibbert        	468-90528-841278	(866)087-6164
100007	dsanford@yahoo.com            	Citlalli Hagenes    	844-74658-859352	(674)032-7560
100008	keebler.francisco@yahoo.com   	Miss Megane Jones   	885-82265-679329	(843)881-0189
100009	quigley.markus@yahoo.com      	Darion Cronin       	495-14368-335746	(302)309-7401
100010	weimann.shad@yahoo.com        	Mr. Joe Towne       	569-71707-563928	(360)522-3910
100011	abby18@hotmail.com            	Leonor Effertz      	189-59729-481442	(873)162-6384
100012	sidney.hoeger@yahoo.com       	Ms. Mina Kunze      	515-72059-628005	(915)188-2868
100013	pierce.yost@hotmail.com       	Casper Bauch        	253-11433-970239	(182)176-1662
100014	reynolds.bettie@hotmail.com   	Alvina Moen         	740-14545-212876	(816)368-8012
100015	nellie08@gmail.com            	Laurine Doyle       	791-35507-114212	(757)686-8983
100016	lowe.alicia@yahoo.com         	Mr. Ferne Deckow    	068-37219-629092	(611)065-8585
100017	kevon.williamson@gmail.com    	Dr. Oliver Lynch    	752-04331-234798	(282)295-7704
100018	ubaumbach@gmail.com           	Maxine Crona        	968-74954-089701	(873)665-9710
100019	beahan.carmen@hotmail.com     	Abelardo Medhurst   	658-80132-848243	(813)058-9072
100020	ttromp@yahoo.com              	Misael Jakubowski MD	930-71459-473231	(713)376-5504
100021	kemmer.burnice@gmail.com      	Miss Ernestina Kilba	576-23928-900168	(831)330-3832
100022	katrina85@yahoo.com           	Miss Bert Goldner MD	804-13136-153211	(818)213-4767
100023	vandervort.vincenza@gmail.com 	Ms. Camylle O'Kon II	199-67035-363518	(269)241-9590
100024	tnitzsche@yahoo.com           	Dr. Delilah Jerde   	609-63355-024898	(060)970-5750
100025	rohan.nona@yahoo.com          	Mr. Justus Rosenbaum	291-76801-094395	(766)721-4064
100026	blick.zakary@hotmail.com      	Josefina Kuhn       	656-39176-779617	(325)395-0695
100027	bmueller@gmail.com            	Prof. Jared Hintz DD	000-50536-908231	(599)042-0349
100028	daija.mayert@gmail.com        	Dr. Hollie Tromp    	148-60245-140325	(630)369-8253
100029	derek77@yahoo.com             	Kacie Kozey         	397-47365-929679	(106)884-6509
100030	rosanna09@hotmail.com         	Dr. Kayley Muller   	206-04266-720873	(177)028-3320
100031	marlee23@hotmail.com          	Allene Hettinger    	157-65706-894997	(237)076-7485
100032	leif65@hotmail.com            	Aileen Rohan        	937-34160-523396	(314)718-7306
100033	wiza.verdie@gmail.com         	Ms. Filomena Will DD	190-15798-581017	(035)568-4116
100034	erna53@yahoo.com              	Brittany Maggio III 	057-94315-956559	(071)375-2623
100035	mcdermott.noe@hotmail.com     	Ms. Genesis Dare    	303-74874-141858	(026)778-5454
100036	qschmeler@yahoo.com           	Okey Bartoletti     	285-46337-003224	(696)860-1036
100037	maria98@yahoo.com             	Horacio Bernhard    	103-57546-872336	(723)077-9775
100038	borer.beaulah@yahoo.com       	Elinor Kemmer       	237-28525-289882	(067)424-7858
100039	tracy04@gmail.com             	Zane Mann           	390-65782-286126	(305)201-5029
100040	michale.champlin@gmail.com    	Amaya Grant         	140-20969-608543	(742)198-7021
100041	mohr.brent@hotmail.com        	Logan Botsford      	222-20640-451518	(165)437-3631
100042	qpfannerstill@yahoo.com       	Laney Johnson       	105-47183-641511	(608)752-4716
100043	madison.beier@hotmail.com     	Brennan Hegmann     	973-21487-399456	(207)712-5112
100044	winston26@hotmail.com         	Aniyah Quigley      	846-54170-380947	(996)488-6400
100045	lparisian@yahoo.com           	Brock Torp          	958-21955-226840	(843)514-8080
100046	alexanne64@yahoo.com          	Dorcas Mueller      	936-76531-217271	(805)570-8983
100047	cstamm@hotmail.com            	Julio McGlynn       	484-98706-265287	(050)977-2222
100048	emory.johnson@hotmail.com     	Augustine Conn DDS  	083-64584-108510	(153)036-3128
100004	sample@hotmail.com            	Sample Output       	553-70305-590650	(213)213-2133
100050	sample@sample.net             	Sample create       	7777-777-777	(111)111-1111
\.


--
-- Data for Name: prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription (prescriptionid, instruction, substitutable) FROM stdin;
10000	Not before Meal	f
10001	\N	t
10002	\N	f
10003	Shakes before taking	f
10004	\N	t
10005	hello	t
10006	\N	f
10007	\N	f
10009	\N	f
10010	\N	t
10011	\N	f
10012	\N	t
10013	\N	t
10014	Yes	t
10008	\N	t
\.


--
-- Data for Name: scheduled_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scheduled_time (date, starttime, endtime, wid, notes) FROM stdin;
2019-01-04	10:00:00	11:00:00	10590001	Room 201
2019-01-02	09:00:00	18:00:00	10040001	\N
2019-01-04	14:00:00	15:00:00	10030001	\N
2019-01-03	11:00:00	22:00:00	10040001	\N
1998-01-01	16:00:00	17:00:01	10330001	please
2019-01-09	14:00:00	20:00:00	10000001	Room 3001
2019-01-06	10:00:00	11:00:00	10590001	Room 201
2019-01-26	18:00:00	19:00:00	10590001	Sample
\.


--
-- Data for Name: specialist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialist (id, specialization) FROM stdin;
1010	Neurologist
1011	Immunologist
1012	Cardiovascular surge
1013	Surgeon
1014	Dermatologist
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (id, email, name, license, phone) FROM stdin;
1000	randi25@dashh.ca	Cathryn Volkman	00b40u38	(847)751-0158
1001	elian.flatley@dashh.ca	Pearline King	00p74v36	(906)060-6217
1002	erna44@dashh.ca	Ali Conroy	00x48r89	(676)057-5972
1003	dare.heidi@dashh.ca	PansyO Kon	00y51t43	(230)100-1880
1004	thomas94@dashh.ca	Dr. Dagmar Schmidt	01o26b57	(629)119-9664
1005	drunte@dashh.ca	Nickolas Johnson	02l91w21	(957)145-2026
1006	collins.jackson@dashh.ca	Dr. Ralph Kirlin Jr.	03d42a41	(488)642-4803
1007	leonora30@dashh.ca	Bonnie Erdman	06p52y53	(739)173-0888
1008	porter.feeney@dashh.ca	Prof. Gerhard Hills 	06q95f40	(505)110-1114
1009	aubrey26@dashh.ca	Elinore Beer	07e50m52	(753)590-9410
1010	pfannerstill.estell@dashh.ca	Mrs. Eloise Klocko	07k79l62	(995)600-5133
1011	ibeer@dashh.ca	Miss Alva Gislason D	07r36l25	(783)250-9190
1012	swaniawski.lorine@dashh.ca	Hassie Bergstrom	07s95x85	(562)000-9321
1013	wolff.aurelie@dashh.ca	Kelley Schoen	07z68v12	(135)833-1706
1014	ivah.gusikowski@dashh.ca	Rafael Tromp	09e55u87	(294)304-8410
1015	thompson.faye@dashh.ca	Destiney Dare	27y32n35	(046)386-2194
1016	xprosacco@dashh.ca	Aurore Buckridge	28j55b05	(665)375-3952
1017	alexzander35@dashh.ca	Dr. Ronny DuBuque DD	28s27n19	(646)371-8972
1018	dibbert.carolyne@dashh.ca	Prof. Everardo Cruic	29c59h72	(656)361-8140
1019	walter.audreanne@dashh.ca	Baby VonRueden	29e01e40	(658)454-7415
1020	frederick.ruecker@dashh.ca	Cleta Johns PhD	29n45c73	(942)006-0975
1021	igutmann@dashh.ca	Ernest Carroll	29s01u07	(989)328-0025
1022	cathy.grady@dashh.ca	Jackie Brekke	29u59w99	(743)222-9512
1023	nrolfson@dashh.ca	Mrs. Retha Zboncak D	30i85s36	(840)598-9946
1024	fgleichner@dashh.ca	Pinkie Considine	30s39p51	(081)053-7470
1025	ladarius67@dashh.ca	Miss Alycia Wunsch	30w15n53	(995)748-1626
1026	pierre.baumbach@dashh.ca	Gordon Hettinger	31i38y07	(137)287-2020
1027	monahan.russell@dashh.ca	Zechariah Klein	31r51t60	(771)525-5870
1028	kylie10@dashh.ca	Travis Cole Sr.	31v19r35	(101)072-3183
1029	lorna96@dashh.ca	Dr. Jalen Christians	34k28x98	(355)644-5675
1030	nedra15@dashh.ca	Willard Erdman Sr.	35f18n48	(113)156-9109
1031	creichel@dashh.ca	Gabrielle DuBuque	35h70n39	(732)240-9128
1032	jacynthe.goldner@dashh.ca	Roel Mitchell	35l73l56	(434)063-8527
1033	orn.kaelyn@dashh.ca	Ms. Rosamond Hansen 	35w31q40	(142)605-1587
1034	riley.dach@dashh.ca	Annabell Strosin III	36t12d51	(671)687-1897
1035	heidi.lubowitz@dashh.ca	Dr. Jovany Sanford D	37u19y72	(373)580-6243
1036	okeeling@dashh.ca	Dr. Adan Frami V	38d50r25	(776)303-9424
1037	blaze63@dashh.ca	Triston Tillman	38m83s28	(837)094-2869
1038	dkihn@dashh.ca	Dr. Colin Nitzsche D	38s41o07	(590)373-8783
1039	parker.haley@dashh.ca	Linnea Buckridge	39c65s05	(368)178-7221
1040	gerhold.jada@dashh.ca	Dr. Simeon Wuckert M	87r32a44	(731)476-1270
1041	timmy84@dashh.ca	Josh Stoltenberg	87w67d96	(336)311-4737
1042	otis.bruen@dashh.ca	Prof. Gerda Goodwin	88q95v59	(865)767-3824
1043	muller.carlotta@dashh.ca	Foster Okuneva	89e24u97	(436)197-0638
1044	dhansen@dashh.ca	Dr. Adrienne Fadel	89g33g26	(418)875-8358
1045	gillian29@dashh.ca	Mrs. Bridie O'Conner	89n15j83	(155)332-3715
1046	ykemmer@dashh.ca	Sonia Keebler	89o10j79	(548)576-4720
1047	buddy.walker@dashh.ca	Madyson Batz	90a23s23	(533)864-2472
1048	lucienne.wintheiser@dashh.ca	Miss Althea Feil MD	90l22v91	(101)035-4671
1049	harris.lia@dashh.ca	Wilburn King	90o24z62	(258)388-9721
1050	fay.tracy@dashh.ca	Alexandre Kilback	90z25j66	(359)439-1165
1051	bkunde@dashh.ca	Prof. Cierra Davis P	91g59d91	(052)258-5082
1052	kirstin.kuvalis@dashh.ca	Cleveland Runte	92i21f51	(223)909-8184
1053	zemlak.lucie@dashh.ca	Miss Margarett Herma	92m86l98	(298)806-4342
1054	hreilly@dashh.ca	Miss Roberta Wolf Sr	94o78e33	(289)193-3819
1055	moses54@dashh.ca	Buford Kuvalis PhD	95r67d64	(838)458-8908
1056	rwintheiser@dashh.ca	Daniella Powlowski	95u00h39	(126)837-3215
1057	elliot.fisher@dashh.ca	Maybell Parisian	96a54v00	(125)224-4200
1058	hilpert.willis@dashh.ca	Jerrold Carroll DVM	96d10x23	(238)698-0015
1059	jlehner@dashh.ca	Miss Skyla Reichel M	96p57j74	(845)241-6997
\.


--
-- Data for Name: treats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treats (did, pid, prescriptionid) FROM stdin;
1013	100024	10000
1004	100012	10001
1003	100032	10002
1009	100011	10003
1008	100001	10004
\.


--
-- Data for Name: weeklyschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weeklyschedule (id, sid) FROM stdin;
10000001	1000
10010001	1001
10020001	1002
10030001	1003
10040001	1004
10050001	1005
10060001	1006
10070001	1007
10080001	1008
10090001	1009
10100001	1010
10110001	1011
10120001	1012
10130001	1013
10140001	1014
10150001	1015
10160001	1016
10170001	1017
10180001	1018
10190001	1019
10200001	1020
10210001	1021
10220001	1022
10230001	1023
10240001	1024
10250001	1025
10260001	1026
10270001	1027
10280001	1028
10290001	1029
10300001	1030
10310001	1031
10320001	1032
10330001	1033
10340001	1034
10350001	1035
10360001	1036
10370001	1037
10380001	1038
10390001	1039
10400001	1040
10410001	1041
10420001	1042
10430001	1043
10440001	1044
10450001	1045
10460001	1046
10470001	1047
10480001	1048
10490001	1049
10500001	1050
10510001	1051
10520001	1052
10530001	1053
10540001	1054
10550001	1055
10560001	1056
10570001	1057
10580001	1058
10590001	1059
\.


--
-- Name: appointment_appointmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_appointmentid_seq', 10000011, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 192, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 48, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 20, true);


--
-- Name: patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patient_id_seq', 100050, true);


--
-- Name: prescription_prescriptionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescription_prescriptionid_seq', 10015, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 1059, true);


--
-- Name: Books Books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Books"
    ADD CONSTRAINT "Books_pkey" PRIMARY KEY ("FID", "AppointmentID");


--
-- Name: appointment appointment_appointmentId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT "appointment_appointmentId" PRIMARY KEY (appointmentid);


--
-- Name: appointment appointment_appointmentId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT "appointment_appointmentId_key" UNIQUE (appointmentid);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: contains contains_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contains
    ADD CONSTRAINT contains_pkey PRIMARY KEY (prescriptionid, din);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id);


--
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (id);


--
-- Name: generalpracticioner generalpracticioner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generalpracticioner
    ADD CONSTRAINT generalpracticioner_pkey PRIMARY KEY (id);


--
-- Name: lab_technician lab_technician_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_technician
    ADD CONSTRAINT lab_technician_pkey PRIMARY KEY (id, fid);


--
-- Name: medicine medicine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT medicine_pkey PRIMARY KEY (din);


--
-- Name: nurse nurse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nurse
    ADD CONSTRAINT nurse_pkey PRIMARY KEY (id, did);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- Name: prescription prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_pkey PRIMARY KEY (prescriptionid);


--
-- Name: scheduled_time scheduled_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scheduled_time
    ADD CONSTRAINT scheduled_time_pkey PRIMARY KEY (date, starttime, endtime, wid);


--
-- Name: specialist specialist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialist
    ADD CONSTRAINT specialist_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: treats treats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treats
    ADD CONSTRAINT treats_pkey PRIMARY KEY (did, pid, prescriptionid);


--
-- Name: weeklyschedule weeklyschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weeklyschedule
    ADD CONSTRAINT weeklyschedule_pkey PRIMARY KEY (id);


--
-- Name: weeklyschedule weeklyschedule_sid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weeklyschedule
    ADD CONSTRAINT weeklyschedule_sid_key UNIQUE (sid);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: Books ApppointmentID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Books"
    ADD CONSTRAINT "ApppointmentID_fkey" FOREIGN KEY ("AppointmentID") REFERENCES public.appointment(appointmentid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Books FID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Books"
    ADD CONSTRAINT "FID_fkey" FOREIGN KEY ("FID") REFERENCES public.facility(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contains Medicine; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contains
    ADD CONSTRAINT "Medicine" FOREIGN KEY (din) REFERENCES public.medicine(din) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contains Prescription; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contains
    ADD CONSTRAINT "Prescription" FOREIGN KEY (prescriptionid) REFERENCES public.prescription(prescriptionid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: appointment appointment_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_did_fkey FOREIGN KEY (did) REFERENCES public.doctor(id) ON DELETE CASCADE;


--
-- Name: appointment appointment_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pid_fkey FOREIGN KEY (pid) REFERENCES public.patient(id) ON DELETE CASCADE;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: treats did fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treats
    ADD CONSTRAINT "did fkey" FOREIGN KEY (did) REFERENCES public.doctor(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: doctor doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_id_fkey FOREIGN KEY (id) REFERENCES public.staff(id) ON DELETE CASCADE;


--
-- Name: generalpracticioner generalpracticioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generalpracticioner
    ADD CONSTRAINT generalpracticioner_id_fkey FOREIGN KEY (id) REFERENCES public.doctor(id) ON DELETE CASCADE;


--
-- Name: lab_technician lab_technician_fid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_technician
    ADD CONSTRAINT lab_technician_fid_fkey FOREIGN KEY (fid) REFERENCES public.facility(id) ON DELETE CASCADE;


--
-- Name: lab_technician lab_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_technician
    ADD CONSTRAINT lab_technician_id_fkey FOREIGN KEY (id) REFERENCES public.staff(id) ON DELETE CASCADE;


--
-- Name: nurse nurse_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nurse
    ADD CONSTRAINT nurse_did_fkey FOREIGN KEY (did) REFERENCES public.doctor(id) ON DELETE CASCADE;


--
-- Name: nurse nurse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nurse
    ADD CONSTRAINT nurse_id_fkey FOREIGN KEY (id) REFERENCES public.staff(id) ON DELETE CASCADE;


--
-- Name: treats pid fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treats
    ADD CONSTRAINT "pid fkey" FOREIGN KEY (pid) REFERENCES public.patient(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: treats prescriptionid fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treats
    ADD CONSTRAINT "prescriptionid fkey" FOREIGN KEY (prescriptionid) REFERENCES public.prescription(prescriptionid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scheduled_time scheduled_time_wid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scheduled_time
    ADD CONSTRAINT scheduled_time_wid_fkey FOREIGN KEY (wid) REFERENCES public.weeklyschedule(id) ON DELETE CASCADE;


--
-- Name: specialist specialist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialist
    ADD CONSTRAINT specialist_id_fkey FOREIGN KEY (id) REFERENCES public.doctor(id) ON DELETE CASCADE;


--
-- Name: weeklyschedule weeklyschedule_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weeklyschedule
    ADD CONSTRAINT weeklyschedule_sid_fkey FOREIGN KEY (sid) REFERENCES public.staff(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

