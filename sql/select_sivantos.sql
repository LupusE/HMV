SELECT
	family
    ,device
    
    /*** Tidy Colors **/
    /*
	,(substring_index(substring_index(substring_index(substring_index(substring_index(substring_index(substring_index(substring_index(substring_index(substring_index(substring_index(device,
     ' Silber', 1),' Schwarz', 1),' Perlweiss', 1),' Grau', 1),' Granit', 1),' DunkelBraun', 1)
     ,' Dunkelgranit', 1),' dunkelBraun', 1),' Dunkelblond', 1),' Champagner', 1),' Beige', 1)) AS device
    ,(CASE WHEN device LIKE '%Silber%' THEN 'Silber'
           WHEN device LIKE '%Schwarz%' THEN 'Schwarz'
           WHEN device LIKE '%Perlweiss%' OR device LIKE '%Perlwei%' THEN 'Perlweiss'
           WHEN device LIKE '%Grau%' THEN 'Grau'
           WHEN device LIKE '%Dunkelgranit%' THEN 'Dunkelgranit'
		   WHEN device LIKE '%Granit%' THEN 'Granit'
           WHEN device LIKE '%Granit%' THEN 'Granit'
           WHEN device LIKE '%Dunkelbraun%' THEN 'Dunkelbraun'
           WHEN device LIKE '%Dunkelblond%' THEN 'Dunkelblond'
           WHEN device LIKE '%Champagner%' THEN 'Champagner'
           ELSE NULL END) AS color
     */
	,artno
	,CASE WHEN length(hmv) <= 14
		  THEN hmv
		  ELSE NULL END AS hmv
	,CASE WHEN length(hmv) > 14
		  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hmv,'S: ',-1),'M: ',1)))
		  ELSE NULL END AS S_Hoerer
	,CASE WHEN length(hmv) > 14
		  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hmv,'M: ',-1),'P: ',1)))
		  ELSE NULL END AS M_Hoerer
	,CASE WHEN length(hmv) > 14
		  THEN (TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(hmv,'HP: ',1),'P: ',-1)))
		  ELSE NULL END AS P_Hoerer
	,CASE WHEN length(hmv) > 14
		  THEN (TRIM(SUBSTRING_INDEX(hmv,'HP: ',-1)))
		  ELSE NULL END AS HP_Hoerer
	,bg
	,created

	FROM article_siv as siv

	WHERE /* device LIKE ('%motion%13%')
      AND */ device NOT LIKE '%Tinnit%'

/* 
 WHERE hoersystem NOT LIKE ('%silber%') AND
hoersystem NOT LIKE ('%dunkelblond%') AND
hoersystem NOT LIKE ('%perlweiss%') AND hoersystem NOT LIKE ('%perlwei%') AND
hoersystem NOT LIKE ('%grau%') AND
hoersystem NOT LIKE ('%granit%') AND
hoersystem NOT LIKE ('%goldblond%') AND
hoersystem NOT LIKE ('%champagner%') AND hoersystem NOT LIKE ('%cmpagner%') AND
hoersystem NOT LIKE ('%dunkelgranit%') AND
hoersystem NOT LIKE ('%dunkelbraun%') AND
hoersystem NOT LIKE ('%schwarz%') AND
hoersystem NOT LIKE ('%beige%') AND
hoersystem NOT LIKE ('%dunkelbraun - dunkles granit%') AND
hoersystem NOT LIKE ('%grau - dunkles granit%') AND
hoersystem NOT LIKE ('%silber - dunkles granit%') AND
hoersystem NOT LIKE ('%dunkles granit%') AND
hoersystem NOT LIKE ('%schwarz - dunkles granit%') AND
hoersystem NOT LIKE ('%rot%') AND
hoersystem NOT LIKE ('%elegance%') AND
hoersystem NOT LIKE ('%galactic blue%') AND
hoersystem NOT LIKE ('%cherry pink%') AND
hoersystem NOT LIKE ('%spirit%') AND
hoersystem NOT LIKE ('%braun%') AND
hoersystem NOT LIKE ('%deep reed%') AND
hoersystem NOT LIKE ('%candy pink%') */
