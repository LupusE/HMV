/*
Update:
- Load Excel from: https://www.signia-pro.de/hmv-nummern/
- Open file and 'Save as'
- select 'csv' as Output format
 */
USE hmvdb;

DROP TABLE IF EXISTS article_siv;

CREATE TABLE article_siv ( 
    family varchar(20),
    device text,
    artno INT,
    hmv varchar(75),
    bg varchar(50), -- DECIMAL(6,2),
    src varchar(20),
    created TIMESTAMP
    )
    DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci
    ;

LOAD DATA LOCAL INFILE 'C:\\project\\source\\sivantos\\Liste-Neue-HMV-Nummern-BG-Gruppen-20180208.csv'
	INTO TABLE hmvdb.article_siv
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 8 LINES (family, device, artno, hmv, bg, @src)
    SET src = 'sivantos'
	;