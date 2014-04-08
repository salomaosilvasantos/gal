--
-- PostgreSQL database bd_gal
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
DROP VIEW IF EXISTS quantidade_exemplares_view;
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
    isbn character varying,
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
SELECT pg_catalog.setval('seq_id_titulo', 0, true);


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
SELECT pg_catalog.setval('seq_id_exemplar', 0, true);


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
SELECT pg_catalog.setval('seq_id_curriculo', 0, true);




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
    id_disciplina integer NOT NULL,
    id_titulo integer NOT NULL,
    tipo_bibliografia character varying NOT NULL,
    PRIMARY KEY (id_disciplina,id_titulo,tipo_bibliografia)
);
ALTER TABLE public.bibliografias OWNER TO postgres;
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



-- Inserindo dados na tabela Disciplina.
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('BCC0001', 'INTRODUÇÃO A CIENCIA DA COMPUTACAO',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0001', 'FUNDAMENTOS DE PROGRAMAÇÃO',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0002', 'INTRODUÇÃO A CIÊNCIA DA COMPUTAÇÃO E SISTEMAS DE INFORMAÇÃO',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0003', 'MATEMÁTICA BÁSICA',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0004', 'TEORIA GERAL DA ADMINISTRAÇÃO',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0005', 'ARQUITETURA DE COMPUTADORES',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0006', 'CÁLCULO DIFERENCIAL E INTEGRAL I',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0007', 'PROGRAMAÇÃO ORIENTADA A OBJETOS',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0008', 'MATEMÁTICA DISCRETA',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0009', 'TEORIA GERAL DE SISTEMAS',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0010', 'ESTRUTURA DE DADOS',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0011', 'FUNDAMENTOS DE BANCO DE DADOS',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0012', 'PROBABILIDADE E ESTATÍSTICA',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0013', 'SISTEMAS OPERACIONAIS',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0014', 'ANÁLISE E PROJETO DE SISTEMAS',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0015', 'GESTÃO DA INFORMAÇÃO E DOS SISTEMAS DE INFORMAÇÃO',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0016', 'LINGUAGENS DE PROGRAMAÇÃO',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0017', 'LÓGICA PARA COMPUTAÇÃO',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0018', 'CONSTRUÇÃO DE SISTEMAS DE GERÊNCIA DE BANCO DE DADOS',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0019', 'ENGENHARIA DE SOFTWARE',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0020', 'DESENVOLVIMENTO DE SOFTWARE PARA WEB',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0021', 'REDES DE COMPUTADORES',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0022', 'AUDITORIA DE SEGURANÇA DE SISTEMAS DE INFORMAÇÃO',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0023', 'GERÊNCIA DE PROJETOS DE SOFTWARE',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0024', 'AVALIAÇÃO DE SISTEMAS',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0025', 'COMPILADORES',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0026', 'CONTABILIDADE E CUSTOS',50, 7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0027', 'E-BUSINESS',50,8);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0028', 'ECONOMIA E FINANÇAS',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0029', 'EMPREENDEDORISMO',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0030', 'ETICA,DIREITO E LEGISLAÇÃO',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0031', 'FILOSOFIA DA CIENCIA',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0032', 'FUNÇÕES EMPRESARIAIS',50,8);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0033', 'GERÊNCIA DE REDES',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0034', 'GERÊNCIA DE PROJETOS',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0035', 'INGLES INSTRUMENTAL I',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0036', 'INGLES INSTRUMENTAL II',50, 8);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0037', 'INTELIGÊNCIA ARTIFICIAL',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0038', 'INTERFACE HUMANO-COMPUTADOR',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0039', 'INTRODUÇÃO A COMPUTAÇÃO GRAFICA',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0040', 'LINGUAGENS FORMAIS E AUTOMATOS',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0041', 'PROJETO E ANALISE DE ALGORITMOS',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0042', 'QUALIDADE DE SOFTWARE',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0043', 'SISTEMAS DISTRIBUIDOS',50, 6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0044', 'SISTEMAS MULTIMIDIA',50, 7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0045', 'SOCIOLOGIA',50, 5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0046', 'TEORIA DA COMPUTAÇÃO',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0047', 'TOPICOS AVANÇADOS EM BANCO DE DADOS',50, 6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0048', 'TOPICOS AVANÇADOS EM REDES DE COMPUTADORES',50, 6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0049', 'TRABALHO COOPERATIVO BASEADO EM COMPUTADORES',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0050', 'TOPICOS ESPECIAIS I',50,9);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0051', 'TOPICOS ESPECIAIS II',50,9);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0052', 'TOPICOS ESPECIAIS III',50,9);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0053', 'TOPICOS ESPECIAIS IV',50,9);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0054', 'ETICA,NORMAS E POSTURA PROFISSIONAL',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0055', 'INTRODUÇÃO A COMPUTAÇÃO E ENGENHARIA DE SOFTWARE',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0056', 'MATEMÁTICA BÁSICA',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0057', 'INTRODUÇÃO A PROCESSO E REQUISITOS DE SOFTWARE',50,2);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0058', 'PROJETO DETALHADO DE SOFTWARE',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0059', 'REDES E SISTEMAS DISTRIBUÍDOS',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0060', 'PROCESSOS DE SOFTWARE',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0061', 'REQUISITOS DE SOFTWARE',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0062', 'MANUTENÇÃO DE SOFTWARE',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0063', 'VERIFICAÇÃO E VALIDAÇÃO',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0064', 'ARQUITETURA DE SOFTWARE',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0065', 'ESPECIFICAÇÃO FORMAL DE SOFTWARE',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0066', 'GERÊNCIA DE CONFIGURAÇÃO',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0067', 'LEITURA DE SOFTWARE',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0068', 'REUSO DE SOFTWARE',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0069', 'SEGURANÇA',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0074', 'DESENVOLVIMENTO DE SOFTWARE CONCORRENTE',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0075', 'REDES SOCIAIS',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0076', 'SISTEMAS MULTIAGENTES',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0081', 'INFORMATICA E ORGANIZAÇÃO DE COMPUTADORES',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0082', 'MATEMÁTICA COMPUTACIONAL',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0083', 'MÉTODOS E TÉCNICAS DE PESQUISA',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0084', 'ADMINISTRAÇÃO DE SISTEMAS OPERACIONAIS LINUX',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0085', 'ADMINISTRAÇÃO DE SISTEMAS OPERACIONAIS WINDOWS',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0086', 'INTERNET E ARQUITETURA TCP/IP',50,3);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0087', 'LABORATÓRIO EM INFRAESTRUTURA DE REDES DE COMPUTADORES',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0088', 'PROGRAMAÇÃO DE SCRIPT',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0089', 'REDES DE ALTA VELOCIDADE',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0090', 'REDES DE COMUNICAÇÕES MÓVEIS',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0091', 'SEGURANÇA DA INFORMAÇÃO',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0092', 'SERVIÇOS DE REDES DE COMPUTADORES',50,5);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0093', 'ANÁLISE DE DESEMPENHO DE REDES DE COMPUTADORES',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0094', 'GESTÃO DE TECNOLOGIA DA INFORMAÇÃO E COMUNICAÇÃO',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0095', 'PROJETO INTEGRADO EM REDES DE COMPUTADORES',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0096', 'PROJETO DE PESQUISA CIENTÍFICA E TECNOLÓGICA',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0099', 'DESENVOLVIMENTO DE SOFTWARE PARA PERSISTÊNCIA',50,6);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0102', 'DESENVOLVIMENTO DE SOFTWARE PARA DISPOSITIVOS MÓVEIS',50,8);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0103', 'ÉTICA, DIREITO E LEGISLAÇÃO',50,4);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0106', 'GOVERNANÇA ESTRATÉGICA DE TECNOLOGIA DA INFORMAÇÃO',50,9);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0107', 'PROGRAMAÇÃO LINEAR',50,9);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ('QXD0108', 'INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0109', 'PRÉ-CÁLCULO',50,1);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0110', 'PROJETO DE PESQUISA CIENTIFICA E TECNOLOGICA',50,7);
INSERT INTO disciplinas(
            cod_d, nome, qtd_alunos, semestre_oferta)
    VALUES ( 'QXD0113', 'LINGUA BRASILEIRA DE SINAIS - LIBRAS',50,9);
INSERT INTO disciplinas (cod_d, nome, qtd_alunos, semestre_oferta) VALUES ('6. Pré-Requisitos', 'ESTÁGIO I', 50, 8);
INSERT INTO disciplinas (cod_d, nome, qtd_alunos, semestre_oferta) VALUES ('QXD0071', 'INTEGRAÇÃO DE APLICAÇÕES', 50, 8);
INSERT INTO disciplinas (cod_d, nome, qtd_alunos, semestre_oferta) VALUES ('QXD0073', 'MÉTODOS E FERRAMENTAS DA ENGENHARIA DE SOFTWARE', 50, 8);
INSERT INTO disciplinas (cod_d, nome, qtd_alunos, semestre_oferta) VALUES ('QXD0070', 'ESTIMATIVA DE CUSTOS EM PROJETOS DE SOFTWARE', 50, 8);
INSERT INTO disciplinas (cod_d, nome, qtd_alunos, semestre_oferta) VALUES ('QXD0072', 'EXPERIMENTAÇÃO EM ENGENHARIA DE SOFTWARE', 50, 8);








-- Inserindo dados na tabela Titulos
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (13, '8573932759', 'KRUCHTEN, Philippe; FELLOW, Rational. Introdução ao RUP. rational unified process . Rio de Janeiro, RJ: Ciência Moderna, 2003. (Addison-Wesley object technology)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (14, '852160372X', 'GUIMARÃES, Ângelo de Moura; LAGES, Newton Alberto de Castilho. INTRODUÇÃO a ciencia da computacao. Rio de Janeiro: Livros Técnicos e Científicos, 1984. 165p. (Ciência da computação)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (15, '9788587918888', 'CAPRON, H. L. ; JOHNSON, J. A. INTRODUÇÃO à informatica. 8. ed. São Paulo: Prentice Hall, Pearson, 2004. 350 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (16, '9788535222067', 'TURBAN, Efraim. Introdução a sistemas de informação: uma abordagem GERÊNCIAl. Rio de Janeiro, RJ: Elsevier, 2007. xi, 364 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (17, '9788522104999', 'SIPSER, Michael. Introdução à teoria da computação. 2. ed. São Paulo, SP: Cengage Learning, 2011. xxi, 459 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (18, '978853523522-7', 'WAZLAWICK, Raul Sidnei. Metodologia de pesquisa para ciência da computação. Rio de Janeiro, RJ: Elsevier, 2008. 159 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (19, '8536302313', 'SCOTT, Kendall. O processo unificado explicado. Porto Alegre: Bookman, 2003. 160 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (20, '9788599593097', 'MORIMOTO, Carlos E. Redes, guia prático. Porto Alegre, RS: Sul Editores, 2009. 555 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (21, '97788599593196', 'MORIMOTO, Carlos E. Redes, guia prático. 2. ed. Porto Alegre, RS: Sul Editores, 2011. 573 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (22, '9783642112935', 'CHARRON-BOST, Bernadette; SCHIPER, André; PEDONE, Fernando. Replication: Theory and practice. Germany: Springer-Verlag Berlin Heidelberg, 2010. xv, 290p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (23, '9788577808243', 'DIVERIO, Tiarajú Asmuz. Teoria da computação: máquinas universais e computabilidade. 3. ed. Porto Alegre: Bookman, 2011. 288 p. (Livros didáticos. n. 5)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (24, '9788576691884', 'ATUALIZAÇÕES em informática 2008. Rio de Janeiro: Editora PUC-Rio, 2008. 272 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (25, '9783540440086', 'WEB services: concepts, architectures and applications. Berlin: Springer, 2004. xx, 354 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (27, '8536304944', 'PREECE, Jennifer; ROGERS, Yvonne; SHARP, Helen. Design de interação: além da interação homem-computador . Porto Alegre, RS: Bookman, 2005. xvi, 548 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (28, '8575021389', 'OLIVEIRA NETTO, Alvim Antônio de. IHC - Interação Humano Computador: modelagem e gerência de interfaces com o usuário : sistemas de informações . Florianópolis: Visual Books, 2004. xiii, 120 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (29, '9788575022603', 'OLIVEIRA NETTO, Alvim Antônio de. IHC e a engenharia pedagógica. Florianópolis: Visual Books, 2010. 216 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (30, '9788535234183', 'BARBOSA, Simone D. J. ; SILVA, Bruno Santana da. Interação humano-computador. Rio de Janeiro, RJ: Elsevier, 2010. 384 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (31, '9788575222034', 'ROGERS, Rick; LOMBARDO, John; MEDNIEKS, Zigurd R. ; MEIKE, Blake. Desenvolvimento de aplicações Android. São Paulo, SP: Novatec, 2009. xvi, 376 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (32, '9788577803101', 'WEBER, Raul Fernando. Fundamentos de arquitetura de computadores. 3. ed. Porto Alegre, RS: Bookman, 2008. 306 p. (Série Livros Didáticos 8)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (34, '8535211020', 'MENASCÉ, Daniel A. ; ALMEIDA, Virgilio A. F. Planejamento de capacidade para serviços na Web: métricas, modelos e métodos. Rio de Janeiro, RJ: Campus, 2002. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (35, '8586804576', 'PRESSMAN, Roger S. Engenharia de software. 6. ed. São Paulo: McGraw-Hill, 2006. 720 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (37, '9788522107971', 'STAIR, Ralph M. ; REYNOLDS, George Walter; SILVA, Flávio Soares Corrêa da. Princípios de sistemas de informação. São Paulo, SP: Cengage Learning, 2011. xvii, 590 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (38, '9780262026499', 'BAIER, Christel; KATOEN, Joost-Pieter. Principles of model checking. Cambridge, Massachusetts: The Mit Press, 2008. xvii, 975 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (39, '9780262032704', 'CLARKE, E. M. Model checking. Cambridge: MIT Press, 1999. xiv, 314 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (2, '8522440158', 'MARCONI, Marina de Andrade; LAKATOS, Eva Maria. Fundamentos de metodologia científica. 6. ed. São Paulo: Atlas, 2005. 315p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (4, '8576050471', 'CERVO, Amado Luiz. Metodologia científica. 6. ed. São Paulo, SP: Prentice Hall, 2007. 162 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (5, '9788573937701', 'ALECRIM, Paulo Dias de. Simulação computacional para redes de computadores. Rio de Janeiro, RJ: Ciência Moderna, 2009. xii, 253 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (6, '9788573936506', 'VIANA, Eliseu Ribeiro Cherene. Virtualização de servidores linux para redes corporativas: guia prático. Rio de Janeiro, RJ: Ciência Moderna, 2008. 230 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (7, '9788522448395', 'PASSOS, Eduardo José Pedreira Franco dos. Programação linear como instrumento da pesquisa operaciona: Eduardo José Pedreira Franco dos Passos. São Paulo, SP: Atlas, 2008. xii, 451p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (9, '857631164X', '(I: 2009, Brasília, Brasil). Artigos CONSEGI 2009: Congresso Internacional Software Livre e Governo Eletrônico. Rio de Janeiro, RJ: Fundação Alexandre de Gusmão, 2009. 172 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (10, '9780321117663', 'HASS, Anne Mette Jonassen. Configuration management: principles and practice. Boston, Massachusetts: Addison-Wesley, 2003. xlv, 370 p. (The Agile software development series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (12, '8535215360', 'VELLOSO, Fernando de Castro. Informática: conceitos básicos . 7. ed. rev. atual. Rio de Janeiro, RJ: Campus, 2004. xiii, 407p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (36, '9788578730871', 'MOREIRA NETO, Oziel. Entendendo e dominando o Java para a internet. 2. ed. São Paulo: Digerati Books, 2009. 318 + DVD', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (3, '9788522457588', 'MARCONI, Marina de Andrade; LAKATOS, Eva Maria. Fundamentos de metodologia científica. 7. ed. São Paulo, SP: Atlas, 2010. xvi, 297 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (50, '0132393085', 'COMER, Douglas. Automated network management sytems: current and future capabilities. New Jersey: Pearson/ Prentice Hall, 2007. xvi, 342 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (51, '9788535220179', 'COMER, Douglas. Interligação de redes com TCP/IP. 5. ed. rev. atual. Rio de Janeiro, RJ: Elsevier, 2006. v. 1', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (53, '8588745887', 'HALLBERG, Bruce A. Networking: redes de computadores: teoria e prática. Rio de Janeiro, RJ: Alta Books, 2003. xvi, 292 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (54, '9788576083542', 'LIMA JUNIOR, Almir Wirth. Rede de computadores: tecnologia e convergência das redes. Rio de Janeiro, RJ: Alta Books, 2009. xiii, 592 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (55, '8535211853ISBN10', 'TANENBAUM, Andrew S. Redes de computadores. Rio de Janeiro, RJ: Elsevier: Campus, 2003. xx, 945p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (56, '9788576059240', 'TANENBAUM, Andrew S. ; WETHERALL, D. Redes de computadores. São Paulo, SP: Pearson Prentice Hall, 2011. xvi, 582p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (57, '9788561893057', 'TORRES, Gabriel. Redes de computadores. Rio de Janeiro: Novaterra, 2009. xxiii, 805 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (60, '9788588639973', 'KUROSE, James F. ; ROSS, Keith W. Redes de computadores e a Internet: uma abordagem top-down. 5. ed. São Paulo: Pearson Addison Wesley, 2010. xxii, 614 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (61, '8588639181', 'KUROSE, James F. ; ROSS, Keith W. Redes de computadores e a Internet: uma abordagem top-down. 3. ed. São Paulo: Pearson/Addison Wesley, 2006. xx, 634 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (62, '9788560031368', 'COMER, Douglas. Redes de computadores e internet : abrange transmissão de dados, ligações inter-redes, web e aplicações. 4. ed. Porto Alegre: Bookman, 2007. 632 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (63, '8536501383', 'TRONCO, Tania Regina. Redes de nova geração: a arquitetura de convergência do IP, telefonia e redes ópticas . 1. ed. São Paulo, SP: Érica, 2006. 164 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (64, '9780201485349', 'STALLINGS, William. SNMP. SNMPv2, SNMPv3, RMON 1 and 2. 3rd. ed. New Jersey: Addison-Wesley, 2009. xv, 619 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (65, '0471433012', 'BLUM, Richard. Network perfomance: open source toolkit, using netperf, tcptrace, NIST Net, and SSFNet. Indianapolis: Wiley Publishing, 2003. xxiii, 405 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (66, '9788576081876', 'DONAHUE, Gary A. Redes robustas. Rio de Janeiro, RJ: Alta Books, 2008. xx, 502 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (67, '8535215913', 'FARREL, Adrian. A internet e seus protocolos: uma análise comparativa . Rio de Janeiro, RJ: Elsevier, 2005. xxvii, 572 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (68, '9780123705488', 'PETERSON, Larry L. ; DAVIE, Bruce S. Computer networks: a systems approach . 4th ed. Amsterdam; Boston, Massachusetts: Morgan Kaufmann, c2007. 806 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (69, '9780596008406', 'MAURO, Douglas R. ; SCHMIDT, Kevin J. Essential SNMP. 2nd ed. Sebastopol: O''Reilly, 2005. xv, 442p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (70, '9788536500270', 'GASPARINI, Anteu Fabiano L. Infra-estrutura, protocolos e sistemas operacionais de LANs: redes locias . 3. ed. São Paulo: Érica, 2007. 334 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (71, '8536304707', 'STEVENS, W. Richard. Programação de rede UNIX: API para soquetes de rede. 3. ed. São Paulo, SP: Bookman, 2005. v. 1', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (72, '8535209220', 'SCRIMGER, Rob. TCP/IP: a bíblia. Rio de Janeiro: Elsevier, 2002. xix, 642 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (73, '9788536502137', 'SOUSA, Lindeberg Barros de. TCP/IP & conectividade em redes: guia prático. 5. ed. rev. atual e ampl. São Paulo: Érica, 2009. 192 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (74, '9788576051893', 'ERL, Thomas. SOA: princípios de design de serviços. São Paulo, SP: Pearson Prentice Hall, 2009. x, 320 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (76, '9788586804885', 'FOROUZAN, Behrouz A. Comunicação de dados e redes de computadores. 4. ed. São Paulo, SP: McGraw-Hill, 2008. xxxiv, 1134 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (77, '9788536306148', 'FOROUZAN, Behrouz A. Comunicação de dados e redes de computadores. 3. ed. São Paulo, SP: McGraw-Hill, 2006. xi, 840 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (79, '9781430219422', 'VENNER, Jason. Pro Hadoop: build scalable, distributed applications in the cloud. New York, NY: Apress, 2009. xxvii, 407 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (80, '9788576083078', 'SCHRODER, Carla. Redes linux: livro de receitas. Rio de Janeiro, RJ: Alta Books, 2009. xxi, 566 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (42, '9788521615439', 'MONTEIRO, Mario A. Introdução à organização de computadores. 5. ed. Rio de Janeiro, RJ: LTC, 2007. xii, 696p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (43, '9780471503361', 'JAIN, Raj. The art of computer systems perfomance analysis: techniques for experimental design, measurement, simulation, and modeling . New York, NY: John Wiley & Sons, 1991. xxvii, 685 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (44, '9788576055648', 'STALLINGS, William; VIEIRA, Daniel. Arquitetura e organização de computadores. 8. ed. São Paulo: Pearson Prentice Hall, 2010. xiv, 624 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (45, '8587918532', 'STALLINGS, William. Arquitetura e organização de computadores: projeto para o desempenho. 5. ed. São Paulo, SP: Prentice Hall, 2006. xix, 786 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (47, '9788574524238', 'TAURION, Cezar. Cloud computing: computação em nuvem, transformando o mundo da Tecnologia da Informação. Rio de Janeiro, RJ: Brasport, 2009. 205 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (48, '9780470506387', 'JENNINGS, Roger. Cloud computing with the Windows Azure Platform. Indianapolis, Indiana: Wiley Pub. , 2009. xxvii, 331 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (49, '8560031498', 'COULOURIS, George F. ; DOLLIMORE, Jean; KINDBERG, Tim. Sistemas distribuídos: conceitos e projeto. 4. ed. Porto Alegre: Bookman, 2007. viii, 784p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (75, '9788576081845', 'JOSUTTIS, Nicolai M. SOA na prática: a arte da modelagem de sistemas distribuídos. Rio de Janeiro, RJ: Alta Books, 2008. xiv, 265 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (46, '9781935182481', 'HAY, Chris; PRINCE, Brian H. Azure in action. Stamford, Ct: Manning, 2011. xxx, 457 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (91, '857608267-5', 'MARTIN, Robert C. Código limpo: habilidades práticas do Agile Software . Rio de Janeiro: Alta Books, 2011. xxi, 413 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (93, '9788577808076', 'COHN, Mike; SILVA, Aldir José Coelho da. Desenvolvimento de software com scrum: aplicando métodos ágeis com sucesso . Porto Alegre: Bookman, 2011. xii, 496 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (94, '9788534602372', 'PRESSMAN, Roger S. Engenharia de software. São Paulo: Pearson/ Makron Books, 2009. xxxii, 1056 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (95, '9788588639287', 'SOMMERVILLE, Ian, |d 1951-. Engenharia de software. 8. ed. São Paulo, SP: Pearson/ Prentice Hall, 2007. xiv, 552 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (97, '9788521616504', 'PAULA FILHO, Wilson de Pádua. Engenharia de software: fundamentos, métodos e padrões . 3. ed. Rio de Janeiro, RJ: LTC, 2009. xiii, 1248 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (98, '9788587918314', 'PFLEEGER, Shari Lawrence. Engenharia de software: teoria e prática. 2. ed. São Paulo, SP: Pearson/ Prentice Hall, 2007. xix, 537 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (99, '9788563308337', 'PRESSMAN, Roger S. Engenharia de software: uma abordagem profissional . 7. ed. Porto Alegre: AMGH Ed. , 2011. xxvii, 779 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (100, '9788536304571', 'COCKBURN, Alistair. Escrevendo casos de uso eficazes: um guia prático para desenvolvedores de software . Porto Alegre: Bookman, 2005. viii, 254 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (101, '3540287132', 'GORTON, Ian. Essential software architecture. Berlin: Springer, 2006. xviii, 283 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (102, '9783642191756', 'GORTON, Ian. Essential software architecture. 2. ed. Berlin: Springer, 2011. xvi, 242 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (105, '9788586804960', 'JOYANES AGUILAR, Luis. Fundamentos de programação: algoritmos, estrutura de dados e objetos. São Paulo, SP: McGraw-Hill, 2008. xxix, 690 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (106, '9788535234190', 'FEIJÓ, Bruno; CLUA, Esteban; SILVA, Flávio Soares Corrêa da. Introdução à ciência da computação com jogos: aprendendo a programar com entretenimento . Rio de Janeiro: Elsevier, c2010. 263 p. (Série campus ; Sociedade Brasileira de Computação)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (107, '9788576050247', 'FORBELLONE, André Luiz Villar; EBERSPÄCHER, Henri Frederico. Lógica de programação: a construção de algoritmos e estruturas de dados . 3. ed. São Paulo: Makron, 2005. xii, 218 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (108, '9788577807000', 'HUNT, Andrew. O programador pragmático: de aprendiz a mestre. Porto Alegre, RS: Bookman, 2010. xvii, 343 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (109, '8576050676', 'TANENBAUM, Andrew S. Organização estruturada de computadores. 5. ed. São Paulo, SP: Prentice Hall, 2007. xii, 449 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (110, '8522105251', 'ZIVIANI, Nivio; BOTELHO, Fabiano Cupertino. Projeto de algoritmos: com implementações em java e C++. São Paulo, SP: Thomson Learning, 2007. vii, 620 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (111, '9780471684176', 'THAYER, Richard H. ; CHRISTENSEN, M. J. Software engineering. 3rd. ed. Hoboken, NJ: IEEE Computer Society, 2005. 2 v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (112, '9780471684183', 'THAYER, Richard H. ; DORFMAN, M. Software engineering. 3rd. ed. Hoboken, NJ: IEEE Computer Society, 2 v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (113, '9780471692089', 'BRAUDE, Eric J. ; BERNSTEIN, Michael E. Software engineering: modern approaches. 2nd ed. Hoboken, New Jersey: J. Wiley & Sons, 2011. xvi, 782 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (114, '9780735623989', 'WITHALL, Stephen. Software requirement patterns. Redmond, Wash. : Microsoft Press, c2007. xvi, 366 p. (Best practices)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (116, '9788577802814', 'SANTOS, Clesio Saraiva dos; AZEREDO, Paulo Alberto de; UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Tabelas: organização e pesquisa. Porto Alegre, RS: Sagra Luzzato, 2008. 85 p. (n 10)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (117, '9788576081746', 'FREEMAN, Eric; FREEMAN, Elisabeth; SIERRA, Kathy; BATES, But. Use a cabeça!: padrões e projetos. 2. ed. rev. Rio de Janeiro, RJ: Alta Books, 2007. xxiv, 478 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (118, '9788576081456', 'MCLAUGHLIN, Brett; POLLICE, Gary; WEST, David. Use a cabeça: análise e projeto orientado ao objeto. Rio de Janeiro, RJ: Alta Books, 2007. xxviii, 441 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (120, '9780321269317', 'SALMRE, Ivo. Writing mobile code: essential software engineering for building mobile applications. New Jersey: Addison-Wesley, 2005. xviii, 771p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (82, '9788577802623', 'PEZZÈ, Mauro; YOUNG, Michal. Teste e análise de software: processo, princípios e técnicas. Porto Alegre, RS: Bookman, 2008. x, 512 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (83, '9788576082125', 'PILONE, Dan; MILES, Russ. Use a cabeça: desenvolvimento de software. Rio de Janeiro, RJ: Alta Books, 2008. xxxiv, 378 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (84, '9788576083092', 'GREENE, Jennifer; STELLMAN, Andrew. Use a cabeça: PMP. Rio de Janeiro, RJ: Alta Books, 2008. xxx, 594 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (85, '0321295358', 'KLEINBERG, Jon; TARDOS, Éva. Algorithm design. Boston: Pearson/Addison Wesley, c2006. 838 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (86, '0471383651', 'GOODRICH, Michael T. ; TAMASSIA, Roberto. Algorithm design: foundations, analysis, and Internet examples . New York: John Wiley & Sons, 2002. xii, 708 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (88, '8535209263', 'CORMEN, Thomas H. Algoritmos: teoria e prática. Rio de Janeiro: Elsevier, 2002. xvii , 916 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (89, '857522073X', 'MEDINA, Marco; FERTIG, Cristina. Algoritmos e programação: teoria e prática. 2. ed. São Paulo, SP: Novatec, 2006. 384 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (90, '0735619670', 'MCCONNELL, Steve. Code Complete: um guia prático para a construção de software . 2. ed. Porto Alegre, RS: Bookman, 2005. xv, 928 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (119, '9780321205681', 'COHN, Mike. User stories applied: for agile software development . Boston: Addison-Wesley, 2004. 268 p. (Addison-Wesley signature series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (87, '9788577260324', 'DASGUPTA, Sanjoy; PAPADIMITRIOU, Christos H. ; VAZIRANI, Umesh. Algoritmos. São Paulo, SP: McGraw-Hill, 2009. xiv, 320 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (131, '8576050129', 'BARMES, David J. ; KÖLLING, Michael. Programação orientada a objetos com Java: uma introdução prática usando o BLUEJ. São Paulo, SP: Pearson/ Prentice Hall, 2007. xxviii, 368 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (133, '9788576082774', 'FERNANDEZ, Obie. Programando rails A biblia. Rio de Janeiro, RJ: Alta Books, 2008. xlviii, 671 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (134, '9788535217841', 'BOOCH, Grady; RUMBAUGH, James; JACOBSON, Ivar. UML: guia do usuário. 2. ed. rev. e atual. Rio de Janeiro, RJ: Elsevier, 2005. xviii, 474 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (135, '8536304545', 'FOWLER, Martin. UML essencial: um breve guia para a linguagem-padrão de modelagem de objetos . 3. ed. Porto Alegre: Bookman, 2005. 160 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (136, '9788575221938', 'GUEDES, Gilleanes T. A. UML 2: uma abordagem prática. São Paulo, SP: Novatec, 2009. 485 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (137, '0471463612', 'ERIKSSON, Hans-Erik; PENKER, Magnus; LYONS, Brian. UML 2 toolkit. Indianapolis, Indiana: Wiley Publishing, 2004. xxvii, 511 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (139, '9788574524061', 'SERSON, Roberto Rubinstein. A Bíblia: certificação JAVA 6. Rio de Janeiro: Brasport, 2009. 2v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (140, '8534614597', 'DEITEL, Harvey M. ; DEITEL, Paul J. ; NIETO, T. R. C#: como programar . São Paulo: Pearson Education do Brasil, 2003. xxix, 1153 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (141, '9788576081821', 'CASTELLANI, Marcelo Fontes. Certificação Sun Java Associado SCJA: exame CX-310-019 : guia de viagem para passar no exame. Rio de Janeiro, RJ: Alta Books, 2008. xxii, 152 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (142, '8536305398', 'HORSTMANN, Cay S. Conceitos de computação com o essencial C++. Porto Alegre: Bookman, 2005. 711 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (143, '8536301716', 'SEBESTA, Robert W. Conceitos de linguagens de programação. 5. ed. Porto Alegre: Bookman, 2003. ix, 638 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (144, '9788577807918', 'SEBESTA, Robert W. Conceitos de linguagens de programação. 9. ed. -. Porto Alegre, RS: Bookman, 2011. ix, 792 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (145, '8575220950', 'SÁ, Claudio Cesar de. Haskell: uma abordagem prática. São Paulo, SP: Novatec, 2006. 287 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (146, '8589579565', 'GONÇALVES, Enyo José Tavares; CARNEIRO, Domingos Sávio Silva. Linguagem de programação II. Fortaleza, CE: UECE, 2011. 97 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (148, '9788573936841', 'XAVIER, Fabrício S. V. PHP: do básico à orientação a objetos . Rio de Janeiro, RJ: Ciência Moderna, 2008. x, 234 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (149, '9788575222003', 'DALL´OGLIO, Pablo. PHP: programando com orientação a objetos. 2. ed. -. São Paulo, SP: Novatec, 2009. 574 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (150, '9788576081210', 'MONTGOMERY, Eduard. Programando com C: simples & prático. Rio de Janeiro, RJ: Alta Books, 2006. 157 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (151, '9780321573582', 'YAO, Paul. Programming. NET compact framework 3. 5: Paul Yao, David Durant. 2nd. ed. New Jersey: Addison-Wesley, 2010. xxxvii, 694 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (152, '8536303956', 'FOWLER, Martin, . Refatoração: aperfeiçoando o projeto de código existente. Porto Alegre, RS: Bookman, 2008. xiv, 365 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (153, '9788576022101', 'BEIGHLEY, Lynn. Use a cabeça SQL. Rio de Janeiro, RJ: Alta Books, 2008. xxxiv, 454 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (155, '9788577802661', 'MENEZES, Paulo Blauth. Linguagens formais e autômatos. 5. ed. Porto Alegre: Bookman, 2008. 215 p. (Livros didáticos ; n. 3 Série Livros Didáticos 3)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (156, '9788577807659', 'MENEZES, Paulo Blauth. Linguagens formais e autômatos. 6. ed. Porto Alegre: Bookman, 2011. 215 p. (Livros didáticos ; n. 3 Série Livros Didáticos ; 3)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (157, '9788575222119', 'POWERS, Shelley. Aprendendo JavaScript. São Paulo, SP: Novatec, 2010. 407 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (159, '8576050560', 'DEITEL, Harvey M. ; DEITEL, Paul J. C++: como programar. 5. ed. São Paulo, SP: Prentice Hall, 2006. 1163 p. + cd-rom', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (160, '8534605955', 'SCHILDT, Herbert; MAYER, Roberto Carlos. C completo e total. 3. ed. rev. atual . São Paulo: Pearson/ Makron Books, c1997. xx, 827 p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (161, '8575220551', 'DELAMARO, Márcio. Como construir um compilador utilizando ferramentas Java : Márcio Delamaro. -. São Paulo, SP: Novatec, 2004. 308 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (162, '9788576053576', 'HORSTMANN, Cay S. Core Java: volume I - fundamentos. 8. ed. São Paulo, SP: Pearson, 2009. xiii, 383 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (122, '9788577802449', 'KERIEVSKY, Joshua. Refatoração para padrões. Porto Alegre: Bookman, 2008. xviii, 400 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (124, '9788576052074', 'PUGA, Sandra; RISSETTI, Gerson. Lógica de programação e estruturas de dados: com aplicações em Java. São Paulo, SP: Pearson, 2009. xiv , 262 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (126, '8575220470', 'TELES, Vinícius Manhães. Extreme programming: aprenda como encantar seus usuários desenvolvendo software com agilidade e alta qualidade. São Paulo, SP: Novatec, 2006. 316 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (127, '8573076100', 'GAMMA, Erich. Padrões de projeto: soluções reutilizáveis de software orientado a objetos. Porto Alegre: Bookman, 2000. 364 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (128, '9788560031511', 'HORSTMANN, Cay S. Padrões e projeto orientados a objetos. 2. ed. Porto Alegre: Bookman, 2007. 423 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (129, '9788535216967', 'BEZERRA, Eduardo. Princípios de análise e projeto de sistemas com UML. 2. ed. rev. e atual. Rio de Janeiro: Elsevier: Campus, c2007. 369 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (130, '9788577808410', 'MARTIN, Robert C. ; MARTIN, Micah. Princípios, padrões e práticas ágeis em C#. Porto Alegre: Bookman, 2011. 735 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (158, '9788577800131', 'LUTZ, Mark; ASCHER, David. Aprendendo python. 2. ed. Porto Alegre: Bookman, 2008. 566 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (125, '8536304030', 'SHALLOWAY, Alan; TROTT, James. Explicando padrões de projeto: uma nova perspectiva em projeto orientado a objeto . Porto Alegre: Bookman, 2004. xix, 328 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (175, '1590592395', 'SEIBEL, Peter. Practical common lisp. Berkeley, Ca: Apress, 2005. xxv, 499 p. (The Expert’s voice in programming languages)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (176, '9780470563144', 'CIBRARO, Pablo. Professional WCF 4: Windows Communication Foundation with . NET 4. Indianapolis, Ind. : Wiley Publishing, 2010. xxvii, 451 p. (Guias Wrox profissional)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (177, '9788575221846', 'URUBATAN, Rodrigo. Ruby on rails: desenvolvimento fácil e rápido de aplicações Web. São Paulo, SP: Novatec, 2009. 285 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (179, '9788576085591', 'STELLMAN, Andrew; GREENE, Jennifer. Use a cabeça! C#: um guia de aprendizafem para a programação no mundo real com C# e . NET. 2. ed. Rio de Janeiro, RJ: Alta Books, 2011. 797p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (180, '9788576082118', 'STELLMAN, Andrew; GREENE, Jennifer. Use a cabeça! C#: um guia de aprendizagem para a programação no mundo real com C# e . NET. Rio de Janeiro, RJ: Alta Books, 2008. xxxvi, 618p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (181, '0596009208', 'SIERRA, Kathy; BATES, Bert. Use a cabeça! Java. 2. ed. Rio de Janeiro, RJ: Alta Books, 2007. xxvi, 470 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (183, '9788577807246', 'BECK, Kent. TDD desenvolvimento guiado por testes. Porto Alegre: Bookman, 2010. xiii, 240 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (184, '0646458418', 'REEKIE, John; MCADAM, Rohan. A software architecture primer. Sydney, Australia: Angophora Press, 2006. 179 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (185, '9780596521974', 'WHITE, Tom. Hadoop: the definitive guide. California: O´Reilly, 2009. xix, 501 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (186, '9812384251', 'GRUBB, Penny; TAKANG, Armstrong A. Software maintenance: concepts and practice. 2nd ed. New Jersey: World Scientfic, 2003. xix, 349 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (187, '9780470147078', 'APRIL, Alain; ABRAN, Alain, |. Software maintenance management: evaluation and continuous improvement. New Jersey: IEEE Computer Society, 2008. xx, 314 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (188, '9788575222447', 'LECHETA, Ricardo R. Google android: aprenda a criar aplicações para dispositivos móveis com o Android SDK. 2. ed. rev. ampl. São Paulo, SP: Novatec, 2010. 608 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (189, '9788573936742', 'GONÇALVES, Edson. Desenvolvendo aplicações Web com NetBeans IDE 6. Rio de Janeiro, RJ: Ciência Moderna, 2008. xix, 581 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (190, '9788576082941', 'BASHAM, Bryan; SIERRA, Kathy; BATES, Bert. Use a cabeça!: Servlets & JSP. 2. ed. Rio de Janeiro, RJ: Alta Books, 2008. xxxii, 879 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (191, '8576080850', 'BASHAM, Bryan. Use a cabeça!: Sevlets & JSP. Rio de Janeiro, RJ: Alta Books, 2004. xxi, 534 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (192, '8575022105', 'MOLINARI, Leonardo. Gerência de configuração: técnicas e práticas no desenvolvimento do software. Florianópolis: Visual Books, 2007. 208 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (193, '9788577807567', 'POPPENDIECK, Mary; POPPENDIECK, Thomas David. Implementando o desenvolvimento Lean de software: do conceito ao dinheiro. Porto Alegre, RS: Bookman, 2011. 279 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (194, '9788575221525', 'JARGAS, Aurélio Marinho. Shell script profissional. São Paulo, SP: Novatec, 2008. 480 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (195, '9780201774238', 'SMITH, Roderick W. Advanced linux networking. Boston, Massachusetts: Addison-Wesley, 2002. xviii, 752 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (196, '9780321447739', 'BUTOW, Eric. User interface design for mere mortals: a hands-on guide to user interface design software-independent approach. Boston, Massachusetts: Addison-Wesley, 2007. xxii, 286 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (197, '9788575022443', 'STATO FILHO, André. Linux: controle de redes. Florianópolis: Visual Books, 2009. 352 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (198, '978820332638', 'WILSON, Ed. Microsoft Windows PowerShell: step by step. Redmond, Wash. : Microsoft Press, 2007. xviii, 296 p. + 1 CD ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (199, '8575022202', 'VIGLIAZZI, Douglas. Redes locais com linux. 2. ed. Florianópolis: Visual Books, 2007. 160 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (200, '9788521615484', 'MACHADO, Francis B; MAIA, Luiz Paulo. Arquitetura de sistemas operacionais. 4. ed. Rio de Janeiro: LTC, 2007. 308 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (201, '9780596005955', 'ROBBINS, Arnold; BEEBE, Nelson H. F. Classic Shell Scripting. Sebastopol, Ca: c2005. xxii, 534 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (518, '9788580630534', 'BASTOS, Aderson et al. Base de conhecimento em teste de software. 3. ed. São Paulo: Martins Fontes, 2012. 263p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (164, '8534615225', 'MUCHOW, John W. Core J2ME: tecnologia & MIDP. São Paulo, SP: Pearson/ Makron Books, 2004. xiv, 588 p. (Java)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (165, '9788575221884', 'SCHMITZ, Daniel Pace. Desenvolvendo sistemas com Flex e PHP. São Paulo, SP: Novatec, 2009. 294 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (167, '9780757529740', 'CHEN, Yinong; TSAI, Wei-Tek. Introduction to programming languages: proggramming in C, C++, Scheme, Prolog, C#, and SOA. 2nd ed. xii, 383 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (168, '8576050196', 'DEITEL, Harvey M. ; DEITEL, Paul J. Java: como programar. 6. ed. São Paulo: Pearson/ Prentice Hall, 2006. xl, 1110 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (169, '8573077271', 'DEITEL, Harvey M. ; DEITEL, Paul J. Java: como programar. 3. ed. Porto Alegre, RS: Bookman, 2001. xxix, 1201 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (171, '9780321349606', 'GOETZ, Brian. Java concurrency in practice. xx, 403 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (172, '9788574523361', 'COSTA, Daniel Gouveia. Java em rede: programação distribuída na internet . Rio de Janeiro: Brasport, 2008. xv, 288p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (173, '9788574523699', 'COSTA, Daniel Gouveia. Java em rede: recursos avançados de programação. Rio de Janeiro: Brasport, 2008. xiii, 324', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (203, '9788573936476', 'CARDOSO, Paulo Roberto Sant''anna; SANTANA, Fabiano de; NAKANO, Vitor. Comandos Windows Server 2003: administração e suporte . Rio de Janeiro: Ciência Moderna, 2008. xxviii, 588 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (170, '9788576055631', 'DEITEL, Paul J. ; DEITEL, Harvey M. Java: como programar. 8. ed. São Paulo: Pearson Prentice Hall, 2010. xxix, 1144 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (214, '9788574523453', 'NEVES, Julio Cezar. Programação SHELL LINUX. 7. ed. Rio de Janeiro: Brasport, 2008. xxx, 450p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (215, '8576051109', 'BÄCK, Magnus. Servidor de e-mail Linux: guia de instalação, configuração e GERÊNCIAmento para pequenos escritórios. São Paulo, SP: Pearson Prentice Hall, 2007. xvii, 284p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (216, '9788577805211', 'OLIVEIRA, Rômulo Silva de; CARISSIMI, Alexandre da Silva; TOSCANI, Simão Sirineo; UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Sistemas operacionais. 4. ed. Porto Alegre: Bookman, 2010. 374 p. (Livros didáticos. 11)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (217, '9788577800575', 'TANENBAUM, Andrew S. ; WOODHULL, Albert S. Sistemas operacionais: projeto e implementação. 3. ed. x, 990 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (218, '9788587918574', 'TANENBAUM, Andrew S. Sistemas operacionais modernos. 2. ed. São Paulo, SP: Prentice Hall, 2003. xii, 695 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (219, '9788576052371', 'TANENBAUM, Andrew S. ; GONÇALVES, Ronaldo A. L. Sistemas operacionais modernos. 3. ed. São Paulo, SP: Prentice Hall, 2009, c2010. xvi, 653 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (220, '9788536305868', 'HOLME, Dan; THOMAS, Orin. Windows Server 2003: administração e manutenção do ambiente Microsoft : kit de treinamento. Porto Alegre: Bookman, 2006. 688 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (221, '9788571949805', 'THOMPSON, Marco Aurélio. Windows server 2003: administração de redes . 5. ed. São Paulo: Érica, 2009. 370 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (222, '9788561893040', 'BATTISTI, Júlio; SANTANA, Fabiano de. Windows Server 2008: guia de estudos completo : implementação, administração e certificado . Rio de Janeiro, RJ: Novaterra, 2009. xxx, 1751p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (223, '9788576051428', 'TANENBAUM, Andrew S. ; STEEN, Van Maarten; MARQUES, Arlete Simille. Sistemas distribuídos: princípios e paradigmas. 2. ed. São Paulo, SP: Prentice Hall, 2007. viii, 402 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (224, '9788522104222', 'LOUDEN, Kenneth C. Compiladores: princípios e práticas . São Paulo, SP: Cengage Learning, 2004. xiv, 569 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (225, '8522104220', 'LOUDEN, Kenneth C. Compiladores: princípios e práticas . São Paulo, SP: Thomson, c2004. xiv, 569 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (227, '9788574524344', 'COSTA, Daniel Gouveia. Administração de redes com scripts: Bash script, Python, VBscript. 2. ed. Rio de Janeiro, RJ: Brasport, 2010. 186 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (229, '0321200683', 'HOHPE, Gregor; WOOLF, Bobby. Enterprise integration patterns: designing, building, and deploying messaging solutions . Boston, Massachusetts: Addison-Wesley, c2004. xlix, 683 p. (The Addison-Wesley signature series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (230, '9788575221396', 'SILVA, Maurício Samy. Construindo sites com CSS e (X)HTML: sites controlados por folhas de estilo em cascata . São Paulo, SP: Novatec, 2008. 446p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (231, '9788576082713', 'KRUG, Steve. Não me faça pensar!: uma abordagem de bom senso à usabilidade na WEB. 2. ed. Rio de Janeiro, RJ: Alta Books, 2008. 201 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (232, '9788535221909', 'NIELSEN, Jakob, |. Usabilidade na web. Rio de Janeiro, RJ: Elsevier, 2007. xxiv, 406 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (233, '9780470383261', 'GOODRICH, Michael T. ; TAMASSIA, Roberto. Data structures and algorithms in Java. 5th ed. New York, NY: J. Wiley & Sons, 2010. xxii, 714 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (235, '139780072465631', 'RAMAKRISHNAN, Raghu. Database management systems. 3rd ed. Boston, Massachusetts: McGraw-Hill, 2003. xxxii, 1065 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (236, '9780132145374', 'KROENKE, David; AUER, David J. Database processing: fundamentals, design & implementation . 12. ed. Upper Saddle River, New Jersey: Pearson Prentice Hall, 2012. xvii, 612 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (237, '9788535211078', 'SILBERSCHATZ, Abraham; KORTH, Henry F. ; SUDARSHAN, S. Sistema de banco de dados. Rio de Janeiro, RJ: Elsevier, 2006. xiii, 781 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (238, '9788588639171', 'ELMASRI, Ramez; NAVATHE, Shamkant B. Sistemas de banco de dados. 4. ed. São Paulo, SP: Pearson/Addison Wesley, 2009. xi, 724 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (239, '9788536500126', 'MACHADO, Felipe Nery Rodrigues. Tecnologia e projeto de data warehouse: uma visão multidimensional. 5. ed. São Paulo, SP: Érica, 2010. 314 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (240, '9788577803828', 'HEUSER, Carlos Alberto. Projeto de banco de dados. 6. ed. Porto Alegre: Bookman, 2009. 282 p. (Livros Didáticos Informática ; 4)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (206, '9788577807680', 'MCLEAN, Ian; THOMAS, Orin. Configuração do windows 7: kit de treinamento MCTS - Exame 70-680. Porto Alegre, RS: Bookman, 2011. 919 p. + 1 DVD (Kit de treinamento Microsoft. )', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (207, '9788521617471', 'SILBERSCHATZ, Abraham; GALVIN, Peter B. ; GAGNE, Greg. Fundamentos de sistemas operacionais. 8. ed. Rio de Janeiro, RJ: LTC, 2010. xvii , 515 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (208, '9788577804832', 'MACKIN, J. C. ; DESAI, Anil. Kit de treinamento MCTS - Exame 70-643: configuração do Windows Server 2008 : infraestrutura de aplicativos. Porto Alegre, RS: Bookman, 2009. 695p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (210, '9788575221778', 'FERREIRA, Rubem E. Linux: guia do administrador do sistema. 2. ed. rev. e ampl. São Paulo, SP: Novatec, 2008. 716 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (211, '9788576051121', 'NEMETH, Evi; SNYDER, Garth; HEIN, Trent R. Manual completo do Linux: guia do administrador . São Paulo, SP: Pearson Education do Brasil, 2007. xiv, 684 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (226, '9788588639249', 'AHO, Alfred V. et al. (). Compiladores :: príncípios, técnicas e ferramentas. 2. ed. São Paulo, SP: Pearson/Addison Wesley, 2007. 634 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (234, '0201120372', 'MANBER, Udi. Introduction to algorithms: a creative approach . Reading: Addison-Wesley, c1989. xiv, 478 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (252, '9780470519462', 'WOOLDRIDGE, Michael J. An introduction to multiagent systems. 2nd ed. New York: J. Wiley & Sons, c2009. xxii, 461 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (253, '9788585490157', 'LÉVY, Pierre. As tecnologias da inteligência :: o futuro do pensamento na era da informática /. Rio de Janeiro: Editora 34, 2010. 206 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (254, '9788521617297', 'COPPIN, Ben. Inteligência artificial. Rio de Janeiro, RJ: LTC, 2010. xxv 636 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (255, '8535211772', 'RUSSELL, Stuart J. |q (Stuart Jonathan), |d 1962-; NORVIG, Peter, |d 1956-. Inteligência artificial. Rio de Janeiro: Elsevier, Campus, 2004. 1021 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (256, '9780521899437', 'SHOHAM, Yoav; LEYTON-BROWN, Kevin. Multiagent systems: algorithmic, game-theoretic, and logical foundations . New York, NY: Cambridge at the University Press, 2009. xx, 483 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (257, '9788573077186', 'HAYKIN, Simon S. Redes neurais: princípios e prática. 2. ed. Porto Alegre: Bookman, 2001. xvii, 900 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (258, '8535212523', 'AZEVEDO, Eduardo. ; CONCI, Aura. Computação gráfica: geração de imagens . Rio de Janeiro, RJ: Elsevier, Campus, 2003. 353 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (259, '9788521616290', 'AMMERAAL, L. ; ZHANG, Kang. Computação gráfica para programadores Java. 2. ed. Rio de Janeiro, RJ: LTC, 2008. viii, 217 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (261, '852440200-8', 'GOMES, Jonas de Miranda; VELHO, Luiz. Fundamentos da computação gráfica. Rio de Janeiro, RJ: IMPA, 2008 603 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (262, '9788573939507', 'RIBEIRO, Marcello Marinho; MENEZES, Marco Antonio Figueiredo. Uma breve introdução à computação gráfica. Rui De Janeiro, Rj: Ciência Moderna, 2010. v, 73 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (263, '9780071748469', 'VAUGHAN, Tay. Multimedia: making it work. New York, NY: McGraw-Hill, 2011. ix 465 p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (264, '9788521612223', 'PAULA FILHO, Wilson de Pádua. Multimídia: conceitos e aplicações. Rio de Janeiro: LTC, 2000. 321 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (265, '9783642078880', 'ALONSO, Gustavo. Web services: concepts, architectures and applications. Berlin: Springer, 2010. xx, 354 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (267, '850808935X', 'CHAUÍ, Marilena de Sousa. Convite à filosofia. 13. ed. São Paulo: Ática, 1999. 424p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (268, '9788508134694', 'CHAUÍ, Marilena de Sousa. Convite à filosofia /. 14. ed. São Paulo: Ática, 2011. 520 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (269, '9781575866321', 'BARKER-PLUMMER, Dave; BARWISE, Jon; ETCHEMENDY, John. Language, proof and logic. New York, NY: CSLI, 2011. xiii 606 p. (CSLI lecture notes ; v 23)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (270, '9788531405754', 'MASIERO, Paulo Cesar. Ética em construção. São Paulo, SP: EDUSP, 2008. 213 p. (Acadêmica ;32)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (271, '9788521617761', 'BARGER, Robert N. Ética na computação: uma abordagem baseada em casos. Rio de Janeiro, RJ: LTC, 2011. xiv, 226 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (272, '9788577806553', 'YIN, Robert K. Estudo de caso: planejamento e métodos . 4. ed. Porto Alegre, RS: Bookman, 2010. xviii, 248 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (273, '8536304626', 'YIN, Robert K. Estudo de caso: planejamento e métodos. 3. ed. Porto Alegre: Bookman, 2005. 212 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (274, '9788573028638', 'FRIEDMAN, Thomas L. O mundo é plano: uma breve história do século XXI. Rio de Janeiro, RJ: Objetiva, 2007. 557 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (276, '8572821295', 'CARLEIAL, Adelita Neto; BRAGA, Elza Maria Franco. América Latina: transformações econômicas e políticas. Fortaleza: Ed. UFC, 2003. 291 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (277, '8525036706', 'UCHOA, Pablo. A encruzilhada de Hugo Chávez. São Paulo, SP: Globo, 2003. 294 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (279, '8522438129', 'ROSSETTI, José Paschoal. Introdução a economia: livro de exercícios. 4. ed. São Paulo, SP: Atlas, 2004. 387 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (280, '8522104247', 'BRUE, Stanley L. História do pensamento econômico. São Paulo: Thomson Learning, 2006. 553p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (281, '8522434670', 'ROSSETTI, José Paschoal. Introdução à economia. 20. ed. São Paulo: Atlas, 2003. 922 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (242, '139780131587564', 'PERSISTENCE in the enterprise: a guide to persistence technologies . Boston: Pearson Education, Inc. , 2008. xxxii, 430 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (243, '9781441988331', 'OZSU, M. Tamer. Principles of distributed database systems. 3nd. ed. New York: Springer, 2011. 666p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (244, '9788577260270', 'RAMAKRISHNAN, Raghu; GEHRKE, Johannes. Sistemas de GERÊNCIAmento de banco de dados. São Paulo, SP: McGraw-Hill, 2008. xxvii, 884 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (245, '9788576082989', 'COAR, Ken A. L. Apache: guia prático. Rio de Janeiro, RJ: Alta Books, 2009. xvii, 250 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (247, '8536304294', 'CHESWICK, William R. ; BELLOVIN, Steven M; RUBIN, Aviel D. Firewalls e segurança na Internet: repelindo o hacker ardiloso . 2. ed. Porto Alegre, RS: Bookman, 2005. 400 p. (Ciência da Computação/Redes)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (249, '9788575221365', 'NAKAMURA, Emilio Tissato; GEUS, Paulo Lício de. Segurança de redes em ambientes cooperativos. São Paulo: Novatec, c2007. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (250, '9788578730529', 'ULBRICH, Henrique Cesar; DELLA VALLE, James. Universidade H4CK3R: desvende todos os segredos do submundo dos hackers . 6. ed. São Paulo: Digerati Books, 2009. 348p. + DVD (Série Universidade)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (251, '9788576051190', 'STALLINGS, William. Criptografia e segurança de redes: princípios e práticas. 4. ed. São Paulo: Pearson/ Prentice Hall, 2008. xvii, 492 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (278, '9788535230062', 'GONÇALVES, Carlos Eduardo S. Gonçalves; GUIMARÃES, Bernardo. Economia sem truques: o mundo a partir das escolhas de cada um . 5. ed. Rio de Janeiro, RJ: Campus, 2008. 209 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (248, '9781590597842', 'DASWANI, Neil; KERN, Christoph; KESAVAN, Anita. Foundations of security: what every programmer needs to know . Berkeley, Ca: Apress, c2007. xxvii, 290 p. (The Expert’s voice in security)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (295, '9788560031993', 'HAYKIN, Simon S. Sistemas modernos de comunicações wireless. Porto Alegre: Bookman, 2008. x, 579 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (296, '9788533623323', 'LEVINSON, Stephen C. Pragmática. São Paulo: Martins Fontes, 2007. xiv, 548 p. ;', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (297, '8587214470', 'LONGMAN gramática escolar da língua inglesa: gramática de referências com exercícios e respostas . São Paulo, SP: Longman, 2004. 317 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (298, '9781405025263', 'MACMILLAN English dictionary for advanced learners. 2nd. ed. Oxford: MacMillan Education, 2007. xi, 1748 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (299, '052143680X', 'MURPHY, Raymond. English grammar in use: a self-study reference and practice book for intermediate students. 3rd. ed. Cambridge: Cambridge University Press, 2007. x, 379 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (300, '9788527409742', 'GALLO, Lígia Razerra. Inglês instrumental para informática: módulo I. São Paulo, SP: Ícone, 2008. 170 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (301, '97885752211226', 'MARINOTTO, Demóstene. Reading on info tech: inglês para informática. 2. ed. São Paulo, SP: Novatec, 2007. 176 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (302, '9788526275393', 'DE NICOLA, Jose. Língua, literatura e produção de textos: José de Nicola. São Paulo, SP: Scipione, 2009. 3 v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (303, '9788535711738', 'CEREJA, William Roberto. Português: linguagens. 3. ed. São Paulo, SP: Atual Ed. , 2009. 576 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (304, '9788535709988', 'CEREJA, William Roberto. Gramática: texto, reflexão e uso. 3. ed. reform. São Paulo, SP: Atual Ed. , 2008. 495 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (305, '8533619758', 'FERREIRA, Reinaldo Mathias. Lições de português: para nunca mais esquecer. São Paulo, SP: Martins Fontes, 2004. viii, 159 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (306, '9788586368394', 'KURY, Adriano da Gama. Para falar e escrever melhor o português
. Rio de Janeiro, RJ: Lexikon, 2008. 275 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (308, '9788537800218', 'AZEREDO, José Carlos de. Ensino de português: fundamentos, percursos, objetos. Rio de Janeiro, RJ: Jorge Zahar, 2007. 214 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (309, '9788571107458', 'OLIVA, Alberto. Filosofia da ciência. 2. ed. Rio de Janeiro, RJ: J. Zahar, 2008. 74 p. (Passo-a-passo ; v. 31)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (312, '9788521618102', 'HUNTER, David J. Fundamentos da matemática discreta. Rio de Janeiro, RJ: LTC, 2011. x 235 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (313, '8570562705', 'IEZZI, Gelson; MURAKAMI, Carlos. Fundamentos de matemática elementar: 1 : conjuntos, funções . 8. ed. , . São Paulo, SP: Atual, 2004. 374 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (315, '8535704566', 'IEZZI, Gelson; DOLCE, Osvaldo; MURAKAMI, Carlos. Fundamentos de matemática elementar: 2 : logaritmos . 9. ed. São Paulo, SP: Atual, 2004. 198 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (316, '853704582', 'IEZZI, Gelson; HAZZAN, Samuel. Fundamentos de matemática elementar: 4 : seqüências, matrizes, determinantes, sistemas . 7. ed. São Paulo, SP: Atual, 2004. 232 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (317, '8535705465', 'IEZZI, Gelson. Fundamentos de matemática elementar: 7 : geometria analítica . 5. ed. São Paulo, SP: Atual, 2005. 282 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (318, '8535705473', 'IEZZI, Gelson; MURAKAMI, Carlos; MACHADO, Nílson José. Fundamentos de matemática elementar: 8 : limites, derivadas, noções de integral . 6. ed. São Paulo, SP: Atual, 2005. 263 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (319, '8535704612', 'HAZZAN, Samuel. Fundamentos de matemática elementar, 5: combinatória, probabilidade : 43 exercícios resolvidos, 439 exercícios propostos com resposta, 155 testes de vestibulares com resposta. 7. ed. São Paulo, SP: Atual, 2004. 184 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (321, '9788522107964', 'SCHEINERMAN, Edward R. Matemática discreta: uma introdução . São Paulo: Cengage Learning, 2011. xxiii, 573 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (285, '9788522445936', 'PAESANI, Liliana Minardi. O direito na sociedade da informação. São Paulo, SP: Atlas, 2007. xxx, 333 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (286, '9788522455072', 'ALMEIDA, Guilherme Assis de; CHRISTMANN, Martha Ochsenhofer. Ética e direito: uma perspectiva integrada . 3. ed. São Paulo: Atlas, 2009. 171 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (287, '8573484632', 'LIMBERGER, Têmis. O direito à intimidade na era da informática: a necessidade de proteção dos dados pessoais. Porto Alegre, RS: Livraria do Advogado, 2007. 250 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (288, '8588813297', 'CARBONI, Guilherme C. O direito de autor na multímidia: Guilherme C. Carboni. São Paulo, SP: Quartier Latin, 2003. 208 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (289, '9781558609327', 'BRACHMAN, Ronald J. ; LEVESQUE, Hector J. Knowledge representation and reasoning. San Francisco [California, Estados Unidos]: Elsevier, 2004. xxix, 381 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (290, '8521904274', 'FREIRE, Paulo. Extensão ou comunicação. 13. ed. Rio de Janeiro: Paz e Terra, 2006. 93 p. ; (O Mundo Hoje ;24. )', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (292, '9788572823883', 'EPISTEMOLOGIAS e metodologias para avaliação educacional:. múltiplas visões e abordagens. Fortaleza, CE: Edições UFC, 2010. 252 p. (Nave , 8)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (293, '8530801172', 'KAMII, Constance; DECLARK, Georgia. Reinventando a aritmética: implicações da teoria de Piaget . 4. ed. Campinas, SP: Papirus, 1992. 308 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (310, '9788515019694', 'ALVES, Rubem. Filosofia da ciência:: introdução ao jogo e a suas regras. 15. ed. São Paulo, SP: Loyola, 2010. 223 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (322, '9788577260362', 'ROSEN, Kenneth H. Matemática discreta e suas aplicações. 6. ed. São Paulo, SP: McGraw-Hill, 2009. xxi, 982 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (291, '9788572822855', 'HISTÓRIA da educação:. arquivos, documentos, historiografia, narrativas orais e outros rastros. Fortaleza, CE: Edições UFC, 2008. 176 p. (Diálogos intempestivos ; 58)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (334, '8524401087', 'GONCALVES, Adilson. Introdução à álgebra. 5. ed. Rio de Janeiro, RJ: IMPA, 2005. 194 p. (Projeto Euclides)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (335, '9788588639379', 'DEMANA, Franklin D. Pré-cálculo. São Paulo: Addison-Wesley, 2009. xv, 380 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (336, '9780321356932', 'DEMANA, Franklin D. Precalculus graphical, numerical, algebraic: media update. 7th. ed. Boston: Addison-Wesley, 2010. xxiv, 1032 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (337, '8529400941', 'LEITHOLD, Louis; PATARRA, Cyro de Carvalho. O Cálculo com geometria analítica. 3. ed. São Paulo: Harbra, c1994. 2 v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (339, '8531406773', 'MAGALHÃES, Marcos Nascimento. Noções de probabilidade e estatística. 6. ed. rev. São Paulo: Editora da Universidade de São Paulo, 2005. xv, 392 p. (Acadêmica ; 40)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (340, '9788531406775', 'MAGALHÃES, Marcos Nascimento. Noções de probabilidade e estatística. 7. ed. rev. São Paulo, SP: Editora da Universidade de São Paulo, 2010. xv, 408 p. (Acadêmica ; 40)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (341, '9788576051992', 'WALPOLE, Ronald E. Probabilidade e estatística: para engenharia e ciências. 8. ed. São Paulo, SP: Pearson/ Prentice Hall, 2009. xiv, 491 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (343, '0262150417', 'OSBORNE, Martin J; RUBINSTEIN, Ariel. A course in game theory. London, England: Mit Press, 1998. 352 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (344, '9788535215205', 'GOLDBARG, Marco Cesar. Otimização combinatória e programação linear: modelos e algoritmos. Rio de Janeiro: Elsevier: Campus, 2005. xvi, 518 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (345, '8524106913', 'MENEZES, Paulo Blauth; UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Matemática discreta para computação e informática. 2. ed. Porto Alegre: Sagra Luzzato, 2005. 258p (Livros didáticos. 16)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (346, '9780471734406', 'GILAT, Amos; SUBRAMANIAM, Vish. Numerical methods for engineers and scientists: an introduction with applications using MATLAB . Massachusetts, [Estados Unidos]: J. Wiley & Sons, 2008. xx, 459 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (347, '9788587918567', 'HANSELMAN, Duane C. ; LITTLEFIELD, Bruce. Matlab 6: curso completo. São Paulo, SP: Pearson Prentice Hall, 2007. xvi , 676 p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (348, '9788576053729', 'LARSON, Ron; FARBER, Betsy. Estatística aplicada. 4. ed. São Paulo, SP: Pearson/ Prentice Hall, 2010. 637 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (349, '9788587918598', 'LARSON, Ron; FARBER, Betsy. Estatística aplicada. 2. ed. São Paulo, SP: Pearson/ Prentice Hall, c2004. 476 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (350, '9788522459940', 'BARBETTA, Pedro Alberto; REIS, Marcelo Menezes; BORNIA, Antonio Cezar. Estatística para cursos de engenharia e informática. 3. ed. São Paulo, SP: Atlas, 2010. 410 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (352, '9788521615866', 'TRIOLA, Mario F. Introdução à estatística. 10. ed. Rio de Janeiro, RJ: LTC, 2008. 686 p. + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (353, '8529400925', 'STEVENSON, William J. Estatística aplicada à administração. São Paulo: Harbra, c1981. 495p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (356, '9788535711868', 'FERRARO, Nicolau Gilberto. Física básica. 3. ed. São Paulo, SP: Atual, 2009. 720 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (357, '9788573935707', 'COUTO, Ana Brasil. CMMI: integração dos modelos de capacitação e maturidade de sistemas. Rio de Janeiro: Ciência Moderna, 2007. xvi, 276 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (358, '9780470099254', 'HARPER, Brian D. ; MERIAM, J. L; KRAIGE, L. G. Solving statics problems in MATLAB: engineering mechanics: statics. 6th ed. Massachusetts, [Estados Unidos]: J. Wiley & Sons, 2007. 139 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (359, '9788576051985', 'RAPPAPORT, Theodore S. Comunicações sem fio: principios e práticas. 2. ed. São Paulo, SP: Pearson/ Prentice Hall, 2009. 409 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (360, '85346154039', 'LEE, Valentino. Aplicações móveis: arquitetura, projeto e desenvolvimento. São Paulo, SP: Pearson Makron Books, 2005. xx, 328 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (361, '8574522147', 'FIORESE, Virgílio. Wireless: introdução às redes de telecomunicação móveis celulares . Rio de Janeiro: Brasport, 2005. xv, 343 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (324, '3540219439', 'MAJEWSKI, M. MuPAD Pro computing essentials. 2nd. ed. Berlin: Springer-Verlag, 2004. xi, 538 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (325, '9788502102033', 'SMOLE, Kátia Cristina Stocco; DINIZ, Maria Ignez de Souza Vieira. Matemática: ensino médio. São Paulo, SP: Saraiva, 2010. 3 v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (328, '8535210725', 'HOPCROFT, John E. Introdução à teoria de autômatos, linguagens e computação. Rio de Janeiro: Elsevier, 2002. 560 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (329, '9780321455369', 'HOPCROFT, John E. ; MOTWANI, Rajeev. Introduction to automata theory, languages, and computation. Boston: Pearson Addison Wesley, c2007. xvii, 535 p. (Addison-Wesley series in computer science. )', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (330, '9788535229615', 'SOUZA, João Nunes de. Lógica para ciência da computação: uma introdução concisa. 2. ed. rev. e atual. Rio de Janeiro: Elsevier, 2008. 220 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (331, '8522105170', 'SILVA, Flávio Soares Corrêa da; FINGER, Marcelo; MELO, Ana Cristina Vieira de. Lógica para computação. São Paulo, SP: Thomson Learning, 2006. 234 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (332, '9780521527149', 'BLACKBURN, Patrick; RIJKE, Maarten de; VENEMA, Yde. Modal logic. Cambridge: Cambridge Univ. Press, c2001. xxii, 554 p. (Cambridge tracts in theoretical computer science ; 53)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (333, '0201530821', 'PAPADIMITRIOU, Christos H. Computational complexity. Reading, Massachusetts [Estados Unidos]: Addison-Wesley, c1994. xv, 523 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (354, '0471283665', 'WOLSEY, Laurence A. Integer programming. New York, NY: John Wiley & Sons, 1998. 264 p. (Wiley-Interscience series in discrete mathematics and optimization)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (326, '0122384520', 'ENDERTON, Herbert B. A mathematical introduction to logic. 2nd ed. San Diego, California: Harcourt/Academic Press, c2001. xii, 317 p. ;', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (373, '8560334009', 'CARVALHO, Isamir Machado de. Gestão do conhecimento: uma estratégia empresarial. Brasília, DF: J. J. Gráfica e Comunicações, 2006. 346 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (374, '8522413630', 'SILVA, Adelphino Teixeira da. Organizacao e tecnica comercial. 20. ed. rev. e atual. Sao Paulo: Atlas, 1996. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (375, '9788577803460', 'HISRICH, RobertoD. Empreendedorismo. 7. ed. PortoAlegre, RS:Bookman, 2009. 662p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (377, '9788522436934', 'ARAÚJO, Luís César G. de. Teoria geral da administração: aplicações e resultados nas empresas brasileiras. São Paulo, SP: Atlas, 2004. 291 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (378, '9788522460250', 'ARAÚJO, Luís César G. de; GARCIA, Adriana Amadeu. Teoria geral da administração: orientação para escolha de um caminho profissional. São Paulo: Atlas, 2010. 305 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (379, '9788536301174', 'COOPER, Donald R. ; SCHINDLER, Pamela S. Métodos de pesquisa em administração. 7. ed. Porto Alegre: Bookman, 2008. ix, 640 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (380, '8574521914', 'FREITAS, Rogério Afonso de. Portais corporativos: uma ferramenta estratégica para a gestão do conhecimento. Rio de Janeiro, RJ: Brasport, 2004. xviii, 104 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (381, '8535215719', 'TURBAN, Efraim; RAINER, R. Kelly; POTTER, Richard E. Administração de tecnologia da informação. Rio de Janeiro, RJ: Elsevier, Campus, 2005. xvii, 618 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (383, '8534607958', 'WESTON, J. Fred; BRIGHAM, Eugene F. Fundamentos da administração financeira. São Paulo, SP: Pearson Makron Books, 2004. xxxi, 1030 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (384, '8522426066', 'ROSS, Stephen A; WESTERFIELD, Randolph; JORDAN, Bradford D. Princípios de administração financeira. 2. ed. São Paulo, SP: Atlas, 2000. 523p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (386, '9788522456932', 'PADOVEZE, Clóvis Luís. Sistemas de informações contábeis: fundamentos e análise. 6. ed. São Paulo, SP: Atlas, 2009. xvi, 331p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (387, '9788522449118', 'PADOVEZE, Clóvis Luís. Sistemas de informações contábeis: fundamentos e análise. 5. ed. São Paulo: Atlas, 2007. xvi, 331 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (388, '9788522461370', 'FERRONATO, Airto João. Gestão contábil-financeira de micro e pequenas empresas: sobrevivência e sustentabilidade . São Paulo: Atlas, 2011. 247 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (389, '852241422X', 'WELSCH, Glenn A. Orçamento empresarial. 4. ed. São Paulo: Atlas, 1983. 397 p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (390, '9788522451487', 'BRUNI, Adriano Leal; FAMÁ, Rubens. Gestão de custos e formação de preços: com aplicações na calculadora HP 12C e excel. 5. ed. São Paulo, SP: Atlas, 2008. 569 p. (Série Finanças na Prática)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (391, '8573123664', 'LIMONGI-FRANCA, Ana Cristina. As pessoas na organização. São Paulo, SP: Editora Gente, 2002. 306 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (392, '8572821872', 'ESTUDOS empíricos em gestão de recursos humanos e marketing. Fortaleza, CE: Edições UFC, 2005. 385 p. (Estudos Contemporâneos em Administração ; 1)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (393, '9788572822305', 'LIMA, Marcos Antonio Martins; MACIEL, Terezinha de Jesus Pinheiro. Avaliação, gestão e estratégias educacionais: projetos e processos inovadores em organizações. Fortaleza, CE: Edições UFC, 2008. 334 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (394, '978-85-7393-603-2', 'ARAÚJO FILHO, Geraldo Ferreira de. Empreendedorismo criativo: a nova dimensão da empregabilidade . Rio de Janeiro: Ciência Moderna, 2007. 558 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (395, '9788522454174', 'ANDRADE, Adriana; ROSSETTI, José Paschoal. Governança corporativa: fundamentos, desenvolvimento e tendências. 4. ed. São Paulo, SP: Atlas, 2009. 584p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (396, '9788522448524', 'ANDRADE, Adriana; ROSSETTI, José Paschoal. Governança corporativa: fundamentos, desenvolvimento e tendências . 3. ed. , atual. e ampl. São Paulo: Atlas, 2007. 584p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (397, '9788522462711', 'ROSSETTI, José Paschoal; ANDRADE, Adriana. Governança corporativa: fundamentos, desenvolvimento e tendências . 5. ed. atual. e ampl. São Paulo: Atlas, 2011. 596 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (398, '9780136107293', 'DECISION support and business intelligence systems. 9th. ed. New Jersey: Prentice Hall, 2011. xxii, 696 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (399, '0131986600', 'DECISION support and business intelligence systems. 8th. ed. New Jersey: Prentice Hall, 2007. xxviii, 772 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (364, '8587062360', 'DUQUE, José Guimarães. O Nordeste e as lavouras xerófilas. 4. ed. Fortaleza, CE: Banco do Nordeste do Brasil, 2004. 329 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (365, '9788576058082', 'HONG, Yuh Ching. ; MARQUES, Fernando. Contabilidade & finanças para não especialistas. 3. ed. São Paulo, SP: Pearson, 2010. vii, 337 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (366, '9788522462872', 'IUDICIBUS, Sérgio de; MARION, José Carlos. Curso de contabilidade para não contadores: para as áreas de administração, economia, direito e engenharia . 7. ed. São Paulo, SP: Atlas, 2011. 274 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (367, '8522430780', 'MOSCOVE, Stephen A. ; SIMKIN, Mark G. ; BAGRANOFF, Nancy A. Sistemas de informações contábeis. São Paulo, SP: Atlas, 2002. 451 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (368, '8522425353', 'LEONE, George Sebastiao Guerra. Custos: planejamento, implantação e controle . 3. ed. São Paulo, SP: Atlas, 2000. 518 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (369, '9788522450022', 'IMONIANA, Joshua Onome. Auditoria de sistemas de informação. 2. ed. São Paulo: Atlas, 2008. 207 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (372, '9788576800927', 'WEILL, Peter; ROSS, Jeanne W. Conhecimento em TI: o que os executivos precisam saber para conduzirem com sucesso TI em suas empresas . São Paulo: M. Books do Brasil, 2010. 162 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (363, '9788535213041', 'PINHEIRO, José Maurício S. Guia completo de cabeamento de redes. Rio de Janeiro, RJ: Elsevier, 2003. xviii, 239p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (370, '8576050261', 'CARAVANTES, Geraldo Ronchetti. ; PANNO, Cláudia Caravantes. ; KLOECKNER, Mônica Caravantes. Administração: teorias e processo. São Paulo, SP: Prentice Hall, 2005. 572p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (411, '9788502054424', 'FONTES, Edison Luiz Gonçalves. Segurança da informação: o usuário faz a diferença. São Paulo, SP: Saraiva, 2006. 172 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (412, '9788522440856', 'BEAL, Adriana. Segurança da informação: princípios e melhores práticas para a proteção dos ativos de informação nas organizações. São Paulo, SP: Atlas, 2008. xii, 175 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (414, '9788536303413', 'TURBAN, Efraim. Tecnologia da informação para gestão: transformando os negócios na economia digital. 3. ed. Porto Alegre: Artmed, 2004. xiv, 660 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (415, '9788577805082', 'TURBAN, Efraim. Tecnologia da informação para gestão: transformando os negócios na economia digital. 6. ed. Porto Alegre: Bookman, 2010. xiii, 680 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (416, '9788522461226', 'REZENDE, Denis Alcides. Planejamento de sistemas de informação e informática: guia prático para planejar a tecnologia da informação integrada ao planejamento estratégico das organizações. 4. ed. São Paulo, SP: Atlas, 2011. 179 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (417, '9788576059233', 'LAUDON, Kenneth C. ; LAUDON, Jane Price. Sistemas de informação GERÊNCIAis. 9. ed. São Paulo, SP: Pearson Education do Brasil, 2011. xxviii, 428 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (418, '9788576050896', 'LAUDON, Kenneth C. ; LAUDON, Jane Price. Sistemas de informação GERÊNCIAis. 7. ed. São Paulo: Prentice Hall, 2007. xxi, 452 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (419, '9788522450039', 'REZENDE, Denis Alcides; Abreu. Tecnologia da informação aplicada a sistemas de informação empresariais: o papel estratégico da informação e dos sistemas de informação nas empresas. 5. ed. rev. e amp. São Paulo, SP: Atlas, 2008. 303 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (420, '852621733X', 'MALORY, Thomas Sir. O Rei Artur e os cavaleiros da Tavola Redonda. 12. ed. São Paulo, SP: Scipione, 2001. 80 p. (Série Reencontro)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (422, '852243493X', 'SOUZA, Cesar Alexandre de. ; SACCOL, Amarolinda Zanela. Sistemas ERP no Brasil: (enterprise resource planning); teoria e casos. São Paulo, SP: Atlas, 2003. 368p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (423, '9788574523237', 'DINSMORE, Paul C. ; CABANIS-BREWIN, Jeannette. AMA: manual de GERÊNCIAmento de projetos. Rio de Janeiro, RJ: Brasport, 2009. xxii, 498p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (424, '9788574523750', 'VARGAS, Ricardo Viana. Análise de valor agregado em projetos: revolucionando o GERÊNCIAmento de custos e prazos . 4. ed. Rio de Janeiro: Brasport, 2008. xviii, 107p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (425, '8573035579', 'DINSMORE, Paul Campbell; BARBOSA, Adriane Monteiro Cavalieri. Como se tornar um profissional em GERÊNCIAmento de projetos: livro base de preparação para certificação PMP - Project Management Professional. 2. ed. Rio de Janeiro: Qualitymark, 2007. xxxvi, 342 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (426, '9788573039788', 'DINSMORE, Paul Campbell; BARBOSA, Adriane Monteiro Cavalieri. Como se tornar um profissional em GERÊNCIAmento de projetos: livro-base de "Preparação para certificação PMP® - Project management professional". 4. ed. , rev. e ampl. Rio de Janeiro: Qualitimark, 2011. xxiv, 383p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (427, '9788535211832', 'PHILLIPS, Joseph. Gerência de projetos de tecnologia da informação: no caminho certo, do início ao fim. Rio de Janeiro, RJ: Elsevier, 2003. xviii, 449 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (429, '9781933890517', 'A GUIDE to the project management body of knowledge (PMBOK GUIDE). 4rd. ed. Newtown Square, Pa: Project Management Institute, c2008. xxvi, 467 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (430, '9788522106080', 'FARAH, Osvaldo Elias. Empreendedorismo estratégico. São Paulo: Cengage Learning, 2008. 251 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (431, '9788502067448', 'CHIAVENATO, Idalberto. Empreendedorismo: dando asas ao espírito empreendedor: empreendedorismo e viabilização de novas empresas, um guia eficiente para iniciar e tocar seu próprio negócio. 3. ed. rev. e atual. São Paulo, SP: Saraiva, 2008. xiv, 281 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (432, '9788576352600', 'JUSTUS, Roberto. O empreendedor: como se tornar um líder de sucesso. São Paulo, SP: Larousse do Brasil, 2007. 127 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (433, '9788535232707', 'DORNELAS, Jose Carlos Assis. Empreendedorismo: transformando idéiais em negócios . 3. ed. rev. atual. Rio de Janeiro: Elsevier, 2008. 232 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (401, '9788535234176', 'FERRARI, Roberto. Empreendedorismo para computação: criando negócios em tecnologia. Rio de Janeiro, RJ: Elsevier, 2010. 164 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (402, '8522443955', 'BALLESTERO-ALVAREZ, María Esmeralda. Manual de organização, sistemas e métodos: abordagem teorica e prática da engenharia da informação. 3. ed. São Paulo, SP: Atlas, 2006. 329p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (403, '9788563308030', 'Hillier Frrederick S. INTRODUÇÃO a pesquisa operacional. 8. ed. Porto Alegre, RS: Bookman, 2010. 852p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (405, '9788535238990', 'MCAFEE, Andrew. Empresas 2. 0: a força das mídias colaborativas para superar grandes desafios empresariais. Rio de Janeiro, RJ: Elsevier, 2010. 216 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (407, '9788573079784', 'PROBST, Gilbert; RAUB, Steffen; ROMHARDT, Kai. Gestão do conhecimento: os elementos construtivos do sucesso. Porto Alegre: Bookman, 2002. vii, 286 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (409, '852204816', 'STAIR, Ralph M. ; REYNOLDS, George Walter. Princípios de sistemas de informação: uma abordagem GERÊNCIAl . São paulo: Cengage Learning, 2008. xxvi, 646 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (410, '8522104816', 'STAIR, Ralph M. ; REYNOLDS, George Walter. Princípios de sistemas de informação: uma abordagem GERÊNCIAl . São Paulo: Cengage Learning, 2009. xxvi, 646 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (428, '9788576084983', 'GREENE, Jennifer; STELLMAN, Andrew. Use a cabeça! PMP. Rio de Janeiro: Alta Books, 2010. xxxv, 794 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (404, '8573034505', 'MEDEIROS, Elizabet M. Spohr de; SAUVÉ, Jácques Philippe. Avaliação do impacto de tecnologias da informação emergentes nas empresas. Rio de Janeiro, RJ: Qualitymark, 2003. 178 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (445, '0130323640', 'DEITEL, Harvey M. ; DEITEL, Paul J. ; STEINBUHLER, K. E-business & e-commerce for managers. New Jersey: Prentice Hall, 2001. xxxvii, 794 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (446, '8534613737', 'DEITEL, Harvey M. ; DEITEL, Paul J. ; STEINBUHLER, K. E-business e e-commerce para administradores. São Paulo: Makron Books, 2004. xxii, 456 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (448, '9788522106387', 'BERTOMEU, João Vicente Cegato. Criação visual e multimídia. São Paulo, SP: Cengage Learning, 2010. 149 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (450, '9788574163871', 'WILLIAMS, Robin. Design para quem nao é designer: noções básicas de planejamento visual . 3. ed. São Paulo, SP: Callis, 2009. 191 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (451, '9788532305305', 'MOLETTA, Alex. Criação de curta-metragem em vídeo digital: uma proposta para produções de baixo custo. São Paulo, SP: Summus, 2009. 142 p. ((Biblioteca fundamental de cinema) ; 3)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (452, '8526214527', 'HAGGARD, H. Rider. As minas do Rei Salomão. 10. ed. São Paulo, SP: Scipione, 2000. 99 p. (Série Reencontro)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (453, '9789875665910', 'KEYES, Marian. Bajo el edredón. Buenos Aires, Argentina: DeBOLS!LLO, 2010. 414 p. (Coleção Best Seller)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (454, '8526211978', 'ROSTAND, Edmond, . Cyrano de Bergerac. 12. ed. São Paulo: Scipione Autores Editores, 1987. 88 p. (Série Reencontro Série Reencontro)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (455, '0689867220', 'HOPKINS, Cathy. Mates, dates and mad mistakes. New York, NY: Simon Pulse, 2004. 209 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (456, '8586796980', 'COLBERT, David. O mundo mágico de Harry Potter: mitos, lendas e histórias fascinantes. Rio de Janeiro, RJ: Sextante, 2001. 183 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (457, '0679801146', 'PIERCE, Tamora. Alanna: the first adventure. New York, NY: Random House, 1983. . 216 p. (Song of the lioness ; 1)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (458, '0763619582', 'MACKLER, Carolyn. The earth, my butt, and other big, round things. Cambridge, Massachusetts: Candlewick Press, 2003. 246 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (459, '0590476998', 'RUBY, Lois. Skin Deep. New York: Scholastic, 1994. 280p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (460, '0471138231', 'EPSTEIN, Richard G. The case of the killer robot: stories about the professional, ethical, and societal dimensions of computing. New York, NY: John Wiley & Sons, 1997. x, 242 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (461, '8526237284', 'SHAKESPEARE, William, . A megera domada. São Paulo, SP: Scipione, 2000. 120 p. (Coleção L & PM Pocket. v. 95 Série Reencontro)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (462, '0521664772', 'SCOTT-MALDEN, Sarah. A Picture to remember. 1st ed. Cambridge, UK: Cambridge University Press, 1999. 48 p. (Cambridge english readers ; level 2. )', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (463, '0194230678', 'DICKENS, Charles. Great expectations. 2. ed. Oxford [England]: Oxford University Press, 2000. 104 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (464, '0-521-65607-9', 'MALEY, Alan. He Knows too much. Austrália: Cambridge University Press, 1999. 112 p. (Cambridge english readers ; 6)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (465, '9788501053213', 'FIELDING, Helen. O diário de Bridget Jones. 25. ed. Rio de Janeiro, RJ: Record, 2007. 319p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (466, '9780140292817', 'KEYES, Marian. Sushi for beginners. England: Penguin Books, 2001. 563 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (467, '9788525419132', 'CHRISTIE, Agatha. testemunha ocular do crime. Porto Alegre, RS: L & PM, 2009. 254p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (469, '8525410349', 'FLEMING, Ian. Viva e deixe morrer. Porto Alegre, RS: L&PM, 1999. 326 p. (L&PM Pocket ; 193)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (470, '8500217588', 'CERVANTES SAAVEDRA, Miguel de. Dom Quixote. 22. ed. Rio de Janeiro, RJ: Ediouro, 2005. 186 p. (Coleção Clássicos para o jovem leitor)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (471, '8572821287', 'VIANA, Carlos Augusto. Drummond: a insone arquitetura. Fortaleza: Ed. UFC, 2003. 167p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (472, '8536800844', 'ALVES, Castro. Espumas flutuantes. São Paulo, SP: DCL, 2005. 95 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (473, '8536800801', 'GONZAGA, Tomás Antônio. Marília de Dirceu. São Paulo: DCL, 2005. 119 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (435, '9788575423387', 'DOLABELA, Fernando. O segredo de Luísa: uma idéia, uma paixão e um plano de negócios: como nasce o empreendedor e se cria uma empresa . Rio de Janeiro: Sextante, 2008. 299 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (436, '8535201772', 'NONAKA, Ikujiro; TAKEUCHI, Hirotaka. Criação de conhecimento na empresa 
: como as empresas japonesas geram a dinâmica da inovação . 19. ed. Rio de Janeiro: Campus; Elsevier, 1997. 358p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (437, '8573590963', 'CARUSO, Carlos A. A. ; STEFFEN, Flávio Deny. Segurança em informática e de informações. 3. ed. rev. ampl. São Paulo: SENAC, 2006. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (438, '9788574523460', 'FERNANDES, Aguinaldo Aragon; ABREU, Vladimir Ferraz de. Implantando a governança de TI: da estratégia à gestão de processos e serviços . 2. ed. rev. ampl. Rio de Janeiro, RJ: Brasport, 2008. xxviii, 444 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (439, '9788520427422', 'CHIAVENATO, Idalberto. Planejamento e controle da produção. 2. ed. , rev. , atual. São Paulo: Manole, 2008. 138 p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (440, '8521614004', 'MONTGOMERY, Douglas C. Introdução ao controle estatístico da qualidade. 4. ed. Rio de Janeiro: Livros Técnicos e Científicos, c2004. 513 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (441, '9788522456178', 'DIAS, Marco Aurélio P. Administração de materiais: princípios, conceitos e gestão. 6. ed. São Paulo, SP: Atlas, 2010. 346p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (444, '8573078758', 'KALAKOTA, Ravi; ROBINSON, Marcia. e-business: estratégias para alcançar o sucesso no mundo digital. 2. ed. Porto Alegre, RS: Bookman, 2002. 470p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (468, '0435272705', 'GALSWORTHY, John. The man of property. Oxford [England]: Macmillan Heinemann, 1995. 95 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (442, '8587918095', 'TURBAN, Efraim; KING, David R. Comércio eletrônico: estratégia e gestão . São Paulo: Prentice Hall, 2004. xvii, 436 . p :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (505, NULL, 'SOMMERVILLE, I. Engenharia de software. 7.ed. SãoPaulo: Pearson Addison-Wesley, 2007', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (506, NULL, 'INTERNATIONAL Network for Social Network Analysis. Disponível em: <http://www.insna.org.>. Acesso em: 23 jan. 2013', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (507, NULL, 'VASCONCELOS, Davi Romero de; HAEUSLER, Edward Hermann. PONTIFÍCIA UNIVERSIDADE CATÓLICA DO RIO DE JANEIRO Departamento de Informática. Lógica modal de primeira-ordem para racionar sobre jogos. 2007. 241f. Tese(DoutoradoemInformática)-Pontifícia Universidade Católica do Rio de Janeiro, Rio de Janeiro, 2007', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (486, '8536800895', 'MACEDO, Joaquim Manuel de. A Moreninha. São Paulo, SP: DCL, 2005. 96 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (487, '8536800860', 'ASSIS, Machado de. Dom Casmurro. São Paulo: DCL, 2005. 120 p. (Serie Bom Livro Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (489, '8536800828', 'ALENCAR, José de. Iracema: lenda do Ceará. São Paulo: DCL, 2005. 71 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (490, '853680081X', 'ALENCAR, José de. Lucíola. Fortaleza: DCL, 2005. 88 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (492, '8536800763', 'POMPÉIA, Raul. O Ateneu. São Paulo, SP: DCL, 2005. 223 p. (Coleção Nossa Literatura Clássica Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (493, '8536800739', 'AZEVEDO, Aluísio. O Cortiço. São Paulo, SP: DCL, 2008. 136 p. (Coleção Nossa Literatura Clássica Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (494, '8536800720', 'ALENCAR, José de. Senhora. São Paulo: DCL, 2005. 144 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (495, '8572821406', 'CAMPOS, Natércia Maria Alcides. A casa. Fortaleza, CE: Ed. UFC, 2004. 89 p. (Coleção Literatura no Vestibular ; 2)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (496, '8536800747', 'BARRETO, Lima. Os Bruzundangas. Fortaleza: DCL, 2005. 88 p. (Coleção Literatura no Vestibular ; 1 Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (497, '8536800712', 'HERCULANO, Alexandre. Eurico, o presbítero. São Paulo, SP: DCL, 2005. 96 p. (O Monasticon ; v. 1 Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (498, '0471314250', 'CHRISMAN, Nicholas. Exploring geographic information systems. 2nd. ed. New York, NY: John Wiley, 2002. xvi, 289 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (499, '9781589482609', 'ORMSBY, Tim. Getting to know ArcGIS desktop. 2nd. ed. , atualizado para ArcGis 10. Redlands, Calif. : ESRI Press, 2010. xii, 584 p. + CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (500, '8508067712', 'POLIZZI, Valéria Piassa. Depois daquela viagem: diário de bordo de uma jovem que aprendeu a viver com AIDS. 18. ed. São Paulo, SP: Ática, 1999. 279 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (502, '9788574851464', 'MAIA, Michelle Ferreira. Lembrança de alguém: a construção das memórias sobre a santidade de João das Pedras. Fortaleza, CE: Imprensa Universitária - UFC, 2010. 262 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (503, '9788574851457', 'GOMES, José Eudes Arrais Barroso. Um escandaloso theatro de horrores: a capitania do Ceará sob o espectro da violência. Fortaleza, CE: Imprensa Universitária - UFC, 2010. 283 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (504, '9780735623583', 'WIGLEY, Andy; MOTH, Daniel; FOOT, Peter. Microsoft mobile development handbook. Redmond, Wash. : Microsoft Press, 2007. xxix, 651 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (508, '9788563899156', 'FOWLER, F. J. Pesquisa de Levantamento. PortoAlegre:Pearson, 2011', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (509, '0321826620', 'FOWLER, M. NoSQL Distilled: a brief guide to the emerging world of poliglot persistence. SãoPaulo:Prentice-Hall, 2012', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (510, '9788577806812', 'MENEZES, Paulo Blauth; UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Matemática discreta para computação e informática. 3. ed. PortoAlegre, RS:Bookman, 2010. 350p(Livrosdidáticos. 16)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (511, '9788521304036', 'ALENCARFILHO, E. Iniciação à lógica matemática. 21. ed. SãoPaulo:Nobel, 2008. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (512, '9788507006480', 'ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. ABNT NBR ISO/IEC 27002 - Tecnologia da informação - técnicas de segurança - código de prática para a gestão da segurança da informação. RiodeJaneiro, RJ, 2005. 120p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (513, '3212935332011', 'AMBLER, ScottW. ;SADALAGE, PramondJ. Refactoring databases: evolutionary database design. NewJ ersey: Addison-Wesley, 2011. 350p. (The Addison Wesley signature series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (514, '9780321712479', 'APPELO, J. Management3. 0:Leading agile developers, developing agile leaders. NewYork: Addison Wesley, 2010. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (515, '0321417461', 'BRATKO, Ivan. Prolog programming for artificial intelligence. 4. ed. Wokingham: Addison-Wesley, 2011. (International computer science series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (516, '0452284392', 'BARABASI, Albert-Laszlo. Linked: how everything is connected to everything else and what it means for business, science, and everyday life. New York, :Plume Book, 2003. 294p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (517, '0321154959', 'BASS, Len; CLEMENTS, Paul; KAZMAN, Rick. Software architecture in practice. 2. ed. Boston: Addison-Wesley, 2003. 528p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (476, '8536800887', 'AZEVEDO, Aluísio. Casa de pensão. São Paulo, SP: DCL, 2005. 175 p. (Serie Bom Livro Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (477, '8536800836', 'TAUNAY, Alfredo d''Escragnolle Taunay Visconde de, . Inocência. São Paulo: DCL, 2005. 104 p. (Serie Bom Livro Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (478, '8586375942', 'ALMEIDA, Manuel Antônio de. Memórias de um sargento de milícias. Fortaleza: DCL, 2001. 120 p. (Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (479, '8572821686', 'MONTE, Airton. Moça com flor na boca: crônicas escolhidas. Fortaleza: Ed. UFC, 2005. 130 p. (Coleção Literatura no Vestibular ; 4)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (480, '8536800771', 'AZEVEDO, Álvares de. Noite na taverna e Macário : Álvares de Azevedo . São Paulo, SP: DCL, 2005. 80 p. (Biblioteca de literatura brasileira)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (481, '8587791052', 'VIANCO, André. Os sete. São Paulo, SP: Novo Século, 2001. 380 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (483, '9788525409683', 'ASSIS, Machado de. Contos fluminenses. São Paulo, SP: DCL, 2005. 219p. (Coleção L&PM Pocket ; 151)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (484, '8587653334', 'ALENCAR, José de. Luciola. Fortaleza: ABC, 2002. 152p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (482, '8536800704', 'BARRETO, Lima. Triste fim de Policarpo Quaresma. São Paulo, SP: DCL, 2005. 119 p. (Bom livro Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (529, '9780321336385', 'DUVALL, PaulM. Continuous integration: improving software quality and reducing risk. Boston, MA: Addison-Wesley, 2007. 283p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (530, '8522430357', 'SILVA, Sebastiao Medeiros da; SILVA, Elio Medeiros da; SILVA, Ermes Medeiros da. Matemática básica para cursos superiores. São Paulo: Atlas, 2002. 227p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (531, '0471398195', 'MILI, Hafedh. Reuse-based software engineering: techniques, organization and measurement. New York: Wiley, 2002. 636p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (532, '9788575222386', 'LUCKOW, Décio Heinzelmann; MELO, Alexandre Altair. Programação Java para a web. São Paulo: Novatec Editora, 2010. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (533, '9788576086420', 'GEARY, David; HORSTMANN, Cay. Core Java Server Faces. 3. ed. Rio de Janeiro, RJ: AltaBooks, 2012', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (534, '020117782X', 'ZAHRAN, Sami. Software process improvement: practical guide lines for business success. Reading: Addison-Wesley, 1998447p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (535, '9780470093559', 'MAGEE, J. ;KRAMER, J. Concurrency: state models and Java programs. Michigan:Wiley, 2006. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (536, '1558603484', 'LYNCH, Nancy A. Distributed algorithms. San Francisco: Morgan Kaufmann, 1996. 872p. (The morgan kaufmann series in data management systems). ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (537, '0201633469', 'STEVENS, W. Richard. TCP/IP illustrated: v. 1. Reading, Mass.: Addison-Wesley, 1994. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (540, '9780071483001', 'JONES, Capers. Estimating softwarecosts: bringing realism to estimating. 2. ed. New York: Mc Graw-Hill, 2007. 644p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (541, '9780071717915', 'HILL, P. Practical Software Project Estimation: a toolkit for estimating software development effort & duration. New York: McGraw-Hill Osborne Media, 2011. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (542, '9780735605350', 'MCCONNELL, Steve. Software estimation: demystifying the black art. Redmond, Wa.: MicrosoftPress, 2006. 308p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (543, '9788535232493', 'FEOFILOFF, Paulo. . Algoritmos em linguagem C. Rio de Janeiro: Elsevier, 2009. 208p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (544, '8575220241', 'OLIVEIRA, CelsoH. Poderosode. SQL: curso prático. São Paulo:Novatec, 2002. 272p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (545, '857001841X', 'RUMBAUGH, James. Modelagem e projetos baseados em objetos. Rio de Janeiro: Campus, 2006. 652p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (546, '0136291554', 'MEYER, Bertrand. Object-oriented software construction. 2nd. ed. New Jersey: Prentice Hall PTR, 1997. 1254p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (547, '9781412947152', 'PRELL, Christina. Social network analysis: history, theory and methodology. California: Sage Publications Ltd, 2011. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (548, '9788535246698', 'PIMENTEL, M. ;FURKS, Hugo. Sistemas Colaborativos. Rio de Janeiro: Elsevier-Campus-SBC, 2011. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (549, '9780471678359', 'MYERS, Glenford J. The Art of software testing. New York: J. Wiley, 2004. 177p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (550, '0321419499', 'ROBERTSON, Suzanne; ROBERTSON, James. Mastering the requirements process. 2. ed. Upper Saddle River, NJ: Addison-Wesley, 2006. 560p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (552, '9788536503622', 'MACHADO, Felipe Nery Rodrigues. Análise e gestão de requisitos de software: onde nascem os sistemas. São Paulo: Érica, 2011. 286p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (555, '9788574524511', 'MARTINS, José Carlos Cordeiro. Gerenciando projetos de desenvolvimento de software com PMI, RUP E UML. 5. ed. Rio de Janeiro: Brasport, 2010. 290p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (556, '8576082675', 'MARTIN, Robert C. Código limpo: habilidades práticas do Agile Software. Rio de Janeiro: Alta Books, 2011. 413p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (557, '0131177052', 'FEATHERS, Michael C. Working effectively with legacy code. Upper Saddle River, NJ: Prentice Hall, 2005. 434p. (Robert C. Martin series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (558, '9780321166074', 'SPINELLIS, Diomidis. Code Quality: the open source perspective. Boston: Addison-Wesley, 2006. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (559, '9788535243970', 'VELLOSO, Fernando de Castro. Informática: conceitos básicos. 8. ed. rev. atual. Rio de Janeiro, RJ: Campus, 2011. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (560, '9780137012893', 'GEARY, David M; HORSTMANN, Cay S. Core Java Server Faces. 3. ed. Boston: Prentice Hall, 2010. 636p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (561, '0137288743', 'WATT, David Anthony; FINDLAY, William; HUGHES, John. Programming language: concepts and paradigms. New York: Prentice Hall, 1990. 322p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (562, '9788521616108', 'HUTH, Michael; RYAN, Mark. Lógica em ciência da computação: modelagem e argumentação sobre sistemas. 2. ed. Rio de Janeiro: LTC, 2008. 322p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (564, '9780321601919', 'HUMBLE, Jez. ; FARLEY, David. Continuous delivery: reliable software releases through build, test, and deployment automation. Upper Saddle River, NJ: Addison-Wesley, 2011. 463p. (Addison-Wesley Signature Series. )', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (565, '0470856629', 'VÖLTER, Markus; KIRCHER, Michael;ZDUN, Uwe. Remoting patterns foundations of enterprise, internet and real time distributed object middleware. Chichester:John Wiley, 2005. 389p. (Wiley series in software design patterns)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (520, '8535205624', 'BOOCH, Grady; RUMBAUGH, James; JACOBSON, Ivar. UML: guia do usuário. 2. ed. Rio de Janeiro, RJ: Campus, 2005. 474p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (521, '0471958697', 'BUSCHMANN, Franketal. Pattern-oriented software architecture: volume4: a system of patterns. New York: John Wiley & Sons, 1996. 457p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (522, '9780131479415', 'COHN, Mike; HIGHSMITH, Jim. . Agile estimating and planning. Upper Saddle River, NJ: Prentice Hall PTR, 2006. 330p. (Robert C. Martin series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (523, '1591392705', 'CROSS, RobertL. ;PARKER, Andrew. The hidden power of social networks: understanding how work really gets done in organizations. Boston: Harvard Business School, 2004. 213p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (524, '9780470542200', 'CROSS, RobertL. ; SINGER et al. The organizational network field book: best practices, techniques and exercises to drive organizational innovation and performance. New York: John Wiley, 2010. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (525, '9781580537919', 'COPELAND, Lee. A practitioners guide to software test design. Boston, Mass. ; London: Artech House, 2004. 294p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (527, '852210295', 'DROZDEK, Adam. Estrutura de dados e algoritmos em C++. São Paulo: Thomson, 2002. 579p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (528, '8535212736', 'DATE, C. J. Introdução a sistemas de banco de dados. 8. ed. Rio de Janeiro: Elsevier, 2004. 865p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (526, '3540208798', 'DALEN, D. van. Logic and structure. 4. ed. Berlin: Springer-Verlag, 2004. 263p. (Universitext)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (567, NULL, 'ALMEIDA, Eduardo Santana de et al. C.R.U.I.S.E: Component Reuse in Software Engineering. Recife: Gráfica Dom Bosco, 2007. Disponível em: <http://cruise.cesar.org.br/index.html> Acesso em: 14 set. 2008', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (568, NULL, 'ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. ABNT NBR ISO/IEC 27001-Tecnologia da informação - técnicas de segurança-sistemas de gestão de segurança da informação-requisitos. Rio de Janeiro,RJ,2006.34p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (569, NULL, 'AIELLO, R.; SACHS, L. Configuration management best practices: practical methods that work in the real world. Upper Saddle River, NJ: Addison-Wesley, 2011. 229p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (570, NULL, 'ABRAN, Alain (Ed.).Guide to the software engineering body of knowledge: trial version. Washington: Computer society, 2001. 205p. Disponível em: <http://www.computer.org/portal/web/swebok>. Acesso em: 23 jan. 2013', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (571, NULL, 'BEN-ARI. Principles of concurrent and distributed programming. 2. ed. SãoPaulo: Prentice-Hall, 2006', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (572, NULL, 'CHRISSIS, Mary Beth; KONRAD, Mike; SHRUM, Sandy. CMMI for Development®: guidelines for process integration and product improvement. 3. ed. Upper Saddle River:Addison-Wesley,2011', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (573, NULL, 'CLEMENTS, Paul et al. Documenting software architectures: views and beyond. 2. ed. Massachusetts: Addison-Wesley Professional. 2010. 592p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (574, NULL, 'DELGADO, José; RIBEIRO, Carlos. Arquitetura de computadores. 4. ed. rev. atual. Lisboa: FCA, 2010', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (575, NULL, 'KANG, K. C.; SUGUMARAN, V.;PARK, S. Applied software product line engineering. Boca Raton, Florida: CRC Press,2010', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (576, NULL, 'EZRAN, M. ; MORISIO, M. ; TULLY, C. Practical software reuse. Berlim: Springer, 200', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (577, NULL, 'POHL, K.; BÖCKLE, G.; LINDEN, F. J. Software product line engineering: foundations, principles and techniques. Berlim: Springer, 2005', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (578, NULL, 'GUIA MPS-BR: Melhoria do processo de software brasileiro. Disponível em:<http://www.softex.br/mpsbr/_home/default.asp>. Acesso em: 23 jan. 2013', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (579, NULL, 'FIPA. Especificações FIPA. Disponível em: <http://www.fipa.org>. Acesso em: 24 jan. 2013', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (580, NULL, 'EVANS, Eric. Domain-driven design: atacando as complexidades no coração do software. Rio de Janeiro, RJ: Alta Books, 2009. 499p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (581, NULL, 'MEIRA, Silvio R. L. et al. The Emerging Web of Social Machines. COMPSAC/IEEE, 2011. p. 26-27. Disponível em: <http://arxiv.org/abs/1010.3045>. Acesso em: 23 jan. 2013', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (582, NULL, 'UM GUIA para o corpo de conhecimento de análise de negócios: guia BABOK: versão 2.0. Toronto: IIBA International Institutute of Business Analysis, 2011. Disponível em: <http://books.google.com.br/books?id=wZvSEEg39N4C&printsec=frontcover&hl=pt-BR&source=gbs_ge_summary_r&cad=0#v=onepage&q&f=false>. Acesso em: 07 nov. 2012', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (583, NULL, 'SHAW, Mary; GARLAN, David. Software architecture: perspectives on an emerging discipline. São Paulo: Prentice Hall. 1996. 242p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (584, NULL, 'TAYLOR, R. N.; MEDVIDOVIC, N. ; DASHOFTY, E. M. Software architecture: Foundations, Theory, and Practice. Wiley, 2009. 750p', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (585, NULL, 'ULLMAN,J.D.;WIDOW,J.First Course in database systems. 3. ed. São Paulo: Prentice Hall, 2007', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (586, NULL, 'HAMBRICK, G. et al. Persistence in the enterprise: a guide to persistence technologies. Boston: IBM Press, 2008', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (587, NULL, 'Travassos, G. et. al. Introdução a Engenharia de Software Experimental. Rio de Janeiro: COPPE/UFRJ, 2002. Relatório Técnico ES-590/02', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (588, NULL, 'KITCHENHAM, B. Procedures for Performing Systematic Reviews. Australia: Joint Technical Report Keele University/NICTA Technical/Keele University/ NICTA, 2004', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (589, NULL, 'ERIKSSON,Hans-Erik. UML 2 toolkit. New York: Wiley, 2004', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (590, NULL, 'GUEDES, Gilleanes T. A. UML 2: uma abordagem prática. São Paulo: Novatec, 2009', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (591, NULL, 'FOWLER, F.J. Pesquisa de Levantamento. Porto Alegre: Pearson, 2011', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (592, NULL, 'MOREIRA, Mario E. Adapting configuration management for agile teams: balancing sustainability and speed. New York: John Wiley & Sons, 2009', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (593, NULL, 'SOFTEX Brasil. Guias MPS.BR. Disponível em: <http://www.softex.br/mpsbr/_home/default.asp>. Acesso em: 23 jan. 2013', 'Virtual');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (594, NULL, 'THAYER, Richard H. ; DORFMAN, M. ; BAILIN, Sidney C. Software requirements engineering. 2. ed. Los Alamitos, Calif.: IEEE Computer Society Press, 2000. 483p.', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (166, '8575220500', 'NIEDERAUER, Juliano. Desenvolvendo websites com PHP: aprenda a criar websites dinâmicos e interativos com PHP e banco de dados. Ed. rev. e atual. São Paulo, SP: Novatec, 2008. 269 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (204, '9788576082187', 'FREEMAN, Elisabeth; FREEMAN, Eric. Use a cabeça!: HTML com CCS e XHTML. 2. ed. Rio de Janeiro, RJ: Alta Books, 2008. xxxi, 580 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (241, '9788579360855', 'ELMASRI, Ramez; NAVATHE, Sham. Sistemas de banco de dados. 6. ed. -. São Paulo, SP: Pearson Education do Brasil, 2011. xviii, 788 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (246, '8535210350', 'WELCH-ABERNATHY, Dameon D. Check point fire wall-1 essencial: um guia de instalação, configuração e solução de problemas. Rio de Janeiro, RJ: Campus, 2002. xvii, 537 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (283, '8587062387', 'DUQUE, José Guimarães. Perspectivas nordestinas. 2. ed. Fortaleza: Banco do Nordeste do Brasil, 2004. 423 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (284, '8522438927', 'ALMEIDA, Guilherme Assis de; CHRISTMANN, Martha Ochsenhofer. Ética e direito: uma perspectiva integrada . 2. ed. São Paulo: Atlas, 2006. 185 p. ;', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (595, '079237990X', 'JURISTO, Natalia; MORENO, Ana M. Basics of software engineering experimentation. Boston: Kluwer Academic Publishers, 2001. 395p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (1, '9788573074895', 'LAVILLE, Christian; DIONNE, Jean. A construção do saber: manual de metodologia da pesquisa em ciências humanas. Porto Alegre: Artmed, Belo Horizonte: Editora UFMG, 2008. 340 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (40, '9788535223552', 'HENNESSY, John L; PATTERSON, David A. Arquitetura de computadores: uma abordagem quantitativa. 4. ed. Rio de Janeiro, RJ: Elsevier, 2008. 494 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (81, '9780596510046', 'BEAUTIFUL code: leading programmers explain how they think. California: O´Reilly, 2007. xxi, 593 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (92, '8573934069', 'GIMENES, Itana Maria de Souza; HUZITA, Elisa Hatsue Moriya. Desenvolvimento baseado em componentes: conceitos e técnicas . Rio de Janeiro, RJ: Ciência Moderna, 2005. xvi, 282 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (121, '8575221129', 'KOSCIANSKI, André; SOARES, Michel dos Santos. Qualidade de software. 2. ed. São Paulo, SP: Novatec, 2007. 395p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (163, '8576080621', 'HORSTMANN, Cay S. ; CORNELL, Gary. Core Java 2: volume I : fundamentos . Rio de Janeiro, RJ: Alta Books, c2005. viii, 580 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (327, '9788571398979', 'CARNIELLI, Walter Alexandre; EPSTEIN, Richard L. Computabilidade, : funções computáveis, lógica e os fundamentos da matemática . 2. ed. rev. São Paulo: Ed. UNESP, 2009. 415 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (78, '9788573935950', 'COSTA, Daniel Gouveia. Comunicações multimídia na internet: da teoria à prática. Rio de Janeiro, RJ: Ciência Moderna, 2007. xiii, 236 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (275, '9788574851471', 'SILVA, Delnise. Flores de um jardim: a narrativa de si em contexto de vulnerabilidade social - sociabilidades, sensibilidades e utopias entre os jovens do grupo "Nosso espaço" (Fortaleza). Fortaleza, CE: Imprensa Universitária - UFC, 2010. 150 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (26, '8521614225', 'GERSTING, Judith L. Fundamentos matemáticos para a ciência da computação: um tratamento moderno de matemática discreta . 5. ed. Rio de Janeiro: Livros Técnicos e Científicos, c2004. xiv, 597 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (58, '9788521615965', 'OLIFER, Natalia; OLIFER, Victor. Redes de computadores: princípios, tecnologias e protocolos para o projeto de redes . Rio de Janeiro: LTC, 2008. xvi, 576 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (406, '9788535237061', 'ALBERTIN, Rosa Maria de Moura; ALBERTIN, Alberto Luiz. Estratégias de governança de tecnologia da informação: estrutura e práticas . Rio de Janeiro, RJ: Elsevier, 2010. 212 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (434, '9788535247589', 'DORNELAS, Jose Carlos Assis. Empreendedorismo: transformando idéiais em negócios . 4. ed. rev. atual. Rio de Janeiro, RJ: Elsevier, 2012. 260 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (475, '8572821708', 'BEZERRA, João Clímaco. A vinha dos esquecidos. Fortaleza: Ed. UFC, 2005. 227 p. (Coleção Literatura no Vestibular ; 6)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (488, '8500005645', 'TAUNAY, Alfredo d''Escragnolle Taunay Visconde de, . Inocência. 2. ed. Rio de Janeiro, RJ: Ediouro, 2001. 216 p. (Serie Bom Livro Coleção Super Prestígio)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (596, '9788560031498', 'COULOURIS, GeorgeF.; DOLLIMORE, Jean; KINDBERG, Tim. Sistemas distribuídos: conceitos e projeto. 4. ed. Porto Alegre: Bookman, 2007. viii, 784p. ', 'Fisico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (597, '97885739366742', 'GONÇALVES, Edson. Desenvolvendo aplicações Web com NetBeans IDE 6. Rio de Janeiro, RJ: Ciência Moderna, 2008. xix, 581p. ', 'Fisico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (598, '8535206841', 'MURDOCCA, Miles; HEURING, Vincent P. Introdução a arquitetura de computadores. Rio de Janeiro, RJ: Elsevier, 2000. xxii, 512p. ', 'Fisico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (323, '8571109168', 'ALBERTI, Leon Battista. Matemática lúdica. Rio de Janeiro, RJ: Jorge Zahar, 2006. 115 p. (Ciência e cultura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (551, '0818677384', 'THAYER, RichardH. ; DORFMAN, M. ; BAILIN, Sidney C. Software requirements engineering. 2. ed. Los Alamitos, Calif. : IEEE Computer Society Press, 2000. 483p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (599, '9788535235227', 'WAZLAWICK, Raul Sidnei. Metodologia de pesquisa para ciência da computação. Rio de Janeiro, RJ: Elsevier, 2008. 159p. ', 'Fisico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (519, '157586374X', 'BARWISE, Jon; ETCHEMENDY, John; ALLWEIN, Gerard; BARKER-PLUMMER, Dave;LIU, Albert. Language, proof and logic. Stanford:CSLI, 2008. 587p. ;(CSLI lecture notes;v23)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (385, '8572821856', 'SANTOS, Sandra Maria dos; PESSOA, Maria Naiula Monteiro; MACIEL, Terezinha de Jesus Pinheiro. Experiências recentes em controladoria. Fortaleza, CE: Edições UFC, 2005. 302p. (Estudos Contemporâneos em Controladoria ; 1)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (96, '9788579361081', 'SOMMERVILLE, Ian, |d 1951-; OLIVEIRA, Kalinka; BOSNIC, Ivan. Engenharia de software. 9. ed. São Paulo, SP: Pearson/ Prentice Hall, 2011. xiii, 529 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (314, '8535704620', 'IEZZI, Gelson; HAZZAN, Samuel; DEGENSZAJN, David Mauro. Fundamentos de matemática elementar: 11 : matemática comercial, matemática financeira, estatística descritiva . São Paulo, SP: Atual, 2004. 232 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (553, '0792386825', 'EXPERIMENTATION in software engineering: an introduction. Boston, MA: Kluwer Academic, 2000. 204p. (The Kluwer international series in software engineering; 6)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (8, '1595937537', 'SYMPOSIUM ON APPLIED COMPUTING 23rd. , 2008, Fortaleza, CE); WAINWRIGHT, Roger L. Applied computing 2008 : the 23rd annual ACM Symposium on Applied Computing: proceedings of the 2008 ACM Symposium on Applied Computing, Fortaleza, March 16-20, 2008. Fortaleza, CE: ACM Press, 2008. 3v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (400, '9788573937411', 'MANSUR, Ricardo. Balanced scorecard: revelando SEPV : estudos de casos brasileiros. Rio de Janeiro, RJ: Ciência Moderna, 2008. xi, 265p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (566, '0471606952', 'SCHMIDT, Douglas C. Pattern-oriented software architecture: volume 2. Chichester [England]; New York: John Wiley & Sons, 2000. 633p. (Wiley series in software design patterns)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (362, '9788536502076', 'MARIN, Paulo S. Cabeamento estruturado: desvendando cada passo : do projeto à instalação . 3. ed. rev. e atual. São Paulo: Érica, 2009. 336 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (115, '0735618798', 'WIEGERS, Karl Eugene. Software requirements: practical techniques for gathering and managing requirements throughout the product development cycle . 2. ed. Redmond: Microsoft, 2003. 516 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (132, '9788576051879', 'BARNES, David J. ; KÖLLING, Michael. Programação orientada a objetos com java: uma introdução prática usando o blueJ. 4. ed. São Paulo, SP: Pearson Prentice Hall, 2009. xxii , 444 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (123, '9788574523088', 'MARTINS, José Carlos Cordeiro. Técnicas para GERÊNCIAmento de projetos de software. Rio de Janeiro, RJ: Brasport, 2007. xviii, 432p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (474, '857485042X', 'MAIA, Virgílio. Palimpsesto & outros sonetos. Fortaleza: Imprensa Universitária da Universidade Federal do Ceará, 2004. 99 p. (Coleção Literatura no Vestibular ; 3)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (205, '9788577805525', 'NORTHRUP, Anthony; MACKIN, J. C. Configuração do Windows Server 2008: infraestrutura de rede : kit de treinamento MCTS (Exame 70-462). Porto Alegre, RS: Bookman, 2009. 679 p. + 1 DVD (Kit de treinamento Microsoft)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (41, '9788535206845', 'MURDOCCA, Miles; HEURING, Vincent P. Introdução a arquitetura de computadores. Rio de Janeiro, RJ: Elsevier, 2000. xxii, 512p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (228, '0321197860', 'SHNEIDERMAN, . Designing the user interface: strategies for effective human-computer interaction . 4th ed. Boston: Pearson/Addison Wesley, c2005. xviii, 652 p. :', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (209, '9788577805280', 'HOLME, Dan; RUEST, Nelson; RUEST, Danielle. Kit de treinamento MCTS (Exame 70-640): configuração do Windows Server 2008 : Active Directory . Porto Alegre, RS: Bookman, 2009. 989 p. + 1 CD-ROM (Kits de treinamento Microsoft. )', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (282, '9788535242027', 'LEITE, Antonio Dias. A economia brasileira: de onde viemos e onde estamos. 2. ed. , rev. e atual. Rio de Janeiro, RJ: Elsevier, 2011. 226p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (311, '9788577804719', 'MENEZES, Paulo Blauth; TOSCANI, Laira V. ; GARCÍA LÓPEZ, Javier. Aprendendo matemática discreta com exercícios. Porto Alegre, RS: Bookman, 2009. 356p. ((Livros didáticos informática ufrgs ; ; v. 19))', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (338, '9780072988437', 'LAW, Averill M. Simulation modeling and analysis. 4th ed. Boston: McGraw-Hill, 2007. xix, 768 p. + + 1 CD-ROM (4 3/4 in. ) (McGraw-Hill series in industrial engineering and management science)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (355, '9788526258570', 'LUZ, Antônio Máximo Ribeiro da; ALVARES, Beatriz Alvarenga, Luz, A. M. R. Curso de física: Antônio Máximo Ribeiro da Luz, Beatriz Alvarenga Álvares. São Paulo, SP: Scipione, 2005. 3 v. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (382, '9788535217360', 'SALIM, César Simões. Construindo planos de negócios: todos os passos necessários para planejar e desenvolver negócios de sucesso. 3. ed. rev. e atual. Rio de Janeiro, RJ: Elsevier, 2005. xiv, 332 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (413, '857605065X', 'OLIVEIRA, Fátima Bayma de FUNDAÇÃO DE AMPARO À PESQUISA DO ESTADO DO RIO DE JANEIRO; FUNDAÇÃO GETÚLIO VARGAS. Tecnologia da informação e da comunicação: desafios e propostas estratégicas para o desenvolvimento dos negócios. São Paulo, SP: Prentice Hall, 2006. 240p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (449, '9788577807383', 'LIDWELL, William; HOLDEN, Kritina; BUTLER, Jill. Princípios universais do design: 125 maneiras de aprimorar a usabilidade, influenciar a percepção, aumentar o apelo e ensinar por meio do design. Porto Alegre, RS: Bookman, 2010. 272 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (485, '8508004656', 'GÜIMARÃES, Bernardo, . A escrava Isaura. São Paulo, SP: DCL, 2005. 96 p. (Classicos da Literatura Brasileira Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (501, '8575631160', 'DUARTE, Ana Rita Fonteles UNIVERSIDADE FEDERAL DO CEARA. Carmen da Silva: o feminismo na imprensa brasileira . Fortaleza: Expressão Gráfica e Editora, 2005. 185p. (Historia e memória do jornalismo Série História e Memória do Jornalismo)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (538, '8571948992', 'VAZQUEZ, Carlos Eduardo; SIMÕES, Guilherme Siqueira;ALBERT, RenatoMachado. Análise de pontos de função:medição, estimativas e gerenciamento de projetos de software. São Paulo: Érica, 2011. 222p.', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (563, '8535210938', 'SOUZA, João Nunes de. Lógica para ciência da computação: fundamentos de linguagem, semântica e sistemas de dedução. Rio de Janeiro: Elsevier, 2002. 309p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (33, '8535212280', 'CELES, Waldemar; CERQUEIRA, Renato; RANGEL, José Lucas. Introdução a estruturas de dados: com técnicas de programação em C. Rio de Janeiro, RJ: Elsevier: Campus, 2004. xi, 294 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (202, '9788577801473', 'ROBBINS, Arnold; BEEBE, Nelson H. F. Classic shell scripting: automatize suas tarefas com Unix . Porto Alegre: Bookman, 2008. xvii, 511p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (104, '8576051480', 'ASCENCIO, Ana Fernanda Gomes; CAMPOS, Edilene Aparecida Veneruchi de. Fundamentos da programação de computadores: algoritmos, Pascal, C/C++ e java. 2. ed. São Paulo, SP: Prentice Hall, 2007. viii, 434 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (147, '9788577260447', 'TUCKER, Allen B. |; NOONAN, Robert. Linguagens de programação: princípios e paradigmas. São Paulo, SP: McGraw-Hill, 2008. xxi, 599 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (260, '97885352232193', 'CONCI, Aura; AZEVEDO, Eduardo. ; LETA, Fabiana R. Computação gráfica, v. 2: teoria e prática. Rio de Janeiro, RJ: Elsevier: Campus, 2008. 407 p. , [8] p. de estampas + + 1 CD-ROM', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (307, '8587484281', 'SCHLITTLER, José Maria Martins. Pensando em português: teoria e prática, assuntos e temas aplicados em concursos públlicos e vestibulares. Campinas, SP: Servanda, 2004. 392 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (342, '9788571931909', 'ALBUQUERQUE, José Paulo de Almeida e; FORTES, José Mauro Pedro; FINAMORE, Weiler Alves. Probabilidade, variáveis aleatórias e processos estocásticos. Rio de Janeiro, RJ: Editora PUC-Rio; Interciência, 2008. 334 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (376, '8535213481', 'CHIAVENATO, Idalberto. Introdução à teoria geral da administração. 7. ed. , totalmente rev. e atual. Rio de Janeiro: Elsevier: Campus, 2003. xxviii, 634 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (447, '8561381000', 'LIMA, Roberto Galvão; OLIVEIRA, Almir Leal de; UNIVERSIDADE FEDERAL DO CEARÁ. A escola invisível: artes pláticas em Fortaleza 1928-1958. Fortaleza, CE: Quadricolor, 2008. 215 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (554, '9781848000445', 'SHULL, Forrest;SINGER, Janice;SJÃ¸BERG, DagI. K SPRINGER LINK. Guide to advanced empirical software engineering. London: Springer-Verlag London Limited, 2008. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (52, '139788522108459', 'FEDELI, Ricardo Daniel. ; POLLONI, Enrico Giulio Franco; PERES, Fernando Eduardo. Introdução à ciência da computação. 2. ed. atual. São Paulo, SP: Cengage Learning, 2010. xvi, 250 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (59, '8576080567', 'OLIVEIRA, Gorki Starlin da Costa. Redes de computadores comunicações de dados TCP/IP: conceitos, protocolos e usos. Rio de Janeiro, RJ: Alta Books, 2004. xi, 224 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (182, '9788535226348', 'DELAMARO, Márcio; MALDONADO, Jose Carlos. Introdução ao teste de software. Rio de Janeiro, RJ: Elsevier: Campus, 2007. 394 p. (Sociedade brasileira de computação)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (174, '8573932104', 'KURNIAWAN, Budi. Java para a Web com Servlets, JSP e EJB: Budi Kurniawan; tradução Savannah Hartmann; revisão técnica Alfredo Dias da Cunha Júnior. Rio de Janeiro, RJ: Ciência Moderna, 2002. xxiv, 807 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (213, '9780470891667', 'RANDOLPH, Nick; FAIRBAIRN, Christopher. Professional Windows Phone 7 application development: building applications and games using Visual Studio, Silverlight, and XNA. Indianapolis, Indiana: Wiley Publishing, 2011. xxiii, 594 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (103, '8521610149', 'SZWARCFITER, Jayme Luiz; MARKENZON, Lilian. Estruturas de dados e seus algoritmos. 2. ed. rev. Rio de Janeiro: Livros Técnicos e Científicos, c1994. 320 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (138, '9788560031528', 'LARMAN, Craig. Utilizando UML e padrões: uma introdução à análise e ao projeto orientados a objetos e ao desenvolvimento iterativo. 3. ed. Porto Alegre: Bookman, 2007. 695 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (178, '9788535224061', 'SILBERSCHATZ, Abraham; GALVIN, Peter B. ; GAGNE, Greg. Sistemas operacionais com Java. 7. ed. rev. atual. Rio de Janeiro, RJ: Elsevier, 2008. xx, 673 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (212, '9780735626393', 'THERNSTRÖM, Tobias. MCTS self-paced training kit (Exam 70-433): Microsoft SQL Server 2008: database development . Redmond, Wash. : Microsoft, 2009. xxiii, 456 p. + 1 CD (Self-paced training kit Microsoft)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (266, '9780521865715', 'MANNING, Christopher D. ; RAGHAVAN, Prabhakar. Introduction to information retrieval. New York, NY: Cambridge at the University Press, 2009. xxi, 482 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (294, '9788578261191', 'SANTOS, Deribaldo; SOUSA, Francisco Edisom Eugenio de; NASCIMENTO, Arnaldo Ricardo do. Caderno de pesquisas socioeducativas do Sertão Central. Quixadá: EdUECE, 2012. 150 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (320, '8535705481', 'IEZZI, Gelson. Fundamentos de matemática elementar, 6: complexos, polinômios, equações : 89 exercícios resolvidos, 422 exercícios propostos com resposta, 273 testes de vestibulares com resposta. 7. ed. São Paulo, SP: Atual, 2005. 250 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (351, '8536306882', 'DANCEY, Christine P. ; REIDY, John. Estatística sem matemática para psicologia: usando SPSS para Windows. 3. ed. Porto Alegre, RS: Artmed, 2006. 608 p. (Biblioteca Artmed. Métodos de Pesquisa)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (371, '9788577807451', 'FITZSIMMONS, James A; FITZSIMMONS, Mona J. Administração de serviços: operações, estratégia e tecnologia da informação. 6. ed. Porto Alegre, RS: Bookman, 2010. 583 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (421, '9788522465187', 'REZENDE, Denis Alcides; Abreu (Professora). Tecnologia da informação aplicada a sistemas de informação empresariais: o papel estratégico da informação e dos sistemas de informação nas empresas. 8. ed. rev. e amp. São Paulo, SP: Atlas, 2011. xxv, 335 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (443, '9788522456857', 'ALBERTIN, Alberto Luiz. ; MOURA, Rosa Maria de. Comércio eletrônico: modelo, aspectos e contribuições de sua aplicação. 6. ed. atual. e ampl. São Paulo, SP: Atlas, 2004. 306 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (491, '8536800798', 'ASSIS, Machado de. Memórias Póstumas de Brás Cubas. São Paulo, SP: DCL, 2005. 112 p. (Coleção Nossa Literatura Clássica Grandes Nomes da Literatura)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (539, '9780201699443', 'GARMUS, David; HERRON, David. Function point analysis: measurement practices for successful software projects. Boston: Addison-Wesley, 2001. (Addison-Wesley information technology series)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (154, '9788577804535', 'RAMOS, Marcus Vinícius Midena; JOSÉ NETO, João; VEGA, Ítalo Santiago. Linguagens formais: teoria, modelagem e implementação. Porto Alegre: Bookman, 2009. 656 p. (Livros didáticos ; n. 3)', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (11, '857631293X', '(III 2010, Brasília, Brasil). CONSEGI 2010: III Congresso Internacional Software Livre e Governo Eletrônico - Amãpytuna computação em nuvem: serviços livres para a sociedade do conhecimento. . Brasília, DF: Fundação Alexandre de Gusmão, 2010. 171 p. ', 'Físico');
INSERT INTO titulos (id_t, isbn, nome_titulo, tipo_titulo) VALUES (408, '8589384780', 'WEILL, Peter; ROSS, Jeanne W. Governança de TI: tecnologia da informação : como as empresas com melhor desempenho administram os direitos decisórios de TI na busca por resultados superiores. São Paulo, SP: M. Books do Brasil, 2006. 276p. ', 'Físico');


  -- Sincronia de autoincrement --
SELECT setval('seq_id_titulo', (SELECT MAX(id_t) FROM titulos)+1);





--Inserindo dado na tabela curso
INSERT INTO curso(
            cod_c, nome)
    VALUES ('401', 'Sistemas de Informação');
INSERT INTO curso(
            cod_c, nome)
    VALUES ('402', 'Engenharia de Software');
INSERT INTO curso(
            cod_c, nome)
    VALUES ('403', 'Redes de Computadores');
INSERT INTO curso(
            cod_c, nome)
    VALUES ('404', 'Ciência da Computação');



--Inserindo dados na tabela curriculo 
-- Sistemas de Informação
INSERT INTO curriculo(
            ano_semestre, cod_curso)
    VALUES ('2007.1','401' );
--Engenharia de Software
INSERT INTO curriculo(
            ano_semestre, cod_curso)
    VALUES ('2010.1', '402');
--Redes de computadores
INSERT INTO curriculo(
            ano_semestre, cod_curso)
    VALUES ('2010.1', '403');
--Ciência da Computação
INSERT INTO curriculo(
            ano_semestre, cod_curso)
    VALUES ('2013.1', '404');


--Inserindo dados na tabela integração curricular
--Dados de Sistema de informação
--1 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (2, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (4, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (3, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (5, 1);

--2 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (7, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (9, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (6, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (10, 1);

--3 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (14, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (13, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (12, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (11, 1);


--4 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (17, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (18, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (15, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (16, 1);


--5 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (19, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (20, 1);	
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (22, 1);

--6 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (23, 1);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (24, 1);



--Inserindo dados na tabela integração curricular
--Dados de Engenharia de Software
--1 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (56, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (55, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (2, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (57, 2);


--2 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (58, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (8, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (6, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (9, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (13, 2);


--3 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (30, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (15, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (17, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (14, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (11, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (50, 2);


--4 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (39, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (59, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (60, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (73, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (12, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (41, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (18, 2);	


--5 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (64, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (65, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (61, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (62, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (21, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (70, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (42, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (47, 2);


--6 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (43, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (72, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (68, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (90, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (26, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (35, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (38, 2);


--7 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (63, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (69, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (67, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (66, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (71, 2);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (36, 2);


--8 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (91, 2);




--Inserindo dados na tabela integração curricular
--Dados de Redes de Computadores
--1 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (2, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (74, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (5, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (75, 3);



--2 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (8, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (14, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (30, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (22, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (13, 3);



--3 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (12, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (79, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (77, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (78, 3);



--4 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (92, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (44, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (83, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (80, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (81, 3);



--5 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (35, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (84, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (49, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (34, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (89, 3);



--6 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (21, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (87, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (86, 3);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (88, 3);




--Inserindo dados na tabela integração curricular
--Dados de Ciência da Computação
--1 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (1, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (2, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (6, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (57, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (55, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (96, 4);



--2 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (8, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (14, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (11, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (7, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (9, 4);



--3 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (41, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (18, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (13, 4);



--4 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (12, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (17, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (42, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (15, 4);



--5 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (26, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (40, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (75, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (22, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (21, 4);



--6 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (20, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (39, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (44, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (38, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (47, 4);



--7 semestre
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (89, 4);
INSERT INTO integracao_curricular(
            id_disciplina, id_curriculo)
    VALUES (30, 4);









--Inserindo dados na tabela exemplares

INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (1, '14054423');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (1, '14054424');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (1, '13927594');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (1, '13927595');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (1, '13927592');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (1, '14054425');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (2, '13947565');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (2, '13947958');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES (2, '13947566');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 2, '13947567');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 3, '14054644');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 3, '14054642');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054611');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054613');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054610');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054612');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054615');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054609');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054608');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054614');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 4, '14054616');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '14055761');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '14031934');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '13984347');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '13984346');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '14055760');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '13984348');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '14031933');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '14055762');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 5, '14031935');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 6, '14053731');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 6, '14053732');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 6, '14032679');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 6, '14032680');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 6, '14053730');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 7, '14056659');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 7, '14056661');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 7, '14056662');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 7, '14056664');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 7, '14056663');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 7, '14056660');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 8, '14021516');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 8, '14021515');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 9, '14033382');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 9, '14033383');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 9, '14033381');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '14033209');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '13986749');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '14056217');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '14033210');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '13986748');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '14056218');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 10, '13986747');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 11, '14033404');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 11, '14033405');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 11, '14033407');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 11, '14033406');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 12, '13890979');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 12, '13890978');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 12, '13890977');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 13, '14050564');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 13, '13988600');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 13, '13988601');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 13, '14050566');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 13, '14050565');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 13, '13988603');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 14, '14042822');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 14, '14042824');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 14, '14042821');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 14, '14042820');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 14, '14042823');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '13936867');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '13937567');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '14054895');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '13936868');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '13936866');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '14054897');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 15, '14054896');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054868');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054870');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054878');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054871');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054872');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054874');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054876');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054875');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054877');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054879');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 16, '14054869');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14054507');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14054504');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14054502');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14019671');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14019670');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14054505');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14054506');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14019675');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14019672');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14019674');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14019673');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 17, '14054503');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 18, '14031367');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 18, '13985456');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 18, '13985454');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 18, '14031368');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 18, '14031369');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 18, '13985455');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 19, '13983721');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 19, '13988730');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 20, '14056915');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 21, '14058968');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 22, '14057310');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 22, '14057311');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 23, '13992564');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14063897');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985829');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14063898');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13890952');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13960345');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14063896');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13960342');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14050894');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14050899');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13890954');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14050895');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13960343');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985822');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14050896');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14050898');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13960344');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13890953');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985826');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13960341');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985827');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14063895');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985823');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14050897');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985824');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14063899');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13985825');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '14063900');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 24, '13890955');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054745');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14027202');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054739');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054749');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054746');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054748');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054744');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054742');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054747');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054740');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054741');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054750');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14054743');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 25, '14018071');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 26, '13934632');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 26, '13934631');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 26, '13934633');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 27, '14057961');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 27, '14057960');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 27, '14057958');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 27, '14057957');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 27, '14057959');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056172');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056175');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056176');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056171');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056178');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056174');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 28, '14056177');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983995');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983767');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983994');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983992');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 29, '13983993');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 30, '13985762');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 30, '13985763');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 30, '13985761');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14019252');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13988605');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14051368');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13936886');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14051370');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13890973');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13988606');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14051369');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14019250');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14019249');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14019251');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14019253');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13937625');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14051358');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13988604');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13936883');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14051357');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13936885');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13936884');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13988607');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14019248');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13890975');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '13890980');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 31, '14051359');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 32, '13984171');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 32, '14019783');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 32, '13984172');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 32, '13984173');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 32, '14019784');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 32, '14019785');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054889');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054893');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054902');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054890');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054891');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054904');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054894');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 33, '14054903');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 34, '13987765');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 34, '13987766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 34, '13987767');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 35, '13987780');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 35, '13987779');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 35, '14041429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 35, '14041428');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 35, '13987778');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 35, '14041427');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 36, '14019962');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 36, '14019964');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 36, '14019961');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 36, '14019963');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 36, '14019960');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 37, '14056783');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 37, '14056779');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 37, '14056781');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 37, '14056784');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 37, '14056780');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 37, '14056782');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 38, '14056206');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '14056614');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '13986665');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '14056615');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '14050995');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '14050994');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '13986666');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '13986664');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 39, '13986667');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056824');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056823');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056825');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056826');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056811');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056809');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056827');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056828');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056807');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056822');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056821');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056810');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056808');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 40, '14056820');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13941239');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13985815');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13941093');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13941240');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13985817');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13985821');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13985820');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13941238');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13941241');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '14061433');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13985819');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 41, '13985816');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 42, '14059359');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 43, '14018070');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 43, '14018069');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 44, '14058772');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 44, '14058773');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985398');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '14054783');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '14054782');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985402');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '14054784');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985395');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985397');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '14054785');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985400');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985399');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '14054787');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '13985401');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 45, '14054786');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '14031571');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '14031570');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '13986947');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '14055113');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '14055114');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '13986945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '13986946');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '14031573');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 46, '14031572');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14054520');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14054523');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14019842');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '13984806');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14054521');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14054524');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14019844');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '13984807');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '13984805');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14054522');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 47, '14019843');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '14055005');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '13983981');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '13983979');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '14050715');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '14050716');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '14050714');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '14055003');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '14055004');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 48, '13983980');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 49, '13986112');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 49, '13986110');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 49, '13986111');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 50, '13985952');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 50, '13985951');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 50, '14056214');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 50, '13985950');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 50, '14056215');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 50, '14056213');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984688');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13936927');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '14012343');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '14054779');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '14012345');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13936926');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13936928');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '14012344');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984672');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984673');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984691');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984674');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13937562');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '14054780');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984689');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '14054781');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984690');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 51, '13984675');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 52, '14056977');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 52, '14056978');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 53, '14056183');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 53, '13988899');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 53, '14056181');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 53, '13988897');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 53, '14056182');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 53, '13988898');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 54, '13984701');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 54, '14063903');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 54, '13984703');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 54, '13984702');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 54, '14063904');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 54, '14063902');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 55, '13985979');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 55, '13985981');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 55, '13985980');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 56, '14051484');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 57, '13984974');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 57, '14061434');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 57, '13984986');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 57, '13940741');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14031423');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14031421');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14031420');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14031422');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985407');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14031419');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14056574');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14031424');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14056577');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14056578');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14056575');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985406');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14056579');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985412');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985410');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '14056576');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985408');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985409');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 58, '13985411');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 59, '14050993');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 59, '13984353');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 59, '14050992');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 59, '13984351');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 59, '13984352');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 59, '14051031');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '14055108');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '13987264');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '14055107');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '13987263');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '13987262');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '14055110');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 60, '14055109');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '13987810');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '14056791');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '14057950');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '14056792');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '13987809');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '13987808');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 61, '14057951');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '13985840');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '14050721');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '13985842');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '14053735');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '14050720');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '14053733');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '13985841');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '14053734');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 62, '14050722');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '14019804');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '13984788');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '14055343');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '14055341');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '14019805');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '14055342');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '13984789');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '14019806');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 63, '13984787');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 64, '14050998');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 65, '14059390');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 66, '13984677');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 66, '13984679');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 66, '13984678');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 67, '13985297');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 67, '13985296');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 67, '13985295');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 68, '13984697');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 68, '13984698');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 68, '13984696');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 69, '13984303');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 69, '13984304');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 69, '13984305');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 69, '14050978');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 69, '14050977');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 69, '14050979');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 70, '14032681');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 70, '14032067');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 71, '13985932');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 71, '13985930');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 71, '13985931');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 72, '14018092');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 73, '13985478');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 73, '13985477');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 74, '14055963');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 74, '14032076');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 74, '14032077');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 74, '14055964');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 75, '13986694');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 75, '13986696');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 75, '13986695');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '13986259');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '13986258');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '14050572');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '14050573');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '13986257');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '14052240');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '14050574');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '14052238');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 76, '14052239');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '14053738');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '13985434');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '14053736');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '14031276');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '14031275');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '14031274');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '14053737');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '13985435');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 77, '13985433');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 78, '13986069');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 78, '14056402');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 78, '14056401');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 78, '14056409');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 78, '13986071');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 78, '13986070');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 79, '13986086');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 79, '13986088');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 79, '13986087');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 80, '14055880');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 80, '14055822');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 80, '14055881');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 81, '14057988');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14018157');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14054647');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14018155');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14054646');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14018156');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14018154');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14018153');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 82, '14054648');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13934663');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14019812');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14019809');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13984307');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13937066');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14054535');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14019813');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14054538');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14054537');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13934665');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13984308');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14054534');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14019808');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13934664');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13984306');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14019810');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14019811');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14054536');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '14054539');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 83, '13984309');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 84, '13984671');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 84, '13984669');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 84, '14055088');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 84, '14055089');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 84, '13984670');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 84, '14055090');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '13985316');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '13985315');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '14018163');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '14055196');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '14055197');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '14055198');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '14018164');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 85, '13985314');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 86, '14057179');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 86, '14057180');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 87, '13988568');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 87, '13988570');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 87, '13988569');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 88, '14056941');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 88, '14056940');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 89, '13984844');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 90, '13988626');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 90, '13988629');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 90, '13988628');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 90, '13960338');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984993');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '14055773');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984994');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13940747');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984997');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984990');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984991');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13940746');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984995');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984992');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13940749');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13940748');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '13984996');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 91, '14055774');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042840');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14055765');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042836');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14055768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042842');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14055764');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14055766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042838');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042837');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14055767');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042835');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14055763');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042839');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 92, '14042841');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '13984739');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '13984740');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '13984738');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '14056953');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '14012286');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '14063872');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '14063873');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '14063874');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 93, '14056954');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 94, '13985007');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 94, '13985005');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 94, '13985006');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 95, '14057011');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 96, '13985452');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 96, '13985453');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 96, '13985451');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 97, '13986992');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 98, '14063876');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 99, '13924465');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 99, '13924464');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 99, '13926431');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 99, '13924466');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '13934105');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051350');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051336');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051351');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051352');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051337');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '13936909');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051338');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051335');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '13934104');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '13934106');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 100, '14051334');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '14054755');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '14031705');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '13985000');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '13984999');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '13985001');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '14031707');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '14054756');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 101, '14054757');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 102, '14020332');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 102, '14020331');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '13984927');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '14031874');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '14052427');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '14052429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '14052428');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '14031872');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '13984926');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '13984925');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 103, '14031873');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 104, '14054791');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 104, '14054795');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 104, '14054794');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 104, '14054793');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 104, '14054792');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 104, '14054796');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 105, '14058708');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 106,'14032073');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 106, '14032072');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 106, '14032074');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '14056189');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '14050920');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985937');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13937074');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '14050919');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985938');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985939');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '14056188');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13934652');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13934653');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '14050918');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985943');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13934651');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985940');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985944');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '13985941');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 107, '14056190');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13983787');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055999');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055978');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056002');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13983789');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13934661');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056117');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056116');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13937081');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056000');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056001');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055975');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055973');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056118');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055977');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13983790');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056004');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13934660');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14056003');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055976');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13934659');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '14055974');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 108, '13983788');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 109, '13987214');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 109, '13987213');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 109, '13987216');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 110, '14058851');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 110, '14058852');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 111, '14058846');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 112, '13987273');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 112, '14051020');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 112, '14051021');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 112, '13987275');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 112, '13987274');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 113, '14059391');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 113, '14057873');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 113, '14059392');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 114, '14056422');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 114, '14056421');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986099');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115,'14054628');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '14054626');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '14054620');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986103');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '14054621');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13923707');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986101');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13923708');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986105');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986102');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '14054622');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986106');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986100');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '14054627');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 115, '13986104');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '13986012');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '14054526');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '14054527');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '13986010');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '14054525');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '14050940');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '14050941');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '13986011');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 116, '14050942');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 117, '14057690');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 118, '14054541');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 118, '14032754');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 118, '14054540');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '13987816');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '14056298');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '14059358');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '13987817');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '13987818');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '14056299');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 119, '14059357');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13983999');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13986384');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13986385');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13983998');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '14054984');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13970975');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13986386');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '14019729');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13983996');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13983997');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '14019728');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '14054985');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '14054986');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 120, '13986387');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13986282');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13985333');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13986283');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '14055160');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13986284');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '14031569');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13985331');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13986281');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '14055161');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '14055162');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13985332');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '14019799');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 121, '13985330');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 122, '13983663');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 122, '13983661');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 122, '13983660');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 123, '14042828');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 123, '14042829');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 124, '13984970');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 124, '13984969');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 124, '13984968');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '13983647');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '14019795');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '14055327');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '13983648');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '14019794');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '13983649');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '14055328');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '14055329');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 125, '14019796');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '13985310');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '14031362');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '14056262');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '13985312');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '13985311');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '14056260');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '14056261');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 126, '14031361');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 127, '13985288');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 127, '13985287');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 127, '13985286');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '13999446');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '13999445');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14051506');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '13999444');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14019125');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14019126');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14019127');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14051508');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14051511');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14051507');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14051510');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 128, '14051509');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 129, '14057297');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 129, '14057296');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 130, '13986141');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 130, '13986190');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 130, '13986143');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 130, '13986191');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 130, '13986186');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 130, '13986187');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14055083');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14055077');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14055195');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14055078');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14042722');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14042721');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14055193');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 131, '14055194');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 132, '14057694');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 132, '14057695');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13937560');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13999423');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13936921');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13936923');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '14019782');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13936922');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13999420');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13936920');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13999422');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '13999421');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 133, '14019780');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13985289');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13985291');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14031268');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14031267');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14054513');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14031271');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13941081');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14054512');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14054511');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13985292');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13941082');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13941084');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14031270');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14031272');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '14031269');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13941083');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 134, '13985290');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 135, '13984022');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 135, '13984023');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 135, '13984024');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941157');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941153');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941151');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941156');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941152');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941509');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941508');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941154');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 136, '13941155');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '14051505');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '14051503');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '14051500');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '13985447');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '14051501');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137,'13985448');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '13985449');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '14051502');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 137, '14051504');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983756');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983758');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983754');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983752');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983759');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983753');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 138, '13983757');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 139, '14057159');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 139, '14057160');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 139, '14057161');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 139, '14057162');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 139, '14057163');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 140, '14058431');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 140, '14058432');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 141, '14018085');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 141, '14018087');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 141, '13985329');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 141, '14018086');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 141, '13985328');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 141, '13985327');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 142, '13985390');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 143, '14053714');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 143, '14053716');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983716');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983678');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983680');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983715');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983696');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983714');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 144, '13983681');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 145, '14012462');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 145, '14012461');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 145, '14037209');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 146, '14060076');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 146, '14060074');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 147, '14031364');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 147, '13985029');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 147, '14031366');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 147, '13985030');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 147, '13985031');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 147, '14031365');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 148, '14056744');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 148, '14056743');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 148, '14056747');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 148, '14056746');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 148, '14056745');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 149, '14057167');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 149, '14057166');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 150, '14032665');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '14053729');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '14031282');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '14031281');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '13985324');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '14053728');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '13985323');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '14031283');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '14053727');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 151, '13985325');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 152, '13986028');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 152, '14050904');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 152, '14050905');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 152, '13986029');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 152, '13986027');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 152, '14050903');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 153, '14057157');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 153, '14056846');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 153, '14057154');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 153, '14057156');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 153, '14057155');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 153, '14057152');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 154, '13985437');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 155, '14055063');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 155, '14055061');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 155, '14055060');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 155, '14031887');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 155, '14055062');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 155, '14031888');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 156, '14012451');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 156, '14012449');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 156, '14012450');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 156, '14012448');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 156, '14012452');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 157, '13985443');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 157, '13985442');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 157, '13985445');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14058617');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14051016');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14058614');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986042');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14051014');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986039');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14058618');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14058616');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986049');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986048');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986041');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14058613');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986044');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986040');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986047');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986038');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14051015');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986055');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986051');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986052');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986046');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14054430');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14058612');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14054428');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '14054429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986054');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 158, '13986043');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042769');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042772');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14059302');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042763');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14052435');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042764');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14059303');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042762');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042765');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042771');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042770');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14042768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14059304');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 159, '14059305');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 160, '14057174');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 161, '13985461');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 161, '13985459');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 161, '13985460');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 162, '13934277');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 162, '13937082');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 162, '13934278');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 162, '13934276');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 162, '13934279');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 163, '14042776');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 163, '14042775');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 164, '13984052');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 164, '13984053');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 164, '13984055');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 164, '13984054');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 165, '14012531');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 165, '14012529');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 166, '14058713');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13941233');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986165');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13941223');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986183');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13941222');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986159');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986162');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986164');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13941219');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13937923');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986163');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 167, '13986167');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 168, '14061584');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 169, '14056339');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 169, '14056340');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 169, '14056341');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 169, '14051040');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 169, '14051041');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 169, '14056338');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '13986736');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '14056232');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '13986735');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '14056231');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '14031653');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '13986737');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 170, '14031652');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983670');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983668');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983666');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983664');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983665');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983667');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983669');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 171, '13983676');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983733');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983729');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983731');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983728');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983734');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983736');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983730');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 172, '13983735');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 173, '14033250');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 173, '14033252');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 173, '14033244');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 173, '14033243');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 173, '14033242');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 173, '14033248');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 174, '14058593');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 174, '14058594');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 175, '14059046');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 175, '14059045');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 176, '13983638');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 176, '13983635');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 176, '13983639');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 176, '13983640');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 176, '13983641');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 176, '13983636');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '14051389');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '14051388');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '14019353');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984155');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984159');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '14019351');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984156');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984158');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '14051387');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '14019352');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984154');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984157');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 177, '13984160');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 178, '14056418');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 178, '14056419');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 179, '14059426');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 179, '14059425');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 179, '14059427');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13937604');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '14056349');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '14056352');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986074');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13937602');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986077');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986079');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '14056353');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986075');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13937601');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13937603');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '14056351');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '14056348');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986076');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986080');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986078');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '14056350');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 180, '13986081');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 181, '14055007');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 181, '14012339');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 181, '14055006');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 181, '14020059');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057614');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057613');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057612');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057616');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057622');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057623');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 182, '14057615');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '13986707');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '14031910');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '13986708');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '14059368');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '14031909');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '14059047');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 183, '13986706');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 184, '13987770');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 184, '13987768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 184, '13987769');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 184, '13987771');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 185, '14059361');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 185, '14058600');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 185, '14058601');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 185, '14059360');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '13987805');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '14050935');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '14050924');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '13987804');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '13987803');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '14058923');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 186, '14058924');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019744');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019738');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019743');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019739');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019740');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019741');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 187, '14019742');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931519');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931521');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '14055330');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '14055331');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931522');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931526');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931520');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931525');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931524');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931523');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '13931527');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 188, '14055332');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986092');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056371');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056377');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056375');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986093');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986096');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056373');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056379');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986095');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056378');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986090');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986091');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056370');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056372');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '14056374');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986094');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 189, '13986089');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 190, '13941096');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 190, '13941095');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 190, '13941097');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '13984144');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '14057970');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '14031618');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '14031616');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '14031617');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '13984142');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '13984143');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '14057971');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 191, '14057972');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 192, '14056211');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 192, '14056210');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '13984043');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14053722');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14050583');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14050579');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14050581');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14053721');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '13984045');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14050578');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14053723');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14050580');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '13984044');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 193, '14050582');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '13987254');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '14031567');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '13987255');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '14031568');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '13987256');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '14054533');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 194, '14054532');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 195, '13986802');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 195, '14031578');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 195, '13986801');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 195, '13986803');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 195, '14031577');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 195, '13986800');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '14031619');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '13984138');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '13984139');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '13984140');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '14031620');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '14057964');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '14031621');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 196, '14057963');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 197, '14056874');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 197, '14056873');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 197, '14056875');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '14057969');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '14057968');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '14031427');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '13984147');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '14031426');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '14057967');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '14031425');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '13984146');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 198, '13984148');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 199, '13984695');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 199, '14056957');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 199, '13984694');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 199, '13984693');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 199, '14056959');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 199, '14056958');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 200, '14056326');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 200, '14059369');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 201, '13985012');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 201, '13985010');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 201, '13985009');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 201, '13985011');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 202, '13985039');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 202, '13985037');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 202, '13985038');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 203, '14055203');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 203, '14056134');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 203, '14055204');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 203, '14056132');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 203, '14056133');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 204, '14056122');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 204, '14055180');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 204, '14055181');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 204, '14056123');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 204, '14056127');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14050736');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14050892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063893');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14050735');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14055013');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063894');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14055012');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063886');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063887');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063891');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063890');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063889');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14055014');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14063888');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14050893');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 205, '14055011');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 206, '14056723');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 206, '14056727');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 206, '14056726');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 206, '14056724');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 206, '14056725');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 207, '14053695');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 207, '14056357');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 207, '14053694');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 207, '14056358');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 207, '14056359');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '14012469');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '14055369');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '13984006');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '13984007');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '14055371');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '13984005');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '14012467');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '14055370');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 208, '14012468');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054764');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054763');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054765');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054769');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054767');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 209, '14054762');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 210, '14059416');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 210, '14059276');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 210, '14059036');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 211, '14058934');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983627');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983621');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983624');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983623');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983622');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983625');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983628');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 212, '13983629');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 213, '14056428');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 213, '14056439');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 213, '14056437');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 213, '14056438');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 213, '14056429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 214, '14055951');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031094');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14021475');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031097');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031091');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031092');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031099');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031096');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031090');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031095');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031093');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 215, '14031098');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 216, '13942798');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 216, '13942797');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 216, '13942799');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '13986153');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '13986152');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054606');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054601');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054596');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054594');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054603');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '13986151');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054592');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054595');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054600');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054605');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054593');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054604');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054599');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054597');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054602');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '14054598');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 217, '13986150');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985903');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985909');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985465');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985466');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985464');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985904');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 218, '13985902');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 219, '13984169');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 219, '13984168');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 219, '13984167');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 220, '13988560');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 220, '13988562');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 220, '13988561');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14050911');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13934656');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14042235');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13986129');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14050912');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14055053');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13986128');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13934655');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14042236');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13934657');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14050913');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14055051');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13937062');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13986127');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '14055052');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 221, '13986126');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 222, '14056570');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 223, '14056573');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 223, '14056572');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13985483');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13985482');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13985484');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14050915');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14055348');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14055351');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13934682');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14055349');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14050916');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14055352');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13985481');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13934685');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13934683');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '13934684');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14055350');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14055353');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 224, '14050914');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 225, '14019211');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 225, '14056964');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 225, '14019210');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 225, '14056962');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 225, '14056963');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 226, '13952541');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 226, '13952538');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 226, '13952537');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 226, '13952539');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '14031709');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '13987235');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '14056253');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '13987234');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '13987236');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '14056254');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 227, '14031708');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 228, '14013095');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 228, '14013096');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 229, '14055119');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 229, '14051019');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 229, '14055118');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 229, '14055124');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 229, '14051018');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 229, '14055120');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '13984197');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '14056829');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '14056832');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '13984195');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '14056834');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '13984196');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '14056831');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '14056833');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 230, '14056830');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 231, '14058836');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 231, '14058940');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 231, '14058941');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 231, '14058835');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 232, '13987240');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 232, '14031622');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 232, '13987241');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 232, '14031623');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 232, '13987239');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 233, '13962975');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 233, '13962977');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 233, '13962974');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 233, '13962976');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 234, '14057871');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13984286');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13936871');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13936870');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13984283');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14019852');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14019853');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13936872');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14019850');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14054418');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14019848');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14054417');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14019849');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13984285');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14054416');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13984284');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '13936873');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 235, '14019851');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988682');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988678');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988681');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988683');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988677');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988679');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '14055183');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 236, '13988680');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 237, '14056984');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 237, '14056983');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055793');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055792');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055791');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055789');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055794');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055790');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055787');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 238, '14055788');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052225');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052234');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052230');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052232');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052233');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052231');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052228');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052226');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052229');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052224');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 239, '14052227');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 240, '14050947');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 240, '13986064');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 240, '14050945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 240, '13986066');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 240, '14050946');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 241, '13987260');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 241, '13987258');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 241, '13987259');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 242, '14059413');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 242, '14059411');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 242, '14059412');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 243, '13984937');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 243, '13984936');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 243, '13984938');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '14054415');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '14050718');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '14054413');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '14050719');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '13985898');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '14054414');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '14050717');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '13985900');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 244, '13985899');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 245, '14019845');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 245, '14019846');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 245, '14019847');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 246, '14031428');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 246, '13985622');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 246, '13985624');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 246, '14031429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 246, '13985623');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 246, '14031430');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 247, '13987158');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 247, '13987159');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 247, '13987157');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13984016');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13984018');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13983656');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13984019');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13983655');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13984017');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13983654');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 248, '13983653');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983652');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983651');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983642');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983643');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983645');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983657');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 249, '13983644');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986199');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986198');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '14050891');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986195');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986201');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '14050889');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986197');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '14050886');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986196');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '14050888');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '13986200');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '14050887');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 250, '14050890');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 251, '14058840');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 251, '14050959');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 251, '14058837');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 251, '14050958');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 251, '14058838');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 251, '14058839');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 252, '14055886');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14063867');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14057299');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14063870');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14063871');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14057300');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14063868');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14057301');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14063866');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 253, '14063869');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13937563');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13984289');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '14019857');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13984291');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '14019856');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13936897');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '14019858');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13984290');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13936898');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '14019859');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13936896');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '13984288');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '14019860');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 254, '14019861');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '13987230');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '13987231');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '14055032');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '14055033');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '13987232');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '14055031');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '14056896');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '14056897');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 255, '14055030');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 256, '13985303');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 256, '13985304');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 256, '13985302');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056483');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056442');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056484');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056474');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056481');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056482');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056480');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056472');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056441');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056478');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056479');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 257, '14056473');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 258, '14056158');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055888');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055953');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055958');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055906');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055889');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055952');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055949');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055954');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055959');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055905');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 259, '14055944');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 260, '13942941');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 260, '13942939');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 260, '13942940');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 260, '13942938');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 261, '14057837');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 262, '14056686');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 262, '14057393');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 262, '14057385');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 262, '14057394');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 262, '14057386');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 262, '14056688');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 263, '13926422');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 263, '13926419');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 263, '13926421');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 263, '13926420');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 264, '14059373');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 264, '14059371');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 264, '14059372');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '14051005');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '13987035');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '14051003');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '13987036');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '14051004');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '13987034');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 265, '14051002');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 266, '13987832');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 266, '13987833');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 266, '13987834');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 267, '13983540');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 267, '13983541');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 267, '13983539');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 267, '13983538');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 268, '14055919');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 268, '14055918');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 269, '14056656');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 269, '14056642');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 269, '14056657');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984081');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13923736');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13923735');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984079');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984078');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984084');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984082');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984077');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13923737');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984080');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13923731');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 270, '13984083');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063877');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14056433');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063885');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063884');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063881');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063878');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063882');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14056434');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14056436');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063880');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063883');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14056435');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 271, '14063879');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 272, '14054788');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 272, '14054772');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 272, '14054789');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 272, '14054771');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 272, '14054770');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 272, '14054790');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 273, '13924448');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 273, '13924450');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 273, '13924449');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 273, '13926429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 273, '13924447');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 274, '13992136');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 274, '13992134');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 274, '13992133');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 274, '13992135');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 275, '14002989');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 276, '13992423');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 277, '13992567');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057302');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057320');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057304');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057318');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057319');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057317');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 278, '14057303');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 279, '14055969');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 279, '14055968');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 280, '14055967');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 280, '14055966');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '13998549');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '14056329');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '14017926');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '14017927');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '14056327');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '13998550');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '14017925');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '13998551');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '13998552');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 281, '14056328');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 282, '14057993');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 282, '14057994');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 283, '13992429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 284, '13923250');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 284, '13942923');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 284, '13923251');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 284, '13923252');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 285, '13984073');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 285, '13984075');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 285, '13984074');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 285, '13984076');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 286, '13998525');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 286, '13998523');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 286, '13998524');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 286, '13998522');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 287, '13984417');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 287, '13984415');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 287, '13984416');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 287, '13984414');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 288, '14032553');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 288, '14032554');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 288, '14055393');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 289, '13987271');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 289, '13987269');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 289, '14051013');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 289, '13987268');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 289, '14051012');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 290, '13931562');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 290, '13931552');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 290, '13931565');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 290, '13931564');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 290, '13931563');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 291, '14024768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 291, '14024766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 291, '14024769');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 291, '14024767');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 292, '14033385');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 293, '13992432');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 294, '14064328');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 294, '14064327');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 294, '14064326');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 294, '14064329');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 294, '14064325');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '14031684');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '14056324');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '14056323');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '14031685');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '13985274');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '13985275');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '13985276');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '14031686');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 295, '14056322');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 296, '13946129');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 297, '13971018');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 297, '13971020');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 297, '13971019');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 297, '13971016');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 297, '13971017');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987245');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987244');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987247');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987248');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987249');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987246');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987250');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '14050931');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '14050932');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '14059393');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '14059394');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 298, '13987243');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941257');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941135');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986744');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941264');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986743');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941130');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941258');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941256');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986745');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986751');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941259');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941265');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986752');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986742');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986753');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13986750');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 299, '13941255');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 300, '13934910');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 300, '13937051');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 300, '13934909');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 300, '13934911');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 300, '13934912');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 301, '13923701');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 301, '13923704');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 301, '13923718');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 301, '13923703');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 301, '13923702');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 302, '14036498');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 302, '14036497');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 302, '14036496');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 303, '14040233');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 304, '14040119');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 304, '14040120');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 305, '14040229');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 306, '14040231');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 307, '14035985');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 308, '14040232');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 309, '14057646');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 310, '14056019');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 310, '14056020');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 310, '14056013');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 310, '14056017');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 310, '14056012');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 310, '14056018');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 311, '14057543');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 312, '14057453');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '13983559');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '14056905');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '13983561');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '14040134');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '14056903');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '14056904');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '13983558');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 313, '13983560');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 314, '14056146');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 314, '14056145');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 314, '14056144');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 315, '14040143');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056028');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056026');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056041');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056040');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056025');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056027');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056024');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 316, '14056039');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 317, '14056156');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 317, '14056155');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 317, '14056154');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13983567');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '14040182');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13983566');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13946118');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13946116');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13946117');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13983565');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13946119');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 318, '13983564');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '14056044');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '14056142');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '14056045');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '13932195');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '14056143');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '13932192');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '13932196');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '13932193');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '13932194');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 319, '14056046');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 320, '14056148');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 320, '14056149');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 320, '14056147');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 321, '14055783');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 321, '14055784');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14055042');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14031699');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984952');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14031703');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984949');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14055043');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14031700');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14031701');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984954');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14031704');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984955');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984953');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14055044');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984956');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '13984951');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 322, '14031702');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 323, '14040109');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 324, '13941248');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 324, '13941249');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 324, '13941247');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 324, '13941246');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 325, '14040116');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 325, '14040117');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 326, '13942828');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 326, '13942827');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 326, '13942826');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 326, '14056607');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 326, '13942829');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 326, '14056608');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055911');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055923');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055927');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055913');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055914');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055928');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055912');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055924');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055926');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055925');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 327, '14055915');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14012280');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055399');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055357');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055356');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055400');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055355');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055401');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14012279');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055397');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055398');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055402');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 328, '14055354');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 329, '14032156');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13984319');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '14054886');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '14019793');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '14054885');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13936890');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13984321');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13936888');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13936889');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13984318');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '14019792');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '14054887');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 330, '13984320');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13941714');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '14056159');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13941713');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '14050908');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '14050909');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '14050910');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13983811');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13983813');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13983810');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '14056161');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13983812');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '13941716');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 331, '14056160');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 332, '13941734');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 332, '13941733');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 332, '13941729');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 332, '13941732');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 332, '13941735');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 333, '14059299');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '13942927');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '14056344');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '13942928');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '13942926');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '13942929');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '14056342');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 334, '14056343');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 335, '13984837');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 335, '14059301');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 335, '14055339');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 335, '13984838');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 335, '13984839');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 335, '14055340');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986825');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986816');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986819');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986828');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986823');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986826');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986829');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986820');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986824');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 336, '13986827');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 337, '13890946');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 337, '13890945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 337, '13890947');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 338, '14056758');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 338, '14056760');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 339, '13984820');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 340, '14066911');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 340, '14066910');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '13986279');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '13986277');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '14055105');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '13986280');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '14055106');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '13986278');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 341, '14055115');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 342, '14031892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 342, '14031891');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 343, '13986741');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 343, '13986739');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 343, '13986740');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 344, '14018344');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 344, '14018346');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 345, '13890971');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 346, '14058910');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 346, '14058911');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 347, '14042760');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 347, '14042759');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 348, '14056296');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 348, '14056297');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 349, '14055957');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 349, '14055956');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 350, '14019956');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 350, '14019957');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 351, '14056166');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 352, '14063964');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 352, '14063965');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 352, '14063963');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13984333');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13934648');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13934646');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13984334');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13937078');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13934647');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13984332');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13984331');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 353, '13934649');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 354, '14050997');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 355, '14036007');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 355, '14036008');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 355, '14036006');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 356, '14036531');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14055374');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14051024');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '13984341');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '13984339');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14055377');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '13984340');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14055373');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14051022');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14051023');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14055372');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14055375');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 357, '14055376');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 358, '14058918');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 358, '14058919');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '13986266');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '14032356');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '14059300');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '14054412');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '13986264');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '14032355');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '14054411');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 359, '14032354');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 360, '14054589');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 360, '14054587');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 360, '14054588');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 360, '14054590');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 360, '14054591');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13952545');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13983632');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13952548');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13983630');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13983633');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13952547');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13983631');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 361, '13952546');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '14054409');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '14054410');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '13984322');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '13984323');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '13984325');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '14054408');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 362, '13984324');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '14019867');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '14054397');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '13984184');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '14019865');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '13984185');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '14054398');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '13984183');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '14019866');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 363, '14054396');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 364, '13992430');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054823');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14032685');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054827');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054830');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054829');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054826');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14032686');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054822');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 365, '14054828');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 366, '14057185');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 366, '14057184');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 367, '13936893');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 367, '13936891');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 367, '13936894');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 367, '13936892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 368, '14019054');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 368, '14055383');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 368, '14055384');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 368, '14019053');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 368, '14055378');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14055382');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13998543');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13998542');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14017894');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13923187');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14017890');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14017895');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14017893');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13923189');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13923188');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14055380');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14017892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14055381');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '14017891');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13998544');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13998541');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 369, '13923190');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '13934087');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '14031657');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '13937696');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '14031659');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '14055040');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '14055039');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '14055041');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '13934088');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '14031658');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 370, '13934089');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 371, '14019270');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 371, '14019262');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 371, '14019269');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 371, '14019261');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 371, '14019263');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 371, '14019271');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 372, '14057618');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 372, '14057619');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 372, '14057620');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 372, '14057603');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 372, '14057621');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 372, '14057602');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 373, '14021482');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 373, '14021483');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 373, '14021481');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 373, '14021484');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 374, '14031614');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 374, '14031615');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 375, '13985320');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 375, '13985318');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 375, '13985319');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 376, '14018178');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 376, '13890950');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 376, '13890951');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 376, '14018179');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 376, '13890949');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 376, '14018177');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 377, '14056487');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 377, '14056486');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 378, '14056407');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 378, '14056405');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 378, '14056406');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 378, '14056408');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926417');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926410');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926403');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926409');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926405');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926402');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926415');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926404');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926401');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 379, '13926407');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '14055128');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '14055132');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '13952604');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '14055131');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '14055129');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '13952605');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '14055130');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 380, '13952606');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 381, '13937627');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 381, '13976714');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 381, '13976716');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 381, '13976715');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998532');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020911');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020901');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940724');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940719');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940708');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940726');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940732');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13937874');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13937873');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998531');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998530');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020905');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14033654');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14033649');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020912');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940700');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998534');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020902');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14033553');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020903');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940722');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998533');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020900');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940720');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998536');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940725');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940699');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14033550');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020892');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14020904');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13998535');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940731');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '14033653');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 382, '13940723');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 383, '14057351');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 383, '14032131');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 383, '14032130');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 383, '14032132');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 383, '14057350');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 384, '13936902');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 384, '13936899');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 384, '13936900');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 384, '13936901');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14041681');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14019997');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14019999');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14020001');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14019996');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14020003');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14019998');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14020004');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14020002');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 385, '14020000');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 386, '14055073');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 386, '14055075');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 387, '13947575');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 387, '13947574');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 387, '13947961');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 388, '14056946');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 388, '14056945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 389, '14055943');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 390, '14055816');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 390, '14055930');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 390, '14055815');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 391, '13941117');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 391, '13941118');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 391, '13941115');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 391, '13941116');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 392, '14021510');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 392, '14021511');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 392, '14021512');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 392, '14021513');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 393, '13992575');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 393, '13992577');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 393, '13992576');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 393, '13992574');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 393, '13992573');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 394, '14057004');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 394, '14057005');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 395, '13998545');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 395, '14019801');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 395, '13998546');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 395, '13998548');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 395, '13998547');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 395, '14019802');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 396, '13942946');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 396, '13942945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 396, '13942947');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 396, '13942944');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 397, '14057326');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 397, '14057327');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 397, '14057325');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 398, '14057833');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 399, '13971076');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 399, '13971109');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 399, '13971107');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 399, '13971108');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 400, '14057700');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 400, '14057699');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 400, '14057698');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 401, '14019685');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 401, '14055389');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 401, '14019686');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 401, '14055390');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 401, '14055388');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 402, '13931573');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056219');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056168');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056163');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056236');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056244');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056234');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056228');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056227');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056229');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056241');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056164');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056243');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056224');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056225');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056222');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056169');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056221');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056239');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056226');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056220');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056238');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056167');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056223');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056237');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056240');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056242');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 403, '14056235');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 404, '14057429');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 404, '14057428');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 405, '14056128');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 406, '14057607');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '13926442');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '13926444');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '14055127');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '13926445');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '14055126');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '14055125');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '13926443');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 407, '13926432');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 408, '14058502');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 408, '14058504');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 408, '14058501');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 408, '14058503');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 409, '13934045');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 409, '13934043');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 409, '13934044');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 409, '13934042');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 410, '13976366');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 411, '14019174');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 411, '14019175');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 411, '14019173');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13984064');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13948666');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13984066');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13948664');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13948663');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13984065');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 412, '13984063');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 413, '13934641');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 413, '13934644');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 413, '13934643');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 413, '13934642');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 413, '13937075');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 414, '13937566');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 415, '14057595');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 416, '14055412');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 416, '14019945');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 416, '14055411');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 416, '14019946');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 416, '14055410');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 417, '14057313');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 418, '13890984');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 418, '13890983');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 418, '13890982');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 419, '13942931');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 419, '13942934');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 419, '13942932');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 419, '13942933');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 420, '14057450');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 420, '14057451');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 421, '14055093');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 421, '14055094');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 421, '14055095');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14019228');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14031690');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14031693');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14057080');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14019227');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14057079');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14031691');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14031692');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 422, '14057078');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 423, '13984087');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 423, '13984089');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 423, '13984088');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 423, '13984086');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 424, '13922255');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 425, '14055017');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 425, '14055016');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 425, '14055023');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 425, '14055021');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 425, '14055022');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984687');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984683');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984681');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984684');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984682');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984685');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 426, '13984686');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 427, '14056416');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 427, '14056415');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 428, '13986768');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 428, '13986766');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 428, '14031696');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 428, '14031695');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 428, '13986767');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '14001398');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '14001400');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '13934698');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '14001397');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '13934699');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '13934697');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '13934696');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 429, '14001399');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13937970');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13937968');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13998556');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13937967');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13998557');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13937966');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13998559');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 430, '13998558');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 431, '14032779');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 431, '14032780');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 432, '14054437');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 432, '14054434');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 432, '14054435');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 432, '14054439');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 433, '14057642');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '13984180');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14054421');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14051006');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14051008');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14054422');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14051007');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14054420');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '13984178');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '13984177');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 434, '14054419');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 435, '13936881');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 435, '13936880');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 435, '13936882');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 435, '13936879');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13984397');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13984399');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13984398');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13927574');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13927575');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13927577');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13984396');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 436, '13927576');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13988592');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13952613');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13952612');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13952614');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13988594');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13988593');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 437, '13988591');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 438, '14054404');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 438, '14054405');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 439, '14050927');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 439, '14050928');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 439, '14051025');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 440, '14055158');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 440, '14055159');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 440, '14032128');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 440, '14032129');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '13934116');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '13937057');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '14055009');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '13934118');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '14055010');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '14055008');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '13934115');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 441, '13934117');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 442, '14020304');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 442, '14055413');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 442, '14055415');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 442, '14055414');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 442, '14020305');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 442, '14020306');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 443, '14054863');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 443, '14018252');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 443, '14018250');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 443, '14018251');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 443, '14054864');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 444, '14058742');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 445, '13922233');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 445, '13922235');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 445, '13922234');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 445, '13922232');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 446, '14033384');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 447, '14055275');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057455');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057446');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057444');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057443');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057454');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057447');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057445');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 448, '14057456');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 449, '14055771');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 449, '14059298');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 449, '14055772');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 449, '14059297');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 449, '14055770');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 450, '14057244');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 450, '14057245');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 451, '14064141');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 452, '14064107');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 453, '14064078');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 454, '14064104');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 455, '14064093');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 456, '14064140');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 457, '14064096');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 458, '14064224');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 459, '14064175');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '14058833');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '13987792');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '13987794');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '13987795');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '14050952');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '13987793');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '14050951');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 460, '14058834');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 461, '14064131');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 462, '14064202');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 463, '14064172');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 464, '14064193');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 465, '14064087');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 466, '14064085');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 467, '14064089');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 468, '14064173');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 469, '14064079');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 470, '14064099');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 471, '13992433');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 472, '13992339');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 473, '13992313');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 474, '14064082');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 475, '14064070');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 476, '13992368');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 477, '13992330');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 478, '13992318');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 479, '14064069');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 480, '13992322');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 481, '14064077');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 482, '13992315');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 483, '13992548');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 484, '14064075');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 485, '13992437');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 486, '13992436');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 487, '13992550');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 488, '14064146');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 489, '13992547');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 490, '13992551');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 491, '13992333');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 492, '13992552');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 493, '13992549');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 494, '13992369');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 495, '14064071');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 496, '13992438');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 497, '13992556');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 498, '14058779');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 499, '14058825');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 499, '14058827');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 500, '14064076');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 501, '13992435');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 502, '14002994');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 503, '14021509');
INSERT INTO exemplares(
           id_titulo, cod_e)
    VALUES ( 504, '14054751');



-- Tabela de Bibliografia
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 520, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 35, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 560, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 174, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 192, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 129, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 95, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 93, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 123, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 326, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 26, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 526, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 39, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 38, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 519, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 332, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 507, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 563, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 331, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (18, 562, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 95, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 35, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 589, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 590, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 138, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 129, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 135, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (15, 134, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 375, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 430, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 401, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 431, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 274, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 382, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 433, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (30, 435, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 75, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 566, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 521, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 565, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 229, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 74, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (100, 265, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 88, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 103, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 104, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 105, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 33, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 543, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 527, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (11, 110, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 514, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 93, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 429, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 423, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 427, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 555, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 426, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (24, 428, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 159, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 226, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 328, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 519, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 155, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 132, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 177, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 144, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 147, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (17, 561, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 523, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 547, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 524, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 516, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 506, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 581, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 548, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 405, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (72, 436, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 100, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 114, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 13, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 550, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 115, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 594, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 551, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 582, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 552, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 119, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (62, 96, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 343, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 399, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 252, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 289, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 515, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 257, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 255, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 254, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (38, 256, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 322, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 511, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 510, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 335, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 311, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 321, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 26, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 530, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (57, 313, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 517, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 570, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 240, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 192, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 123, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 183, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (101, 108, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 185, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 513, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 238, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 153, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 237, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 585, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 586, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (90, 509, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 583, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 505, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 101, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 184, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 129, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 584, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 573, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (65, 517, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (102, 522, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (102, 538, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (102, 539, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (102, 540, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (102, 541, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (102, 542, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 272, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 4, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 379, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 591, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 290, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 267, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 18, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 1, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (99, 2, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 170, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 545, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 546, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 579, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 252, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 255, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (73, 135, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (71, 535, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (71, 49, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (71, 171, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (71, 170, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (71, 571, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 529, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 592, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 564, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 593, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 572, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 10, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 569, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (67, 192, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 98, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 14, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 559, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 40, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 16, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 52, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 96, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (56, 99, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 248, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 568, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 512, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 60, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 249, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 197, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 250, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 369, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 251, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (70, 412, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 574, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 40, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 32, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 52, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 42, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 45, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 109, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (6, 41, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 125, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 90, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 122, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 117, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 128, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 580, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 138, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 127, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (59, 130, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 95, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 518, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 182, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 183, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 99, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 525, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 549, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (64, 82, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 177, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 189, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 166, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 190, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 36, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 231, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 204, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 532, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 174, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (21, 533, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 244, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 528, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 544, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 153, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 236, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 237, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 241, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (12, 240, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 55, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 62, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 536, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 74, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 537, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 60, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 49, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (60, 223, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (103, 587, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (103, 588, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (103, 553, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (103, 554, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (103, 595, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 534, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 19, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 96, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 357, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 578, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 121, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 13, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (61, 572, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 511, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 530, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 311, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 321, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 312, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 26, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 510, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (9, 322, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 19, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 121, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 115, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 114, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 594, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 551, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 98, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 99, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (58, 96, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 575, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 505, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 35, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 127, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 567, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 531, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 576, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (69, 577, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 81, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 152, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 90, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 108, 'Complementar');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 556, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 557, 'Básica');
INSERT INTO bibliografias (id_disciplina, id_titulo, tipo_bibliografia) VALUES (68, 558, 'Básica');
;




-- View para contagem de exeplares por titulos
CREATE VIEW quantidade_exemplares_view AS
SELECT titulos.id_t, COUNT(exemplares.id_titulo)  AS quant_exemplares
FROM titulos LEFT JOIN exemplares ON  titulos.id_t=exemplares.id_titulo
GROUP BY titulos.id_t
HAVING (((COUNT(exemplares.id_titulo))>=0)) 
ORDER BY (titulos.id_t);





REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;