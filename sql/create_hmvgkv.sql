CREATE DATABASE IF NOT EXISTS hmvdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hmvdb;

/*
-- Format of (YYYYMMDD_HMV.xml):
-- <hv:GRUPPE>13</hv:GRUPPE>
--        <hv:ORT>20</hv:ORT>
--        <hv:UNTERGRUPPE>3</hv:UNTERGRUPPE>
--        <hv:ART>5</hv:ART>
--        <hv:PRODUKT>151</hv:PRODUKT>

-- Usabele HMV Number:
-- HMV: <hv:GRUPPE>.<hv:ORT>.<hv:UNTERGRUPPE>.<hv:ART><hv:PRODUKT>
*/

DROP TABLE IF EXISTS hmvgkv;

CREATE TABLE hmvgkv ( 
	hv_GRUPPE TINYINT, -- 13
	hv_ORT TINYINT, -- 20
	hv_UNTERGRUPPE TINYINT, -- 01,02,03,08,12,14,...
	hv_ART TINYINT, -- 0-9
	hv_PRODUKT SMALLINT, -- 000-999 (lfd)
	hv_BEZEICHNUNG text, -- Model
	hv_HERSTELLER tinytext, -- Vendor
	hv_MERKMALE text, -- Description
	hv_AUFNAHMEDATUM date,
	hv_AENDERUNGSDATUM date,
	created TIMESTAMP
	);
    
LOAD XML LOCAL INFILE 'C:\\project\\source\\gkv\\20180302_HMV\\20180323_HMV_2.xml'
	INTO TABLE hmvdb.hmvgkv
	CHARACTER SET utf8mb4
	ROWS IDENTIFIED BY '<hv_HMV_PRODUKT>'
	;
