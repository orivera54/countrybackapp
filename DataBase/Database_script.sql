CREATE TABLE log_use_app (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    request_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    num_countries_returned INTEGER NOT NULL,
    countries_details JSONB NOT NULL
);