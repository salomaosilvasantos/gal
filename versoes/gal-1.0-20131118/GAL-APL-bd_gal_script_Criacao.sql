--
-- PostgreSQL database bd_gal
--

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
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

DROP TABLE IF EXISTS exemplares;
DROP TABLE IF EXISTS integracao_curricular;
DROP TABLE IF EXISTS bibliografias;
DROP TABLE IF EXISTS curriculo;
DROP TABLE IF EXISTS titulos;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS disciplinas;

--
-- Tabela: titulos;  Owner: postgres; Tablespace: 
--
CREATE TABLE titulos (
    id_t integer NOT NULL,
    isbn character varying NOT NULL,
    nome_titulo character varying NOT NULL,
    tipo_titulo character varying NOT NULL
);
ALTER TABLE public.titulos OWNER TO postgres;
ALTER TABLE ONLY titulos ADD CONSTRAINT isbn UNIQUE (isbn);
ALTER TABLE ONLY titulos ADD CONSTRAINT id PRIMARY KEY (id_t);


--
-- Name: seq_id_titulo_pk;; Type: SEQUENCE; Owner: postgres; Artibuindo a titulos.id_titulo_pk
--
CREATE SEQUENCE seq_id_titulo
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.seq_id_titulo OWNER TO postgres;
ALTER SEQUENCE seq_id_titulo OWNED BY titulos.id_t;
ALTER TABLE ONLY titulos ALTER COLUMN id_t SET DEFAULT nextval('seq_id_titulo'::regclass);
SELECT pg_catalog.setval('seq_id_titulo', 8, true);


--
-- TABLE: exemplares Owner: postgres; Tablespace: 
--
CREATE TABLE exemplares (
    id_e integer NOT NULL,
    id_titulo integer NOT NULL,
    cod_e character varying NOT NULL
);
ALTER TABLE public.exemplares OWNER TO postgres;
ALTER TABLE ONLY exemplares ADD CONSTRAINT cod_e UNIQUE (cod_e);
ALTER TABLE ONLY exemplares ADD CONSTRAINT id_e PRIMARY KEY (id_e);
ALTER TABLE ONLY exemplares 
	ADD CONSTRAINT titulo_exemplares 
	FOREIGN KEY (id_titulo) 
	REFERENCES titulos(id_t)
	ON DELETE CASCADE;

--
-- Name: seq_id_exemplar_pk; Type: SEQUENCE; Owner: postgres; Artibuindo a exemplares.id_exemplar_pk
--
CREATE SEQUENCE seq_id_exemplar
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.seq_id_exemplar OWNER TO postgres;
ALTER SEQUENCE seq_id_exemplar OWNED BY exemplares.id_e;
ALTER TABLE ONLY exemplares ALTER COLUMN id_e SET DEFAULT nextval('seq_id_exemplar'::regclass);
SELECT pg_catalog.setval('seq_id_exemplar', 2, true);


--
-- Tabela: diciplinas;  Owner: postgres; Tablespace: 
--
CREATE TABLE disciplinas (
    id_d integer NOT NULL,
    cod_d character varying NOT NULL,
    nome character varying NOT NULL,
    qtd_alunos integer,
    semestre_oferta  integer,
    CHECK (0 < semestre_oferta),
    CHECK (11 > semestre_oferta)
);
ALTER TABLE public.disciplinas OWNER TO postgres;
ALTER TABLE ONLY disciplinas ADD CONSTRAINT cod_d UNIQUE (cod_d);
ALTER TABLE ONLY disciplinas ADD CONSTRAINT id_d PRIMARY KEY (id_d);

--
-- Name: seq_id_disciplina_pk; Type: SEQUENCE; Owner: postgres; Artibuindo a disciplinas.id_disciplina_pk
--
CREATE SEQUENCE seq_id_disciplina
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.seq_id_disciplina OWNER TO postgres;
ALTER SEQUENCE seq_id_disciplina OWNED BY disciplinas.id_d;
ALTER TABLE ONLY disciplinas ALTER COLUMN id_d SET DEFAULT nextval('seq_id_disciplina'::regclass);
SELECT pg_catalog.setval('seq_id_disciplina', 0, true);


--
-- Tabela: curso;  Owner: postgres; Tablespace: 
--
CREATE TABLE curso (
	cod_c character varying NOT NULL,
	nome character varying
	
);
ALTER TABLE public.curso OWNER TO postgres;
ALTER TABLE ONLY curso ADD CONSTRAINT cod_c PRIMARY KEY (cod_c);

--
-- Tabela: curriculo;  Owner: postgres; Tablespace: 
--
CREATE TABLE curriculo (
	id_c integer NOT NULL,
	ano_semestre character varying,
	cod_curso character varying NOT NULL
	
);
ALTER TABLE public.curriculo OWNER TO postgres;
ALTER TABLE ONLY curriculo ADD CONSTRAINT id_c PRIMARY KEY (id_c);
ALTER TABLE ONLY curriculo 
	ADD CONSTRAINT curso_curriculo 
	FOREIGN KEY (cod_curso) 
	REFERENCES curso(cod_c)
	ON DELETE CASCADE;


-- Name: seq_id_curriculo; Type: SEQUENCE; Owner: postgres; Artibuindo a curriculo.id_curriculo
--
CREATE SEQUENCE seq_id_curriculo
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.seq_id_curriculo OWNER TO postgres;
ALTER SEQUENCE seq_id_curriculo OWNED BY curriculo.id_c;
ALTER TABLE ONLY curriculo ALTER COLUMN id_c SET DEFAULT nextval('seq_id_curriculo'::regclass);
SELECT pg_catalog.setval('seq_id_curriculo', 0, false);




--
-- Tabela: integração curricular;  Owner: postgres; Tablespace: 
--
CREATE TABLE integracao_curricular (
    id_disciplina integer NOT NULL,
    id_curriculo integer NOT NULL,
    PRIMARY KEY (id_disciplina,id_curriculo)
    
);
ALTER TABLE public.integracao_curricular OWNER TO postgres;
ALTER TABLE ONLY integracao_curricular 
	ADD CONSTRAINT disciplinas_integracao_curricular 
	FOREIGN KEY (id_disciplina) 
	REFERENCES disciplinas(id_d)
	ON DELETE CASCADE;
ALTER TABLE ONLY integracao_curricular 
	ADD CONSTRAINT curriculo_integracao_curricular 
	FOREIGN KEY (id_curriculo) 
	REFERENCES curriculo(id_c)
	ON DELETE CASCADE;

--
-- Tabela: bibliografias;  Owner: postgres; Tablespace: 
--
CREATE TABLE bibliografias (
    id_b integer NOT NULL,
    id_disciplina integer NOT NULL,
    id_titulo integer NOT NULL,
    tipo_bibliografia character varying NOT NULL
);
ALTER TABLE public.bibliografias OWNER TO postgres;
ALTER TABLE ONLY bibliografias ADD CONSTRAINT id_b PRIMARY KEY (id_b);
ALTER TABLE ONLY bibliografias 
	ADD CONSTRAINT disciplinas_bibliografias 
	FOREIGN KEY (id_disciplina) 
	REFERENCES disciplinas(id_d)
	ON DELETE CASCADE;
ALTER TABLE ONLY bibliografias 
	ADD CONSTRAINT titulo_bibliografias 
	FOREIGN KEY (id_titulo) 
	REFERENCES titulos(id_t)
	ON DELETE CASCADE;

-- Name: seq_id_bibliografia; Type: SEQUENCE; Owner: postgres; Artibuindo a bibliografias.id_bibliografia
--
CREATE SEQUENCE seq_id_bibliografia
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.seq_id_bibliografia OWNER TO postgres;
ALTER SEQUENCE seq_id_bibliografia OWNED BY bibliografias.id_b;
ALTER TABLE ONLY bibliografias ALTER COLUMN id_b SET DEFAULT nextval('seq_id_bibliografia'::regclass);
SELECT pg_catalog.setval('seq_id_bibliografia', 0, false);






REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
