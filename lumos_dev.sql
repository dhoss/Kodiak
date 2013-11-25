--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: blogs; Type: TABLE; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE TABLE blogs (
    id integer NOT NULL,
    title character varying(255),
    author integer,
    body character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.blogs OWNER TO lumos_dev;

--
-- Name: blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: lumos_dev
--

CREATE SEQUENCE blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blogs_id_seq OWNER TO lumos_dev;

--
-- Name: blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumos_dev
--

ALTER SEQUENCE blogs_id_seq OWNED BY blogs.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(40),
    created_at timestamp without time zone
);


ALTER TABLE public.friendly_id_slugs OWNER TO lumos_dev;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: lumos_dev
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendly_id_slugs_id_seq OWNER TO lumos_dev;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumos_dev
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: galleries; Type: TABLE; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE TABLE galleries (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    slug character varying(255),
    cover_photo integer
);


ALTER TABLE public.galleries OWNER TO lumos_dev;

--
-- Name: galleries_id_seq; Type: SEQUENCE; Schema: public; Owner: lumos_dev
--

CREATE SEQUENCE galleries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galleries_id_seq OWNER TO lumos_dev;

--
-- Name: galleries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumos_dev
--

ALTER SEQUENCE galleries_id_seq OWNED BY galleries.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE TABLE photos (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    photo_thumbnail_file_name character varying(255),
    photo_thumbnail_content_type character varying(255),
    photo_thumbnail_file_size integer,
    photo_thumbnail_updated_at timestamp without time zone,
    image character varying(255),
    remote_image_url character varying(255),
    gallery_id integer
);


ALTER TABLE public.photos OWNER TO lumos_dev;

--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: lumos_dev
--

CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photos_id_seq OWNER TO lumos_dev;

--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumos_dev
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO lumos_dev;

--
-- Name: users; Type: TABLE; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    crypted_password character varying(255),
    password_salt character varying(255),
    persistence_token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255)
);


ALTER TABLE public.users OWNER TO lumos_dev;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: lumos_dev
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO lumos_dev;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumos_dev
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumos_dev
--

ALTER TABLE ONLY blogs ALTER COLUMN id SET DEFAULT nextval('blogs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumos_dev
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumos_dev
--

ALTER TABLE ONLY galleries ALTER COLUMN id SET DEFAULT nextval('galleries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumos_dev
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumos_dev
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: blogs; Type: TABLE DATA; Schema: public; Owner: lumos_dev
--

COPY blogs (id, title, author, body, created_at, updated_at) FROM stdin;
\.


--
-- Name: blogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumos_dev
--

SELECT pg_catalog.setval('blogs_id_seq', 1, false);


--
-- Data for Name: friendly_id_slugs; Type: TABLE DATA; Schema: public; Owner: lumos_dev
--

COPY friendly_id_slugs (id, slug, sluggable_id, sluggable_type, created_at) FROM stdin;
\.


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumos_dev
--

SELECT pg_catalog.setval('friendly_id_slugs_id_seq', 1, false);


--
-- Data for Name: galleries; Type: TABLE DATA; Schema: public; Owner: lumos_dev
--

COPY galleries (id, name, description, created_at, updated_at, user_id, slug, cover_photo) FROM stdin;
3	testing name stuff	testing	2013-09-23 16:35:04.422402	2013-09-23 16:35:04.422402	\N	testing-name-stuff	\N
\.


--
-- Name: galleries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumos_dev
--

SELECT pg_catalog.setval('galleries_id_seq', 3, true);


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: lumos_dev
--

COPY photos (id, name, description, created_at, updated_at, photo_thumbnail_file_name, photo_thumbnail_content_type, photo_thumbnail_file_size, photo_thumbnail_updated_at, image, remote_image_url, gallery_id) FROM stdin;
9	f3gf q3f43q	gq3gq3g4q	2013-09-23 23:23:14.062018	2013-09-23 23:23:14.062018	\N	\N	\N	\N	9d/ab/d5/fa/9dabd5fa7ccb5d1f7a9a470b97264ab9.png	\N	3
\.


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumos_dev
--

SELECT pg_catalog.setval('photos_id_seq', 9, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: lumos_dev
--

COPY schema_migrations (version) FROM stdin;
20130604020653
20130604020904
20130604202517
20130611223759
20130822195526
20130902054341
20130902054623
20130902072418
20130902072851
20130902072852
20130902080748
20130902080808
20130922222935
20130922223147
20130923202343
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: lumos_dev
--

COPY users (id, name, email, crypted_password, password_salt, persistence_token, created_at, updated_at, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip) FROM stdin;
1	\N	devin.austin@gmail.com	\N	\N	\N	2013-09-23 16:29:59.120785	2013-09-23 16:29:59.160109	$2a$10$k774h2O0frm2our.46nAveBjkUm00pxdmWLk9d9z4dqrPWtdNG8De	\N	\N	\N	1	2013-09-23 16:29:59.15828	2013-09-23 16:29:59.15828	127.0.0.1	127.0.0.1
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumos_dev
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: lumos_dev; Tablespace: 
--

ALTER TABLE ONLY blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: lumos_dev; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: galleries_pkey; Type: CONSTRAINT; Schema: public; Owner: lumos_dev; Tablespace: 
--

ALTER TABLE ONLY galleries
    ADD CONSTRAINT galleries_pkey PRIMARY KEY (id);


--
-- Name: photos_pkey; Type: CONSTRAINT; Schema: public; Owner: lumos_dev; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: lumos_dev; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_galleries_on_cover_photo; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE INDEX index_galleries_on_cover_photo ON galleries USING btree (cover_photo);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: lumos_dev; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

