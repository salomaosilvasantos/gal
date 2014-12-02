--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.5
-- Dumped by pg_dump version 9.3.5
-- Started on 2014-11-17 09:13:40 BRT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP VIEW IF EXISTS quantidade_exemplares_view;
DROP TABLE IF EXISTS exemplares;
DROP TABLE IF EXISTS integracao_curricular;
DROP TABLE IF EXISTS bibliografias;
DROP TABLE IF EXISTS curriculo;
DROP TABLE IF EXISTS titulos;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS disciplinas;
DROP TABLE IF EXISTS papel_usuario;
DROP TABLE IF EXISTS papel;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS meta;

--
-- TOC entry 190 (class 3079 OID 11791)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 190
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 34260)
-- Name: bibliografias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bibliografias (
    id_disciplina integer NOT NULL,
    id_titulo integer NOT NULL,
    tipo_bibliografia character varying NOT NULL
);


ALTER TABLE public.bibliografias OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 34266)
-- Name: curriculo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE curriculo (
    id_c integer NOT NULL,
    ano_semestre character varying,
    id_curso integer NOT NULL
);


ALTER TABLE public.curriculo OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 34272)
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE curso (
    id_crs integer NOT NULL,
    cod_c integer NOT NULL,
    nome_c character varying,
    sigla character varying
);


ALTER TABLE public.curso OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 34278)
-- Name: disciplinas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE disciplinas (
    id_d integer NOT NULL,
    cod_d character varying NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.disciplinas OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 34284)
-- Name: exemplares; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE exemplares (
    id_e integer NOT NULL,
    id_titulo integer NOT NULL,
    cod_e character varying NOT NULL
);


ALTER TABLE public.exemplares OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 34290)
-- Name: integracao_curricular; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE integracao_curricular (
    id_disciplina integer NOT NULL,
    id_curriculo integer NOT NULL,
    qtd_alunos integer,
    semestre_oferta integer,
    CONSTRAINT integracao_curricular_semestre_oferta_check CHECK ((0 < semestre_oferta)),
    CONSTRAINT integracao_curricular_semestre_oferta_check1 CHECK ((11 > semestre_oferta))
);


ALTER TABLE public.integracao_curricular OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 34331)
-- Name: meta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE meta (
    id_mt integer NOT NULL,
    indicecalculobasica double precision NOT NULL,
    indicecalculocomplementar double precision NOT NULL,
    nome character varying(255)
);


ALTER TABLE public.meta OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 34329)
-- Name: meta_id_mt_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE meta_id_mt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meta_id_mt_seq OWNER TO postgres;

--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 187
-- Name: meta_id_mt_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE meta_id_mt_seq OWNED BY meta.id_mt;


--
-- TOC entry 176 (class 1259 OID 34295)
-- Name: papel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE papel (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL
);


ALTER TABLE public.papel OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 34298)
-- Name: papel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE papel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.papel_id_seq OWNER TO postgres;

--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 177
-- Name: papel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE papel_id_seq OWNED BY papel.id;


--
-- TOC entry 178 (class 1259 OID 34300)
-- Name: papel_usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE papel_usuario (
    usuario_id bigint NOT NULL,
    papel_id bigint NOT NULL
);


ALTER TABLE public.papel_usuario OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 34303)
-- Name: titulos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE titulos (
    id_t integer NOT NULL,
    isbn character varying NOT NULL,
    nome_titulo character varying NOT NULL,
    tipo_titulo character varying NOT NULL
);


ALTER TABLE public.titulos OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 34309)
-- Name: quantidade_exemplares_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW quantidade_exemplares_view AS
 SELECT titulos.id_t AS id_titulo,
    count(exemplares.id_titulo) AS quant_exemplares
   FROM (titulos
     LEFT JOIN exemplares ON ((titulos.id_t = exemplares.id_titulo)))
  GROUP BY titulos.id_t
 HAVING (count(exemplares.id_titulo) >= 0)
  ORDER BY titulos.id_t;


ALTER TABLE public.quantidade_exemplares_view OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 34313)
-- Name: seq_id_curriculo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_id_curriculo
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_id_curriculo OWNER TO postgres;

--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 181
-- Name: seq_id_curriculo; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_id_curriculo OWNED BY curriculo.id_c;


--
-- TOC entry 182 (class 1259 OID 34315)
-- Name: seq_id_curso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_id_curso
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_id_curso OWNER TO postgres;

--
-- TOC entry 2116 (class 0 OID 0)
-- Dependencies: 182
-- Name: seq_id_curso; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_id_curso OWNED BY curso.id_crs;


--
-- TOC entry 183 (class 1259 OID 34317)
-- Name: seq_id_disciplina; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_id_disciplina
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_id_disciplina OWNER TO postgres;

--
-- TOC entry 2117 (class 0 OID 0)
-- Dependencies: 183
-- Name: seq_id_disciplina; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_id_disciplina OWNED BY disciplinas.id_d;


--
-- TOC entry 184 (class 1259 OID 34319)
-- Name: seq_id_exemplar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_id_exemplar
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_id_exemplar OWNER TO postgres;

--
-- TOC entry 2118 (class 0 OID 0)
-- Dependencies: 184
-- Name: seq_id_exemplar; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_id_exemplar OWNED BY exemplares.id_e;


--
-- TOC entry 185 (class 1259 OID 34321)
-- Name: seq_id_titulo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_id_titulo
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_id_titulo OWNER TO postgres;

--
-- TOC entry 2119 (class 0 OID 0)
-- Dependencies: 185
-- Name: seq_id_titulo; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_id_titulo OWNED BY titulos.id_t;


--
-- TOC entry 186 (class 1259 OID 34323)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    id bigint NOT NULL,
    habilitado boolean NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 34339)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 2120 (class 0 OID 0)
-- Dependencies: 189
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- TOC entry 1928 (class 2604 OID 34341)
-- Name: id_c; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY curriculo ALTER COLUMN id_c SET DEFAULT nextval('seq_id_curriculo'::regclass);


--
-- TOC entry 1929 (class 2604 OID 34342)
-- Name: id_crs; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY curso ALTER COLUMN id_crs SET DEFAULT nextval('seq_id_curso'::regclass);


--
-- TOC entry 1930 (class 2604 OID 34343)
-- Name: id_d; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY disciplinas ALTER COLUMN id_d SET DEFAULT nextval('seq_id_disciplina'::regclass);


--
-- TOC entry 1931 (class 2604 OID 34344)
-- Name: id_e; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exemplares ALTER COLUMN id_e SET DEFAULT nextval('seq_id_exemplar'::regclass);


--
-- TOC entry 1937 (class 2604 OID 34334)
-- Name: id_mt; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meta ALTER COLUMN id_mt SET DEFAULT nextval('meta_id_mt_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 34345)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY papel ALTER COLUMN id SET DEFAULT nextval('papel_id_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 34346)
-- Name: id_t; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY titulos ALTER COLUMN id_t SET DEFAULT nextval('seq_id_titulo'::regclass);


--
-- TOC entry 1936 (class 2604 OID 34347)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);
