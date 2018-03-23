USE hmvdb;
SELECT
     CONCAT(hv_GRUPPE,".",LPAD(hv_ORT,2,'0'),".",LPAD(hv_UNTERGRUPPE,2,'0'),".",hv_ART,LPAD(hv_PRODUKT,3,'0')) AS HMV
    ,TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_BEZEICHNUNG,'Art.-Nr.:',1),'Art.-Nr.',1),'Art.-Nrn.',1),'Art.-Nr',1),'Art-Nr.',1),'Art-Nrn.', -1)) AS description
    ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_BEZEICHNUNG,'Art.-Nr.:',-1),'Art.-Nr.',-1),'Art.-Nrn.',-1),'Art.-Nr',-1),'Art-Nr.',-1),'Art-Nrn.', -1))) <> hv_BEZEICHNUNG
		  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_BEZEICHNUNG,'Art.-Nr.:',-1),'Art.-Nr.',-1),'Art.-Nrn.',-1),'Art.-Nr',-1),'Art-Nr.',-1),'Art-Nrn.', -1)))
          ELSE NULL END AS artno
    ,hv_HERSTELLER
    ,hv_AUFNAHMEDATUM
    ,hv_AENDERUNGSDATUM
		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Bauform:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Bauform:',-1),'&#xd;',1)))
			ELSE NULL END AS bauform
		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Bauart-Nr.:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Bauart-Nr.:',-1),'&#xd;',1)))
			ELSE NULL END AS bauartnr
 		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Schutzklasse:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Schutzklasse:',-1),'&#xd;',1)))
			ELSE NULL END AS schutzkl
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Anzahl der Kanäle:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Anzahl der Kanäle:',-1),'&#xd;',1)))
			ELSE NULL END AS kanaele

/***
***		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
***			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkung:',-1),'&#xd;',1)))
***			  ELSE NULL END AS verst
***/
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX((SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkung:',-1),'&#xd;',1)),'dB',1)))
			ELSE NULL END AS V_dB
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX((SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkung:',-1),'&#xd;',1)),'bei',-1),'kHz',1)))
			ELSE NULL END AS V_kHz
            
            
-- 		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'OSPL 90:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
-- 			THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'OSPL 90:',-1),'&#xd;',1))
-- 			ELSE NULL END AS ospl90
-- 		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'schalldruckpegel:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
-- 			THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'schalldruckpegel:',-1),'&#xd;',1))
-- 			ELSE NULL END AS db_max
		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'OSPL 90:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'OSPL 90:',-1),'&#xd;',1)))
              WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'schalldruckpegel:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'schalldruckpegel:',-1),'&#xd;',1)))
			ELSE NULL END AS max_out
		
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Signalverarbeitung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Signalverarbeitung:',-1),'&#xd;',1)))
            ELSE NULL END AS signverab
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Mikrofone:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Mikrofone:',-1),'&#xd;',1)))
            ELSE NULL END AS mikro
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Mikrofonsystem:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Mikrofonsystem:',-1),'&#xd;',1)))
            ELSE NULL END AS mikrosys
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Ausgangsschalldruckbegrenzung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Ausgangsschalldruckbegrenzung:',-1),'&#xd;',1)))
            ELSE NULL END AS limiter
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Einstellbare Parameter:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Einstellbare Parameter:',-1),'&#xd;',1)))
			ELSE NULL END AS param 
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkungsregelung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Verstärkungsregelung:',-1),'&#xd;',1)))
            ELSE NULL END AS regelung 
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'transponierende Software:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'transponierende Software:',-1),'&#xd;',1)))
            ELSE NULL END AS tanspsw 
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Rückkopplungsauslöschung:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Rückkopplungsauslöschung:',-1),'&#xd;',1)))
            ELSE NULL END AS rk_mgmt 
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Batterietyp:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Batterietyp:',-1),'&#xd;',1)))
            ELSE NULL END AS batt
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Telefonspule:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))  
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Telefonspule:',-1),'&#xd;',1)))
            ELSE NULL END AS tcoil
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Audioeingang:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Audioeingang:',-1),'&#xd;',1)))
			  WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Audioeingang (DAI):',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Audioeingang (DAI):',-1),'&#xd;',1)))
			ELSE NULL END AS DAI
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Fernbedienung optional:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Fernbedienung optional:',-1),'&#xd;',1)))
            ELSE NULL END AS remote
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Wireless:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Wireless:',-1),'&#xd;',1)))
            ELSE NULL END AS wireless
		,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Programme möglich:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Programme möglich:',-1),'&#xd;',1)))
            ELSE NULL END AS programme
        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'transponierende Software:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
			  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'transponierende Software:',-1),'&#xd;',1)))
			ELSE NULL END AS freq_komp
            
-- ### NEED further testing!! #########################################################################
        ,CASE WHEN TRIM(LEFT((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)),INSTR((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)), '&#xd;\n') - 1)) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN TRIM(LEFT((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)),INSTR((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)), '&#xd;\n') - 1))
              WHEN TRIM(LEFT((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)),INSTR((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)), '&#xd;\n') - 1)) = '-'
              THEN NULL
            ELSE NULL END AS baugleich
        ,CAST((LENGTH(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1),'Anzahl der Kanäle:',1)))
        - LENGTH(REPLACE(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1),'Anzahl der Kanäle:',1)), '&#xd;', '')))/5 AS SIGNED) AS anzahl
        
 -- 	,SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1) AS TESTSTART
 		,INSTR(SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1), '&#xd;\n')/*+CHAR(10)+CHAR(32)*/
 			AS TSTCNT
-- 		,TRIM(LEFT((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)),INSTR((SUBSTRING_INDEX(hv_MERKMALE,'Gerät baugleich mit:',-1)), '&#xd;\n') - 1))
-- 			AS TESTEND
-- ###################################################################################################

        ,CASE WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'Sonstige Ausstattungen:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1))
			  THEN (TRIM(SUBSTRING_INDEX(hv_MERKMALE,'Sonstige Ausstattungen:',-1)))
              WHEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hv_MERKMALE,'sonstige Merkmale gemäß Herstellerangaben:',-1),'&#xd;',1))) <> TRIM(SUBSTRING_INDEX(hv_MERKMALE,'&#xd;',1)) 
              THEN (TRIM(SUBSTRING_INDEX(hv_MERKMALE,'sonstige Merkmale gemäß Herstellerangaben:',-1)))
			ELSE NULL END AS sonstiges
	
    ,hv_MERKMALE
	,LENGTH(hv_MERKMALE) AS ZEICHEN

    FROM hmvdb.hmvgkv AS gkv

-- 	WHERE CONCAT(hv_GRUPPE,".",LPAD(hv_ORT,2,'0'),".",LPAD(hv_UNTERGRUPPE,2,'0'),".",hv_ART,LPAD(hv_PRODUKT,3,'0'))
-- 	  = '13.20.10.0322'	

   WHERE hv_GRUPPE = '13' AND hv_ORT = '20'
	 AND hv_UNTERGRUPPE IN ('12', '10', '14')

	/* Zubehör/Übertragungsanlagen */
-- 	WHERE hv_GRUPPE = '13' AND hv_ORT = '99' AND hv_UNTERGRUPPE IN ('03')

    
--  AND siv.sachnummer IS NOT NULL
-- 	AND hv_BEZEICHNUNG LIKE '%CROS%'
--  AND hv_BEZEICHNUNG LIKE 'siemens%' ORDER BY hv_BEZEICHNUNG
--  AND hv_HERSTELLER LIKE ('Sivantos GmbH')
    AND hv_BEZEICHNUNG LIKE '%cellion%'  

--  ORDER BY hv_AUFNAHMEDATUM DESC
        ;
