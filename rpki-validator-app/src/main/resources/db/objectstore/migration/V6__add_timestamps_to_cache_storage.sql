BEGIN;

DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS repo_objects;
DROP TABLE IF EXISTS broken_objects;

CREATE TABLE certificates (
  ski             CHARACTER VARYING(40)   NOT NULL,
  aki             CHARACTER VARYING(40)   NOT NULL,
  hash            CHARACTER VARYING(64)   NOT NULL,
  url             CHARACTER VARYING(2000) NOT NULL,
  encoded         BYTEA                   NOT NULL,
  download_time   TIMESTAMP               NOT NULL DEFAULT NOW(),
  validation_time TIMESTAMP,
  PRIMARY KEY (aki, url)
);

-- All the other objects
CREATE TABLE repo_objects (
  aki             CHARACTER VARYING(40)   NOT NULL,
  hash            CHARACTER VARYING(64)   NOT NULL,
  url             CHARACTER VARYING(2000) NOT NULL,
  object_type     CHARACTER VARYING(10)   NOT NULL,
  encoded         BYTEA                   NOT NULL,
  download_time   TIMESTAMP               NOT NULL DEFAULT NOW(),
  validation_time TIMESTAMP,
  PRIMARY KEY (aki, url),
  CHECK (object_type IN ('crl', 'manifest', 'roa'))
);

CREATE TABLE broken_objects (
  hash          CHARACTER VARYING(64)   NOT NULL,
  url           CHARACTER VARYING(2000) NOT NULL,
  encoded       BYTEA                   NOT NULL,
  message       CHARACTER VARYING(2000) NOT NULL,
  download_time TIMESTAMP               NOT NULL DEFAULT NOW(),
  PRIMARY KEY (url)
);

CREATE INDEX idx_certificates_aki ON certificates (aki);
CREATE INDEX idx_certificates_ski ON certificates (ski);
CREATE INDEX idx_repo_obj_aki ON repo_objects (aki);
CREATE INDEX idx_repo_obj_aki_type ON repo_objects (aki, object_type);
CREATE INDEX idx_broken_obj_url ON broken_objects (url);

COMMIT;
