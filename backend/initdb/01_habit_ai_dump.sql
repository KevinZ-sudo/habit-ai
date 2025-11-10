--
-- PostgreSQL database dump
--

\restrict 6pXpnXJOZRQVybKVjLoqiXOoq1gbZUMGgnzYuOBReXO99JINFod7fuAdwLWLxTo

-- Dumped from database version 14.19 (Homebrew)
-- Dumped by pg_dump version 14.19 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: habits; Type: TABLE; Schema: public; Owner: habit_user
--

CREATE TABLE public.habits (
    id integer NOT NULL,
    title character varying NOT NULL,
    completed boolean,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    owner_id integer
);


ALTER TABLE public.habits OWNER TO habit_user;

--
-- Name: habits_id_seq; Type: SEQUENCE; Schema: public; Owner: habit_user
--

CREATE SEQUENCE public.habits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.habits_id_seq OWNER TO habit_user;

--
-- Name: habits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: habit_user
--

ALTER SEQUENCE public.habits_id_seq OWNED BY public.habits.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: habit_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    email character varying,
    hashed_password character varying
);


ALTER TABLE public.users OWNER TO habit_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: habit_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO habit_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: habit_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: habits id; Type: DEFAULT; Schema: public; Owner: habit_user
--

ALTER TABLE ONLY public.habits ALTER COLUMN id SET DEFAULT nextval('public.habits_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: habit_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: habits; Type: TABLE DATA; Schema: public; Owner: habit_user
--

COPY public.habits (id, title, completed, start_time, end_time, owner_id) FROM stdin;
1	Stretch Break	t	2025-09-21 07:33:00	2025-09-21 08:59:00	1
2	Mindfulness Session	f	2025-10-30 10:57:00	2025-10-30 12:24:00	1
3	Check Calendar	t	2025-10-24 14:08:00	2025-10-24 15:55:00	1
4	Plan Tomorrow	f	2025-10-07 08:52:00	2025-10-07 09:25:00	1
5	Coding Practice	f	2025-11-07 11:27:00	2025-11-07 13:04:00	1
6	Budget Planning	t	2025-10-24 12:54:00	2025-10-24 13:45:00	1
7	Stretching	f	2025-10-14 07:05:00	2025-10-14 08:38:00	1
8	Plan Tomorrow	t	2025-10-04 11:03:00	2025-10-04 12:18:00	1
9	Online Course	t	2025-10-22 11:26:00	2025-10-22 12:50:00	1
10	Draw Sketch	t	2025-09-21 16:34:00	2025-09-21 17:23:00	1
11	Laundry	t	2025-10-17 08:30:00	2025-10-17 10:05:00	1
12	Yoga Practice	t	2025-09-23 20:02:00	2025-09-23 21:49:00	1
13	Mindfulness Session	f	2025-11-03 07:26:00	2025-11-03 08:38:00	1
14	Read Book	t	2025-09-23 11:52:00	2025-09-23 13:25:00	1
15	Gym Workout	f	2025-09-15 06:44:00	2025-09-15 07:36:00	1
16	Study Python	f	2025-09-13 17:48:00	2025-09-13 19:46:00	1
17	Backup Files	f	2025-10-28 08:19:00	2025-10-28 09:02:00	1
18	Backup Files	f	2025-10-23 14:48:00	2025-10-23 15:53:00	1
19	Online Course	t	2025-09-11 09:18:00	2025-09-11 10:24:00	1
20	Go for a Drive	t	2025-11-05 13:40:00	2025-11-05 14:49:00	1
21	Reading News	f	2025-10-03 09:13:00	2025-10-03 10:39:00	1
22	Check Calendar	f	2025-10-03 19:38:00	2025-10-03 21:20:00	1
23	Journal Writing	t	2025-10-17 15:18:00	2025-10-17 16:02:00	1
24	Cooking Dinner	t	2025-09-13 13:34:00	2025-09-13 14:30:00	1
25	Read Book	f	2025-10-29 17:56:00	2025-10-29 19:23:00	1
26	Study Python	t	2025-09-22 14:02:00	2025-09-22 15:58:00	1
27	Read Book	f	2025-10-25 19:24:00	2025-10-25 19:59:00	1
28	Watch Tutorial	t	2025-10-14 10:37:00	2025-10-14 11:18:00	1
29	Work on Side Project	t	2025-09-28 19:29:00	2025-09-28 20:38:00	1
30	Tidy Desk	f	2025-09-16 10:23:00	2025-09-16 11:27:00	1
31	Read Book	t	2025-09-16 16:44:00	2025-09-16 18:21:00	1
32	Draw Sketch	t	2025-11-03 07:22:00	2025-11-03 08:59:00	1
33	Laundry	f	2025-09-19 13:35:00	2025-09-19 14:26:00	1
34	Evening Run	t	2025-11-03 13:22:00	2025-11-03 15:20:00	1
35	Organize Files	t	2025-10-03 15:57:00	2025-10-03 16:38:00	1
36	Coffee Break	t	2025-09-12 11:22:00	2025-09-12 12:55:00	1
37	Gym Workout	f	2025-09-30 08:33:00	2025-09-30 09:44:00	1
38	Listen to Podcast	f	2025-10-31 14:02:00	2025-10-31 15:47:00	1
39	Read Book	t	2025-09-16 13:54:00	2025-09-16 15:38:00	1
40	Prepare Presentation	t	2025-10-29 14:48:00	2025-10-29 15:22:00	1
41	Drink Water	t	2025-09-24 12:20:00	2025-09-24 13:30:00	1
42	Mindfulness Session	t	2025-10-22 12:33:00	2025-10-22 13:43:00	1
43	Reading News	f	2025-09-13 12:48:00	2025-09-13 14:09:00	1
44	Prepare Presentation	f	2025-09-18 16:02:00	2025-09-18 16:48:00	1
45	Work on Side Project	t	2025-10-01 10:51:00	2025-10-01 12:43:00	1
46	Stretch Break	t	2025-11-03 17:32:00	2025-11-03 19:27:00	1
47	Backup Files	t	2025-10-15 14:47:00	2025-10-15 16:33:00	1
48	Learn SQL	t	2025-10-30 09:31:00	2025-10-30 10:53:00	1
49	Mindfulness Session	t	2025-11-04 08:29:00	2025-11-04 10:08:00	1
50	Budget Planning	f	2025-10-22 10:53:00	2025-10-22 11:38:00	1
51	Stretch Break	f	2025-11-02 15:51:00	2025-11-02 17:51:00	1
52	Check Emails	t	2025-09-23 10:16:00	2025-09-23 11:39:00	1
53	Mindfulness Session	t	2025-10-29 15:37:00	2025-10-29 17:25:00	1
54	Backup Files	t	2025-11-02 19:47:00	2025-11-02 21:42:00	1
55	Morning Jog	f	2025-10-19 08:26:00	2025-10-19 08:56:00	1
56	Stretching	t	2025-11-02 12:09:00	2025-11-02 13:29:00	1
57	Stretching	f	2025-09-14 15:36:00	2025-09-14 16:47:00	1
58	Clean Room	t	2025-10-18 10:38:00	2025-10-18 11:42:00	1
59	Reply Messages	t	2025-11-07 07:56:00	2025-11-07 09:55:00	1
60	Organize Files	t	2025-11-01 19:50:00	2025-11-01 20:41:00	1
61	Tidy Desk	t	2025-09-30 16:02:00	2025-09-30 17:52:00	1
62	Organize Files	t	2025-09-16 10:48:00	2025-09-16 11:55:00	1
63	Budget Planning	t	2025-09-30 08:21:00	2025-09-30 08:55:00	1
64	Read Book	t	2025-09-23 07:01:00	2025-09-23 08:42:00	1
65	Read Book	t	2025-09-25 10:59:00	2025-09-25 12:37:00	1
66	Evening Run	t	2025-11-10 19:47:00	2025-11-10 21:40:00	1
67	Call Family	f	2025-09-21 17:34:00	2025-09-21 18:59:00	1
68	Language Learning	t	2025-09-14 11:49:00	2025-09-14 12:39:00	1
69	Organize Files	t	2025-11-04 16:01:00	2025-11-04 16:57:00	1
70	Nap	f	2025-10-19 07:58:00	2025-10-19 09:50:00	1
71	Budget Planning	f	2025-11-02 14:26:00	2025-11-02 16:07:00	1
72	Online Course	t	2025-10-21 17:19:00	2025-10-21 17:50:00	1
73	Nap	f	2025-10-14 20:33:00	2025-10-14 21:13:00	1
74	Call Family	t	2025-10-30 18:07:00	2025-10-30 19:53:00	1
75	Listen to Podcast	t	2025-09-27 13:15:00	2025-09-27 14:13:00	1
76	Organize Files	t	2025-10-12 13:09:00	2025-10-12 14:04:00	1
77	Read Book	t	2025-10-30 13:27:00	2025-10-30 15:04:00	1
78	Coding Practice	t	2025-09-23 18:51:00	2025-09-23 19:58:00	1
79	Clean Room	f	2025-10-25 16:10:00	2025-10-25 17:46:00	1
80	Coffee Break	t	2025-11-07 16:58:00	2025-11-07 18:40:00	1
81	Budget Planning	t	2025-09-26 10:18:00	2025-09-26 11:10:00	1
82	Language Learning	t	2025-11-03 15:55:00	2025-11-03 17:32:00	1
83	Work on Side Project	t	2025-11-05 10:46:00	2025-11-05 12:02:00	1
84	Gym Workout	t	2025-10-03 07:34:00	2025-10-03 08:23:00	1
85	Learn SQL	t	2025-11-09 10:38:00	2025-11-09 11:41:00	1
86	Laundry	f	2025-11-07 07:26:00	2025-11-07 09:10:00	1
87	Online Course	f	2025-10-21 12:24:00	2025-10-21 12:56:00	1
88	Journal Writing	f	2025-10-20 08:58:00	2025-10-20 10:29:00	1
89	Grocery Shopping	t	2025-10-07 20:00:00	2025-10-07 20:48:00	1
90	Watch Tutorial	f	2025-10-07 08:55:00	2025-10-07 09:42:00	1
91	Draw Sketch	f	2025-10-26 18:28:00	2025-10-26 19:43:00	1
92	Go for a Drive	t	2025-09-23 10:29:00	2025-09-23 11:49:00	1
93	Budget Planning	t	2025-09-19 08:02:00	2025-09-19 08:52:00	1
94	Nap	f	2025-11-01 11:03:00	2025-11-01 12:10:00	1
95	Coding Practice	f	2025-10-10 17:01:00	2025-10-10 18:43:00	1
96	Grocery Shopping	f	2025-10-23 14:04:00	2025-10-23 15:58:00	1
97	Coffee Break	t	2025-09-17 16:40:00	2025-09-17 17:59:00	1
98	Online Course	f	2025-10-13 19:02:00	2025-10-13 19:51:00	1
99	Clean Room	t	2025-10-10 08:11:00	2025-10-10 09:40:00	1
100	Prepare Presentation	f	2025-09-15 06:06:00	2025-09-15 06:40:00	1
101	Check Emails	t	2025-10-05 17:48:00	2025-10-05 19:46:00	1
102	Plan Tomorrow	f	2025-10-25 09:17:00	2025-10-25 10:49:00	1
103	Go for a Drive	t	2025-10-01 15:23:00	2025-10-01 17:00:00	1
104	Call Family	t	2025-10-26 20:14:00	2025-10-26 21:00:00	1
105	Stretch Break	t	2025-10-03 15:06:00	2025-10-03 16:16:00	1
106	Coffee Break	t	2025-09-28 13:00:00	2025-09-28 14:19:00	1
107	Cooking Dinner	t	2025-10-27 06:33:00	2025-10-27 08:31:00	1
108	Coffee Break	f	2025-10-01 06:39:00	2025-10-01 07:31:00	1
109	Online Course	t	2025-11-08 13:42:00	2025-11-08 14:19:00	1
110	Reading News	f	2025-10-06 19:39:00	2025-10-06 20:23:00	1
111	Coding Practice	t	2025-10-05 15:08:00	2025-10-05 16:01:00	1
112	Coffee Break	f	2025-09-29 19:07:00	2025-09-29 20:40:00	1
113	Go for a Drive	t	2025-10-22 17:12:00	2025-10-22 18:20:00	1
114	Budget Planning	t	2025-11-09 09:33:00	2025-11-09 10:09:00	1
115	Yoga Practice	f	2025-10-04 19:01:00	2025-10-04 20:08:00	1
116	Prepare Presentation	t	2025-09-14 17:23:00	2025-09-14 18:21:00	1
117	Grocery Shopping	t	2025-11-03 08:09:00	2025-11-03 09:44:00	1
118	Reading News	t	2025-09-12 18:45:00	2025-09-12 19:23:00	1
119	Check Calendar	f	2025-10-27 14:00:00	2025-10-27 15:23:00	1
120	Laundry	t	2025-10-28 06:26:00	2025-10-28 07:06:00	1
121	Language Learning	t	2025-09-16 10:23:00	2025-09-16 11:56:00	1
122	Check Calendar	t	2025-10-22 09:03:00	2025-10-22 10:49:00	1
123	Coding Practice	f	2025-10-16 11:26:00	2025-10-16 12:47:00	1
124	Clean Room	t	2025-10-09 13:34:00	2025-10-09 15:03:00	1
125	Meditation	t	2025-10-04 19:35:00	2025-10-04 21:01:00	1
126	Plan Tomorrow	t	2025-09-25 16:14:00	2025-09-25 18:07:00	1
127	Take Vitamins	f	2025-10-16 13:32:00	2025-10-16 15:16:00	1
128	Go for a Drive	f	2025-09-12 17:57:00	2025-09-12 19:53:00	1
129	Study Python	t	2025-09-13 17:56:00	2025-09-13 19:32:00	1
130	Prepare Presentation	t	2025-11-04 10:40:00	2025-11-04 11:54:00	1
131	Language Learning	t	2025-09-25 19:14:00	2025-09-25 20:49:00	1
132	Draw Sketch	t	2025-11-02 09:17:00	2025-11-02 10:08:00	1
133	Budget Planning	t	2025-09-17 16:46:00	2025-09-17 17:19:00	1
134	Work on Side Project	t	2025-09-17 17:52:00	2025-09-17 18:53:00	1
135	Stretch Break	f	2025-10-20 08:00:00	2025-10-20 09:33:00	1
136	Read Book	f	2025-10-07 11:46:00	2025-10-07 12:32:00	1
137	Study Python	t	2025-10-17 20:02:00	2025-10-17 20:57:00	1
138	Cooking Dinner	t	2025-09-26 12:25:00	2025-09-26 14:06:00	1
139	Reading News	f	2025-10-21 10:37:00	2025-10-21 11:27:00	1
140	Draw Sketch	f	2025-10-20 18:56:00	2025-10-20 20:05:00	1
141	Budget Planning	f	2025-09-12 12:06:00	2025-09-12 13:55:00	1
142	Evening Run	t	2025-10-17 07:31:00	2025-10-17 09:23:00	1
143	Reading News	t	2025-10-13 19:49:00	2025-10-13 21:05:00	1
144	Read Book	t	2025-09-26 18:45:00	2025-09-26 20:05:00	1
145	Watch Tutorial	t	2025-10-06 09:06:00	2025-10-06 10:57:00	1
146	Walk Dog	t	2025-10-01 11:38:00	2025-10-01 13:38:00	1
147	Study Python	f	2025-10-08 13:09:00	2025-10-08 14:50:00	1
148	Tidy Desk	f	2025-10-18 12:12:00	2025-10-18 12:43:00	1
149	Clean Room	t	2025-09-22 12:22:00	2025-09-22 13:54:00	1
150	Stretch Break	t	2025-09-25 10:36:00	2025-09-25 12:08:00	1
151	Grocery Shopping	t	2025-10-02 13:13:00	2025-10-02 14:35:00	1
152	Stretching	t	2025-10-01 19:22:00	2025-10-01 20:53:00	1
153	Laundry	t	2025-09-25 15:37:00	2025-09-25 16:09:00	1
154	Laundry	f	2025-09-28 12:06:00	2025-09-28 12:37:00	1
155	Nap	f	2025-10-20 13:44:00	2025-10-20 14:24:00	1
156	Tidy Desk	f	2025-10-19 19:10:00	2025-10-19 20:19:00	1
157	Listen to Podcast	f	2025-10-15 16:43:00	2025-10-15 18:24:00	1
158	Listen to Podcast	t	2025-09-19 07:38:00	2025-09-19 08:57:00	1
159	Drink Water	t	2025-11-05 13:03:00	2025-11-05 13:43:00	1
160	Learn SQL	t	2025-10-25 19:30:00	2025-10-25 21:23:00	1
161	Tidy Desk	t	2025-11-01 15:28:00	2025-11-01 17:13:00	1
162	Online Course	t	2025-10-15 09:14:00	2025-10-15 10:24:00	1
163	Prepare Presentation	f	2025-09-22 10:55:00	2025-09-22 12:49:00	1
164	Nap	t	2025-10-01 16:56:00	2025-10-01 18:15:00	1
165	Nap	t	2025-10-02 19:26:00	2025-10-02 19:59:00	1
166	Laundry	f	2025-10-15 14:50:00	2025-10-15 16:38:00	1
167	Check Emails	f	2025-09-21 18:07:00	2025-09-21 19:15:00	1
168	Stretching	f	2025-10-17 15:54:00	2025-10-17 17:16:00	1
169	Language Learning	t	2025-10-15 07:18:00	2025-10-15 08:33:00	1
170	Language Learning	f	2025-09-15 19:25:00	2025-09-15 20:22:00	1
171	Gym Workout	f	2025-09-30 07:52:00	2025-09-30 09:09:00	1
172	Tidy Desk	t	2025-10-08 15:49:00	2025-10-08 17:12:00	1
173	Grocery Shopping	t	2025-10-15 13:47:00	2025-10-15 15:35:00	1
174	Watch Tutorial	t	2025-11-09 11:48:00	2025-11-09 13:36:00	1
175	Language Learning	f	2025-11-06 13:02:00	2025-11-06 14:42:00	1
176	Coding Practice	t	2025-10-04 15:02:00	2025-10-04 15:37:00	1
177	Prepare Presentation	t	2025-10-17 08:58:00	2025-10-17 10:37:00	1
178	Journal Writing	f	2025-10-21 14:50:00	2025-10-21 16:22:00	1
179	Stretch Break	f	2025-09-30 14:29:00	2025-09-30 14:59:00	1
180	Backup Files	t	2025-10-27 08:52:00	2025-10-27 10:37:00	1
181	Learn SQL	f	2025-10-02 18:26:00	2025-10-02 19:47:00	1
182	Budget Planning	t	2025-10-15 12:49:00	2025-10-15 14:33:00	1
183	Drink Water	f	2025-09-20 17:45:00	2025-09-20 18:52:00	1
184	Yoga Practice	f	2025-10-12 07:55:00	2025-10-12 09:39:00	1
185	Check Calendar	t	2025-09-20 11:30:00	2025-09-20 13:09:00	1
186	Call Family	t	2025-10-18 09:12:00	2025-10-18 09:45:00	1
187	Gym Workout	t	2025-09-21 13:47:00	2025-09-21 14:36:00	1
188	Walk Dog	t	2025-09-18 09:29:00	2025-09-18 10:32:00	1
189	Gym Workout	t	2025-10-08 19:45:00	2025-10-08 20:15:00	1
190	Language Learning	t	2025-10-08 10:17:00	2025-10-08 12:02:00	1
191	Reply Messages	f	2025-10-13 06:32:00	2025-10-13 07:38:00	1
192	Backup Files	f	2025-10-21 13:07:00	2025-10-21 14:23:00	1
193	Learn SQL	f	2025-11-06 19:30:00	2025-11-06 20:44:00	1
194	Budget Planning	f	2025-10-09 12:21:00	2025-10-09 13:21:00	1
195	Reading News	f	2025-10-10 09:07:00	2025-10-10 10:57:00	1
196	Evening Run	f	2025-10-21 18:12:00	2025-10-21 19:58:00	1
197	Work on Side Project	t	2025-09-27 14:12:00	2025-09-27 15:02:00	1
198	Journal Writing	f	2025-10-19 14:24:00	2025-10-19 16:17:00	1
199	Tidy Desk	t	2025-09-20 15:19:00	2025-09-20 16:35:00	1
200	Yoga Practice	t	2025-10-21 07:42:00	2025-10-21 08:41:00	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: habit_user
--

COPY public.users (id, username, email, hashed_password) FROM stdin;
1	testuser	testemail@test.com	$2b$12$oeqBaKbs3uOJHzVjckIvBuiQXhwQyW.9NuOZJdOqcAGe2hErGNJgK
\.


--
-- Name: habits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: habit_user
--

SELECT pg_catalog.setval('public.habits_id_seq', 200, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: habit_user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: habits habits_pkey; Type: CONSTRAINT; Schema: public; Owner: habit_user
--

ALTER TABLE ONLY public.habits
    ADD CONSTRAINT habits_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: habit_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_habits_id; Type: INDEX; Schema: public; Owner: habit_user
--

CREATE INDEX ix_habits_id ON public.habits USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: habit_user
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: habit_user
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_username; Type: INDEX; Schema: public; Owner: habit_user
--

CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);


--
-- Name: habits habits_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: habit_user
--

ALTER TABLE ONLY public.habits
    ADD CONSTRAINT habits_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 6pXpnXJOZRQVybKVjLoqiXOoq1gbZUMGgnzYuOBReXO99JINFod7fuAdwLWLxTo

