CREATE TABLE IF NOT EXISTS votes (
    id SERIAL PRIMARY KEY,
    candidate VARCHAR(100) UNIQUE NOT NULL,
    count INT DEFAULT 0
);

INSERT INTO votes (candidate, count)
VALUES
('Candidate A', 0),
('Candidate B', 0)
ON CONFLICT (candidate) DO NOTHING;