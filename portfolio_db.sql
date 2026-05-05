-- ============================================================
--  portfolio_db.sql
--  Dynamic Personal Portfolio Website
--  Author: Soumasish Dasgupta
-- ============================================================

CREATE DATABASE IF NOT EXISTS portfolio_db;

USE portfolio_db;


-- ------------------------------------------------------------
-- TABLE 1: users
-- Stores admin/owner login credentials
-- ------------------------------------------------------------
CREATE TABLE users (
    id            INT             NOT NULL AUTO_INCREMENT,
    username      VARCHAR(50)     NOT NULL UNIQUE,
    email         VARCHAR(100)    NOT NULL UNIQUE,
    password_hash VARCHAR(255)    NOT NULL,
    created_at    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_users PRIMARY KEY (id)
);


-- ------------------------------------------------------------
-- TABLE 2: about
-- Stores the portfolio owner's bio and stat counters
-- ------------------------------------------------------------
CREATE TABLE about (
    id             INT           NOT NULL AUTO_INCREMENT,
    user_id        INT           NOT NULL,
    tagline        VARCHAR(150)  NOT NULL,
    bio            TEXT          NOT NULL,
    profile_img    VARCHAR(255)  DEFAULT 'assets/images/profile.jpg',
    clients        INT           NOT NULL DEFAULT 0,
    projects_count INT           NOT NULL DEFAULT 0,
    years_exp      INT           NOT NULL DEFAULT 0,
    CONSTRAINT pk_about    PRIMARY KEY (id),
    CONSTRAINT fk_about_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ------------------------------------------------------------
-- TABLE 3: skills
-- One row per skill; grouped by category
-- ------------------------------------------------------------
CREATE TABLE skills (
    id                INT           NOT NULL AUTO_INCREMENT,
    user_id           INT           NOT NULL,
    name              VARCHAR(100)  NOT NULL,
    category          VARCHAR(50)   NOT NULL,   -- e.g. Languages / Frontend / Backend
    proficiency_level TINYINT       NOT NULL DEFAULT 80
                          CHECK (proficiency_level BETWEEN 1 AND 100),
    CONSTRAINT pk_skills PRIMARY KEY (id),
    CONSTRAINT fk_skills_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ------------------------------------------------------------
-- TABLE 4: projects
-- One row per project
-- ------------------------------------------------------------
CREATE TABLE projects (
    id          INT             NOT NULL AUTO_INCREMENT,
    user_id     INT             NOT NULL,
    title       VARCHAR(150)    NOT NULL,
    description TEXT            NOT NULL,
    tech_stack  VARCHAR(255)    NOT NULL,   -- comma-separated tags
    github_url  VARCHAR(255)    DEFAULT NULL,
    live_url    VARCHAR(255)    DEFAULT NULL,
    featured    TINYINT(1)      NOT NULL DEFAULT 0,
    cover_image VARCHAR(500)    DEFAULT NULL,
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_projects PRIMARY KEY (id),
    CONSTRAINT fk_projects_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ------------------------------------------------------------
-- TABLE 5: education
-- One row per qualification
-- ------------------------------------------------------------
CREATE TABLE education (
    id          INT           NOT NULL AUTO_INCREMENT,
    user_id     INT           NOT NULL,
    institution VARCHAR(200)  NOT NULL,
    degree      VARCHAR(100)  NOT NULL,
    field       VARCHAR(100)  NOT NULL,
    start_year  YEAR          NOT NULL,
    end_year    YEAR          DEFAULT NULL,   -- NULL means ongoing
    gpa         DECIMAL(3,1)  DEFAULT NULL,
    percentage  DECIMAL(5,2)  DEFAULT NULL,
    CONSTRAINT pk_education PRIMARY KEY (id),
    CONSTRAINT fk_education_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ------------------------------------------------------------
-- TABLE 6: messages
-- Stores contact form submissions
-- ------------------------------------------------------------
CREATE TABLE messages (
    id       INT           NOT NULL AUTO_INCREMENT,
    name     VARCHAR(100)  NOT NULL,
    email    VARCHAR(100)  NOT NULL,
    message  TEXT          NOT NULL,
    sent_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_read  TINYINT(1)    NOT NULL DEFAULT 0,
    CONSTRAINT pk_messages PRIMARY KEY (id)
);


-- ============================================================
--  SAMPLE RECORDS
-- ============================================================

-- ------------------------------------------------------------
-- users  (password_hash is BCrypt of "Admin@123")
-- ------------------------------------------------------------
INSERT INTO users (username, email, password_hash) VALUES
(
    'soumasish',
    'dasguptasoumasish@gmail.com',
    '$2a$12$WK3GKOJhuH5Dq892tvt3H.GbZNikSDjsGGScdVHrO1MBCYLnChk6q'
);

-- ------------------------------------------------------------
-- about
-- ------------------------------------------------------------
INSERT INTO about (user_id, tagline, bio, profile_img, clients, projects_count, years_exp) VALUES
(
    1,
    'Turning Vision Into Reality With Code And Design.',
    'Hi, I''m Soumasish Dasgupta, a Full-Stack Developer and AI Enthusiast with a passion '
    'for creating beautiful, functional, and intelligent web applications. '
    'I am a B.Tech Computer Science student at Techno India University, Kolkata, '
    'with hands-on experience in React, Node.js, TypeScript, and GraphQL. '
    'I believe great software is built at the intersection of clean engineering '
    'and thoughtful design. I look forward to bringing my skills and passion '
    'to your next project.',
    'assets/images/profile.jpg',
    5,
    10,
    2
);

-- ------------------------------------------------------------
-- skills
-- ------------------------------------------------------------
INSERT INTO skills (user_id, name, category, proficiency_level) VALUES
(1, 'JavaScript',    'Languages',  90),
(1, 'TypeScript',    'Languages',  85),
(1, 'Java',          'Languages',  80),
(1, 'Python',        'Languages',  80),
(1, 'C',             'Languages',  70),
(1, 'C++',           'Languages',  70),
(1, 'HTML',          'Languages',  95),
(1, 'CSS',           'Languages',  90),
(1, 'React',         'Frontend',   90),
(1, 'Vite',          'Frontend',   75),
(1, 'GraphQL',       'Frontend',   70),
(1, 'Node.js',       'Backend',    85),
(1, 'Express.js',    'Backend',    80),
(1, 'MongoDB',       'Databases',  80),
(1, 'MySQL',         'Databases',  75),
(1, 'Supabase',      'Databases',  70),
(1, 'AWS',           'Cloud/DevOps', 75),
(1, 'Docker',        'Cloud/DevOps', 70),
(1, 'Firebase',      'Cloud/DevOps', 72),
(1, 'Git',           'Tools',      90),
(1, 'Figma',         'Tools',      75),
(1, 'scikit-learn',  'ML/AI',      72),
(1, 'TensorFlow',    'ML/AI',      68);

-- ------------------------------------------------------------
-- projects
-- ------------------------------------------------------------
INSERT INTO projects (user_id, title, description, tech_stack, github_url, live_url, featured) VALUES
(
    1,
    'Multithreaded HTTP Server',
    'A production-grade multithreaded HTTP server built from scratch in Java, capable of '
    'handling concurrent GET/POST requests, static file serving, and user-agent detection. '
    'Implements thread pooling, socket programming, and raw HTTP protocol parsing '
    'without any external frameworks.',
    'Java, Networking, Concurrency, Socket Programming',
    'https://github.com/Soumasish2005/http-server',
    NULL,
    1
),
(
    1,
    'Brand-Spark',
    'An AI-powered brand identity web application that generates unique logos and branding '
    'descriptions for businesses. Integrates generative AI APIs into a TypeScript/React '
    'frontend backed by a Node.js service, enabling instant brand creation for any project.',
    'TypeScript, React, Node.js, AI APIs',
    'https://github.com/Soumasish2005/brand-spark',
    NULL,
    1
),
(
    1,
    'Hades — AI Cybersecurity Agent',
    'Frontend and UI/UX for an AI-powered cybersecurity agent platform targeting red teamers '
    'and bug bounty hunters. Built with React/Next.js and TypeScript, integrating with a '
    'FastAPI backend to surface AI-driven pentesting and vulnerability assessment workflows.',
    'React, Next.js, TypeScript, Figma, FastAPI',
    'https://github.com/Soumasish2005/hades',
    NULL,
    0
);

-- ------------------------------------------------------------
-- education
-- ------------------------------------------------------------
INSERT INTO education (user_id, institution, degree, field, start_year, end_year, gpa) VALUES
(
    1,
    'Techno India University, Kolkata',
    'Bachelor of Technology',
    'Computer Science and Engineering',
    2023,
    2027,
    9.8
);

-- ------------------------------------------------------------
-- messages  (a sample test message)
-- ------------------------------------------------------------
INSERT INTO messages (name, email, message) VALUES
(
    'Test User',
    'test@example.com',
    'Hi Soumasish, I came across your portfolio and would love to discuss a potential project. '
    'Please get in touch at your earliest convenience.'
);