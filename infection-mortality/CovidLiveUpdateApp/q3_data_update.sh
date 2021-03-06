#!/bin/sh
#*S3PathRoot* must be replaced with the appropriate root for your S3 path to function
S3aPathRoot="s3a://covid-analysis-p3/datalake/infection-mortality/CovidLiveUpdates"
LocalPathRoot="datalake/CovidLiveUpdates"

#Dowloads files locally
curl -X GET "https://disease.sh/v3/covid-19/countries/Algeria%2CAngola%2CBenin%2CBotswana%2CBurkinaFaso%2CBurundi%2CCameroon%2CCapeVerde%2CCentral%20African%20Republic%2CChad%2CComoros%2Congo%2CCote%20d'Ivoire%2CDRC%2CDjibouti%2CEgypt%2CEquatorial%20Guinea%2CEritrea%2CEthiopia%2CGabon%2CGambia%2CGhana%2CGuinea%2CGuinea-Bissau%2CKenya%2CLesotho%2CLiberia%2CLibya%2CMadagascar%2CMalawi%2CMali%2CMauritania%2CMauritius%2CMorocco%2CMozambique%2CNamibia%2CNiger%2CNigeria%2CRepublic%20of%20the%20Congo%2CReunion%2CRwanda%2CSaint%20Helena%2CSao%20Tome%20and%20Principe%2CSenegal%2CSeychelles%2CSierra%20Leone%2CSomalia%2CSouth%20Africa%2CSouth%20Sudan%2CSudan%2CSwaziland%2CTanzania%2CTogo%2CTunisia%2CUganda%2CWestern%20Sahara%2CZambia%2CZimbabwe" -H "accept: application/json" > $LocalPathRoot/africa.json
curl -X GET "https://disease.sh/v3/covid-19/countries/Afghanistan%2CArmenia%2CAzerbaijan%2CBahrain%2CBangladesh%2CBhutan%2CBrunei%2CBurma%2CCambodia%2CChina%2CCyprus%2CEast%20Timor%2CGeorgia%2CHong%20Kong%2CIndia%2CIndonesia%2CIran%2CIraq%2CIsrael%2CJapan%2CJordan%2CKazakhstan%2CKuwait%2CKyrgyzstan%2CLaos%2CLebanon%2CMacau%2CMalaysia%2CMaldives%2CMongolia%2CNepal%2CNorth%20Korea%2COman%2CPakistan%2CPhilippines%2CQatar%2CSaudi%20Arabia%2CSingapore%2CSouth%20Korea%2CSri%20Lanka%2CSyria%2CTaiwan%2CTajikistan%2CThailand%2CTurkey%2CTurkmenistan%2CUnited%20Arab%20Emirates%2CUzbekistan%2CVietnam%2CYemen" -H "accept: application/json" > $LocalPathRoot/asia.json
curl -X GET "https://disease.sh/v3/covid-19/countries/Anguilla%2CAntigua%20and%20Barbuda%2CAruba%2CThe%20Bahamas%2CBarbados%2CBermuda%2CBritish%20Virgin%20Islands%2CCayman%20Islands%2CCuba%2CDominica%2CDominican%20Republic%2CGrenada%2CGuadeloupe%2CHaiti%2CJamaica%2CMartinique%2CMontserrat%2CNetherlands%20Antilles%2CPuerto%20Rico%2CSaint%20Kitts%20and%20Nevis%2CSaint%20Lucia%2CSaint%20Vincent%20and%20the%20Grenadines%2CTrinidad%20and%20Tobago%2CTurks%20and%20Caicos%20Islands%2CU.S.%20Virgin%20Islands" -H "accept: application/json" > $LocalPathRoot/caribbean.json
curl -X GET "https://disease.sh/v3/covid-19/countries/Belize%2CCosta%20Rica%2CEl%20Salvador%2CGuatemala%2CHonduras%2CNicaragua%2CPanama" -H "accept/json" > $LocalPathRoot/central_america.json
curl -X GET "https://disease.sh/v3/covid-19/countries/Albania%2CAndorra%2CAustria%2CBelarus%2CBelgium%2CBosnia%20and%20Herzegovina%2CBulgaria%2CCroatia%2CCzech%20Republic%2CDenmark%2CEstonia%2CFinland%2CFrance%2CGermany%2CGibraltar%2CGreece%2CHoly%20See%2CHungary%2CIceland%2CIreland%2CItaly%2CKosovo%2CLatvia%2CLiechtenstein%2CLithuania%2CLuxembourg%2CMacedonia%2CMalta%2CMoldova%2CMonaco%2CMontenegro%2CNetherlands%2CNorway%2CPoland%2CPortugal%2CRomania%2CRussia%2CSan%20Marino%2CSlovak%20Republic%2CSlovenia%2CSpain%2CSerbia%2CSerbia%20and%20Montenegro%2CSweden%2CSwitzerland%2CUkraine%2CUnited%20Kingdom" -H "accept/json" > $LocalPathRoot/europe.json
curl -X GET "https://disease.sh/v3/covid-19/countries/Canada%2CGreenland%2CMexico%2CSaint%20Pierre%20and%20Miquelon%2CUnited%20States" -H "accept/json" > $LocalPathRoot/north_america.json
curl -X GET "https://disease.sh/v3/covid-19/countries/AmericanSamoa%2CAustralia%2CChristmas%20Island%2CCocos%20(Keeling)%20Islands%2CCook%20Islands%2CFederated%20States%20of%20Micronesia%2CFiji%2CFrench%20Polynesia%2CGuam%2CKiribati%2CMarshall%20Islands%2CNauru%2CNew%20Caledonia%2CNew%20Zealand%2CNiue%2CNorthern%20Mariana%20Islands%2CPalau%2CPapua%20New%20Guinea%2CPitcairn%20Islands%2CSamoa%2CSolomon%20Islands%2CTokelau%2CTonga%2CTuvalu%2CVanuatu%2CWallis%20and%20Futuna" -H "accept/json" > $LocalPathRoot/oceania.json
curl -X GET "https://disease.sh/v3/covid-19/countries/Argentina%2CBolivia%2CBrazil%2CChile%2CColombia%2CEcuador%2CFalkland%20Islands%2CFrench%20Guiana%2CGuyana%2CParaguay%2CPeru%2CSuriname%2CUruguay%2CVenezuela" -H "accept/json" > $LocalPathRoot/south_america.json

#Uploads files to S3
aws s3 cp $LocalPathRoot/africa.json $S3PathRoot/africa.json
aws s3 cp $LocalPathRoot/asia.json $S3PathRoot/asia.json
aws s3 cp $LocalPathRoot/caribbean.json $S3PathRoot/caribbean.json
aws s3 cp $LocalPathRoot/central_america.json $S3PathRoot/central_america.json
aws s3 cp $LocalPathRoot/europe.json $S3PathRoot/europe.json
aws s3 cp $LocalPathRoot/north_america.json $S3PathRoot/north_america.json
aws s3 cp $LocalPathRoot/south_america.json $S3PathRoot/south_america.json
aws s3 cp $LocalPathRoot/oceania.json $S3PathRoot/oceania.json
