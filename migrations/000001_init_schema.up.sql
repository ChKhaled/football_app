
CREATE TABLE players (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    second_name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    rating DOUBLE PRECISION NOT NULL DEFAULT 50
        CHECK (rating >= 0)
);

CREATE TABLE matches (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    played_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE match_teams (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    match_id BIGINT NOT NULL
        REFERENCES matches(id) ON DELETE CASCADE,
    side VARCHAR(1) NOT NULL CHECK (side IN ('A', 'B')),
    score INTEGER NOT NULL DEFAULT 0 CHECK (score >= 0),

    UNIQUE (match_id, side)
);

CREATE TABLE player_match_teams (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id BIGINT NOT NULL
        REFERENCES players(id) ON DELETE RESTRICT,
    match_team_id BIGINT NOT NULL
        REFERENCES match_teams(id) ON DELETE CASCADE,

    UNIQUE (player_id, match_team_id)
);

CREATE TABLE stats (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_match_team_id BIGINT NOT NULL UNIQUE
        REFERENCES player_match_teams(id) ON DELETE CASCADE,

    goals INTEGER NOT NULL DEFAULT 0 CHECK (goals >= 0),
    assists INTEGER NOT NULL DEFAULT 0 CHECK (assists >= 0),
    shots INTEGER NOT NULL DEFAULT 0 CHECK (shots >= 0),
    passes INTEGER NOT NULL DEFAULT 0 CHECK (passes >= 0),
    tackles INTEGER NOT NULL DEFAULT 0 CHECK (tackles >= 0),
    interceptions INTEGER NOT NULL DEFAULT 0 CHECK (interceptions >= 0),
    recoveries INTEGER NOT NULL DEFAULT 0 CHECK (recoveries >= 0),
    saves INTEGER NOT NULL DEFAULT 0 CHECK (saves >= 0),
    fouls INTEGER NOT NULL DEFAULT 0 CHECK (fouls >= 0)
);

CREATE INDEX idx_player_match_teams_player
    ON player_match_teams(player_id);

CREATE INDEX idx_match_teams_match
    ON match_teams(match_id);