import xml.etree.cElementTree as ET
data = ET.parse('C:\project\Signia_test.XML')

# create element tree object 
tree = ET.parse(data) 
  
# get root element 
root = tree.getroot() 
#pi:ProductCatalog/pi:BrandCollection/pi:Brand/pi:ProductGroups/pi:HearingAids/ha:Family/ha:ModelCollection/ha:Model
# ha:Name -> Name
# - ha:BatterySize -> Batt (BuildIn)
# - ha:BatteryConsumption -> BattAmp (1.4mA)
#   - ha:Condition -> Variant (S Hörer)
# - ha:BatteryConsumption -> BattAmp (1.4mA)
# - ha:MaxGain -> Vmax (60dB)
# - ha:MaxOutput -> LAmax (119dB)
# - pi:InformationResourceLink -> Link



ns = {'pi': 'http://www.himsa.com/ProductInformation',
      'ald': 'http://www.himsa.com/ProductInformation/AssistedListeningDevices:',
      'con': 'http://www.himsa.com/ProductInformation/Consumable',
      'fe': 'http://www.himsa.com/ProductInformation/FittingEquipment',
      'ha': 'http://www.himsa.com/ProductInformation/HearingAid',
      'haa': 'http://www.himsa.com/ProductInformation/HearingAidAccessory',
      'hasp': 'http://www.himsa.com/ProductInformation/HearingAidSparePart',
      'info': 'http://www.himsa.com/ProductInformation/Information',
      'rr': 'http://www.himsa.com/ProductInformation/RICReceiver', 
      'sup': 'http://www.himsa.com/ProductInformation/Supply',
      'xsi': 'http://www.w3.org/2001/XMLSchema-instance',
      'gc': 'http://www.himsa.com/ProductInformation/GenericCapability',
      } #'schemaLocation': 'http://www.himsa.com/ProductInformation ../../ProductCatalog.xsd'}

# create empty list for news items 
newsitems = [] 
  
# iterate news items 
for item in root.findall('./pi:ProductCataog/pi:BrandCollection/pi:brand'): 
  
    # empty news dictionary 
    news = {} 
  
    # iterate child elements of item 
    for child in item: 
  
        # special checking for namespace object content:media 
        if child.tag == '{http://www.himsa.com/ProductInformation/HearingAid}name': 
            news['media'] = child.attrib['url'] 
        else: 
            news[child.tag] = child.text.encode('utf8') 
  
    # append news dictionary to news items list 
    newsitems.append(news) 
      
# return news items list 
    print(newsitems) 