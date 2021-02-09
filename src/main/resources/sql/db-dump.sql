--CREATE DATABASE myBlog;

DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS article CASCADE;
DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS comment CASCADE;

DROP SEQUENCE IF EXISTS id_category_seq;
DROP SEQUENCE IF EXISTS id_article_seq;
DROP SEQUENCE IF EXISTS id_account_seq;
DROP SEQUENCE IF EXISTS id_comment_seq;
DROP INDEX IF EXISTS id_account_comment_index;
DROP INDEX IF EXISTS id_article_comment_index;

CREATE SEQUENCE IF NOT EXISTS id_account_seq START WITH 1 increment by 1;
CREATE SEQUENCE IF NOT EXISTS id_comment_seq START WITH 1 increment by 1;

CREATE TABLE IF NOT EXISTS category (
    id INTEGER NOT NULL UNIQUE,
    name VARCHAR (20) NOT NULL,
    url VARCHAR (20) NOT NULL UNIQUE,
    articles INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT id_category_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS article (
    id BIGINT NOT NULL UNIQUE,
    title VARCHAR (255) NOT NULL,
    url VARCHAR (255) NOT NULL,
    logo VARCHAR (255) NOT NULL,
    describe VARCHAR (255) NOT NULL,
    content TEXT NOT NULL,
    id_category INTEGER NOT NULL REFERENCES category(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    created TIMESTAMP NOT NULL DEFAULT now(),
    views BIGINT NOT NULL DEFAULT 0,
    comments INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT id_article_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT  EXISTS account (
    id BIGINT NOT NULL DEFAULT nextval('id_account_seq'::regclass),
    email VARCHAR (100) NOT NULL UNIQUE,
    name VARCHAR (30) NOT NULL,
    avatar VARCHAR (255),
    created TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT id_account_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS comment (
    id BIGINT NOT NULL DEFAULT nextval('id_comment_seq'::regclass),
    id_account BIGINT NOT NULL REFERENCES account(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    id_article BIGINT NOT NULL REFERENCES article(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    content TEXT NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT id_comment_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS id_account_comment_index ON comment(id_account);
CREATE INDEX IF NOT EXISTS id_article_comment_index ON comment(id_article);
CREATE INDEX IF NOT EXISTS id_category_article_index ON article(id_category);

COMMIT;