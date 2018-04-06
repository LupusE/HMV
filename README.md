# HMV
Working with HMV (HilfsMittelVerzeichnis).


A Hearing Aid is developed by the vendor and checked by the higher authority. If the hearing aid meet the requirements it will get a HMV number and the health insurance (Krankenkasse) will pay a fixed amount, based on a prescription (Verordnung) from a doctor.

Further information:
https://de.wikipedia.org/wiki/Hilfsmittelverzeichnis_der_gesetzlichen_Krankenversicherung
http://www.dhi-online.de/DhiNeu/06_Hmv/Pg13_2_gliederung.html

The Information, provided by the gKV (gesetzliche KrankenVersicherer), is not useable for process automation.
A List in XML Format is provided at:
https://www.gkv-datenaustausch.de/leistungserbringer/sonstige_leistungserbringer/positionsnummernverzeichnisse/positionsnummernverzeichnisse.jsp
Just search for the latest 'Bundeseinheitliches Hilfsmittel- und Pflegehilfsmittelverzeichnis (ZIP, 4,1 MB)' (unpacked >50MB).

Because I can't find a way to use MySQL 'LOAD XML' to handle <hv:...> Tags, you'll need to 'Search and replace' in any editor and change '<hv:' to '<hv_'.

https://github.com/LupusE/HMV/blob/master/sql/create_hmvgkv.sql
- create a database, if not existing
- drop table, if existing
- create the clean table
- load data into the table

https://github.com/LupusE/HMV/blob/master/sql/select_hmv.sql
- Limit result to only hearing aid
- CONCAT the HMV Number to usabele format
- Extract data from hv:MERKMALE to various fields


The second public available Source is the HMv Nuber List from the vendor sivantos.

https://github.com/LupusE/HMV/blob/master/sql/create_sivantos.sql
- drop table if exist
- create clean table
- load data in table
