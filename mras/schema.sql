DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS portfolio;
DROP TABLE IF EXISTS bids;
DROP TABLE IF EXISTS job_request;


CREATE TABLE user (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(11),
    email VARCHAR(100),
    username VARCHAR UNIQUE NOT NULL,
    password VARCHAR NOT NULL
);


CREATE TABLE portfolio (
    portfolio_id SERIAL PRIMARY KEY,
    portfolio_url VARCHAR(255),
    CONSTRAINT FK_user FOREIGN KEY(user_id)
                       REFERENCES user(user_id),
);


CREATE TABLE bids (
    bid_id SERIAL PRIMARY KEY,
    price NUMERIC(6,2) NOT NULL,
    body VARCHAR NOT NULL,
    drafted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    submitted TIMESTAMP,
    CONSTRAINT FK_user FOREIGN KEY(user_id)
                  REFERENCES user(user_id),
    CONSTRAINT FK_job FOREIGN KEY(request_id)
                  REFERENCES job_request(request_id)
);


CREATE TABLE job_request (
    request_id SERIAL PRIMARY KEY,
    author_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(100) NOT NULL,
    body VARCHAR(255) NOT NULL,
    request_document_url VARCHAR(255),
    CONSTRAINT FK_user FOREIGN KEY(user_id)
                         REFERENCES user(user_id)
);