-- -------------- PREPARE Start --------------
--CREATE DATABASE OPENXMLTesting
--GO

--USE OPENXMLTesting
--GO

--CREATE TABLE XMLwithOpenXML
--(Id INT IDENTITY PRIMARY KEY, XMLData XML, LoadedDateTime DATETIME)

--INSERT INTO XMLwithOpenXML(XMLData, LoadedDateTime)
--SELECT CONVERT(XML, BulkColumn) AS BulkColumn, GETDATE() 
--	FROM OPENROWSET(BULK 'C:\project\Signia_test.XML', SINGLE_BLOB) AS x;
-- -------------- PREPARE END --------------

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR(MAX)
SELECT @XML = XMLData FROM XMLwithOpenXML

EXEC sp_xml_preparedocument @hDoc OUTPUT
						   ,@XML
						   ,'<ROOT xmlns:pi="http://www.himsa.com/ProductInformation" xmlns:ald="http://www.himsa.com/ProductInformation/AssistedListeningDevices" xmlns:con="http://www.himsa.com/ProductInformation/Consumable" xmlns:fe="http://www.himsa.com/ProductInformation/FittingEquipment" xmlns:ha="http://www.himsa.com/ProductInformation/HearingAid" xmlns:haa="http://www.himsa.com/ProductInformation/HearingAidAccessory" xmlns:hasp="http://www.himsa.com/ProductInformation/HearingAidSparePart" xmlns:info="http://www.himsa.com/ProductInformation/Information" xmlns:rr="http://www.himsa.com/ProductInformation/RICReceiver" xmlns:sup="http://www.himsa.com/ProductInformation/Supply" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gc="http://www.himsa.com/ProductInformation/GenericCapability" xsi:schemaLocation="http://www.himsa.com/ProductInformation ../../ProductCatalog.xsd"/>'

 SELECT *
--	 text
--	,(SELECT text WHERE parentid = id)
	--HA_Name, CustomerName, Address
	FROM OPENXML(@hDoc, '/pi:ProductCatalog/pi:BrandCollection/pi:Brand/pi:ProductGroups')
	--WITH (HA_Name [varchar](50) '@pi:Brand' )--,
	--WITH (LastModifiedDate [varchar](100) '@pi:LastModifiedDate')

	WHERE parentid IN (42, 124351, 40, 39)
	   OR id IN(42, 124351, 40, 39)


EXEC sp_xml_removedocument @hDoc
GO