CREATE TABLE misungfoodbilliard (
  seq INT(11) UNSIGNED NOT NULL,
  winner_nm VARCHAR(50) NOT NULL ,
  regist_date DATETIME ,
  PRIMARY KEY (seq,winner_nm)
)
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;


0CREATE TABLE TW_BBS(
no int unsigned not null,	
title varchar(200),
content TEXT,
nm varchar(20),
passw varchar(20),
grp int,
seq int,
lvl int,
hit int,
attach_file_no int ,
regist_id varchar(20),
regist_date DATETIME ,
primary key(no)
);

CREATE INDEX idx_tw_bbs01 ON tw_bbs (grp);
--ALTER TABLE tw_bbs DROP INDEX idx_tw_bbs01;


CREATE TABLE tw_file (
  attach_file_no int NOT NULL,
  attach_file_seq  int NOT NULL,
  orginal_file_nm VARCHAR(200) NOT NULL,
  stored_file_nm VARCHAR(50) NOT NULL,
  file_size int,
  regist_date datetime NOT NULL,
  use_yn char(1) DEFAULT NULL,
  PRIMARY KEY (attach_file_no,attach_file_seq)
) ;