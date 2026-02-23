# db/seeds/city_taxes.rb (or directly in db/seeds.rb)
require "nokogiri"
def table
 <<~HTML
<table id="myTable">
<tbody>
<tr><td>ANDRIJAŠEVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ANTUNOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BABINA GREDA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BAKAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BALE - VALLE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BARBAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BARILOVIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BAŠKA</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>BAŠKA VODA</td><td>17,00%</td><td>27,00%</td></tr>
<tr><td>BEBRINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BEDEKOVČINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BEDENICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BEDNJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BELI MANASTIR</td><td>21,00%</td><td>27,00%</td></tr>
<tr><td>BELICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BELIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BENKOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BEREK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BERETINEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BIBINJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BILICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BILJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BIOGRAD NA MORU</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BISKUPIJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BISTRA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BIZOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BJELOVAR</td><td>18,00%</td><td>25,00%</td></tr>
<tr><td>BLATO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BOGDANOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BOL</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BOROVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BOSILJEVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BOŠNJACI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRCKOVLJANI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRDOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRELA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRESTOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BREZNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BREZNIČKI HUM</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRINJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BROD MORAVICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRODSKI STUPNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BRTONIGLA - VERTENEGLIO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BUDINŠČINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BUJE - BUIE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BUKOVLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>BUZET</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>CERNA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CERNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CEROVLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CESTICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CETINGRAD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CISTA PROVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CIVLJANE</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>CRES</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CRIKVENICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>CRNAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ČABAR</td><td>19,00%</td><td>30,00%</td></tr>
<tr><td>ČAČINCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ČAĐAVICA</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>ČAGLIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ČAKOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ČAVLE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ČAZMA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ČEMINAC</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>ČEPIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DARDA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DARUVAR</td><td>21,00%</td><td>30,00%</td></tr>
<tr><td>DAVOR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DEKANOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DELNICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DESINIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DEŽANOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DICMO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DOBRINJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DOMAŠINEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJA DUBRAVA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJA MOTIČINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJA STUBICA</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>DONJA VOĆA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJI ANDRIJEVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJI KRALJEVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJI KUKURUZARI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJI LAPAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJI MIHOLJAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DONJI VIDOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DRAGALIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DRAGANIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DRAŽ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DRENOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DRENJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DRNIŠ</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>DRNJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUBRAVA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUBRAVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUBROVAČKO PRIMORJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUBROVNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUGA RESA</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>DUGI RAT</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUGO SELO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DUGOPOLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>DVOR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ĐAKOVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ĐELEKOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ĐULOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ĐURĐENOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ĐURĐEVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ĐURMANEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ERDUT</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ERNESTINOVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ERVENIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>FARKAŠEVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>FAŽANA - FASANA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>FERDINANDOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>FERIČANCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>FUNTANA - FONTANE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>FUŽINE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GALOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GARČIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GAREŠNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GENERALSKI STOL</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GLINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GOLA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORIČAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORJANI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORNJA RIJEKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORNJA STUBICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORNJA VRBA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORNJI BOGIĆEVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORNJI KNEGINEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GORNJI MIHALJEVEC</td><td>17,00%</td><td>27,00%</td></tr>
<tr><td>GOSPIĆ</td><td>22,00%</td><td>32,00%</td></tr>
<tr><td>GRAČAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GRAČIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GRADAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GRADEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GRADINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GRADIŠTE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GROŽNJAN - GRISIGNANA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GRUBIŠNO POLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GUNDINCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GUNJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>GVOZD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HERCEGOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HLEBINE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HRAŠĆINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HRVACE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HRVATSKA DUBICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HRVATSKA KOSTAJNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HUM NA SUTLI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>HVAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ILOK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>IMOTSKI</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>IVANEC</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>IVANIĆ-GRAD</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>IVANKOVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>IVANSKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JAGODNJAK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JAKOVLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JAKŠIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JALŽABET</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JANJINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JARMINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JASENICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JASENOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JASTREBARSKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JELENJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JELSA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JESENJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>JOSIPDOL</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KALI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KALINOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KALNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KAMANJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KANFANAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KAPELA</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>KAPTOL</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KARLOBAG</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KARLOVAC</td><td>19,00%</td><td>29,00%</td></tr>
<tr><td>KAROJBA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KASTAV</td><td>20,00%</td><td>31,00%</td></tr>
<tr><td>KAŠTELA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KAŠTELIR-LABINCI - CASTELLIERE-S. DOMENICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KIJEVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KISTANJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLAKAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLANA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLANJEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLENOVNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLINČA SELA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLIS</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLOŠTAR IVANIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KLOŠTAR PODRAVSKI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KNEŽEVI VINOGRADI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KNIN</td><td>21,00%</td><td>30,00%</td></tr>
<tr><td>KOLAN</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>KOMIŽA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KONAVLE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KONČANICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KONJŠČINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KOPRIVNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KOPRIVNIČKI BREGI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KOPRIVNIČKI IVANEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KORČULA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KOSTRENA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KOŠKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KOTORIBA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRALJEVEC NA SUTLI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRALJEVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRAPINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRAPINSKE TOPLICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRAŠIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRAVARSKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRIŽ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRIŽEVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRNJAK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KRŠAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KUKLJICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KULA NORINSKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KUMROVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KUTINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>KUTJEVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LABIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LANIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LASINJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LASTOVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LEĆEVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LEGRAD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LEKENIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LEPOGLAVA</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>LEVANJSKA VAROŠ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LIPIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LIPOVLJANI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LIŠANE OSTROVIČKE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LIŽNJAN - LISIGNANO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOBOR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOKVE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOKVIČIĆI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOPAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOVAS</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOVINAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOVRAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LOVREĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LUDBREG</td><td>20,00%</td><td>31,00%</td></tr>
<tr><td>LUKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LUKAČ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LUMBARDA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LUPOGLAV</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>LJUBEŠĆICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MAČE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MAGADENOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MAJUR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MAKARSKA</td><td>18,00%</td><td>31,00%</td></tr>
<tr><td>MALA SUBOTICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MALI BUKOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MALI LOŠINJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MALINSKA-DUBAŠNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARČANA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARIJA BISTRICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARIJA GORICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARIJANCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARKUŠICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARTIJANEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARTINSKA VES</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MARUŠEVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MATULJI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MEDULIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>METKOVIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MIHOVLJAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MIKLEUŠ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MILNA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MLJET</td><td>20,00%</td><td>27,00%</td></tr>
<tr><td>MOLVE</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>MOŠĆENIČKA DRAGA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MOTOVUN - MONTONA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MRKOPALJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MUĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MURSKO SREDIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>MURTER - KORNATI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NAŠICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NEDELIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NEGOSLAVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NEREŽIŠĆA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NETRETIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NIJEMCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVA BUKOVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVA GRADIŠKA</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>NOVA KAPELA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVA RAČA</td><td>17,00%</td><td>27,00%</td></tr>
<tr><td>NOVALJA</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>NOVI GOLUBOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVI MAROF</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVI VINODOLSKI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVIGRAD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVIGRAD - CITTANOVA</td><td>20,00%</td><td>31,00%</td></tr>
<tr><td>NOVIGRAD PODRAVSKI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVO VIRJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NOVSKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>NUŠTAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OBROVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OGULIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OKRUG</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OKUČANI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OMIŠ</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>OMIŠALJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OPATIJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OPRISAVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OPRTALJ - PORTOLE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OPUZEN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ORAHOVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OREBIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OREHOVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ORIOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ORLE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OROSLAVJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OSIJEK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OTOČAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OTOK (SINJ)</td><td>17,00%</td><td>27,00%</td></tr>
<tr><td>OTOK (VINKOVCI)</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>OZALJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PAG</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PAKOŠTANE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PAKRAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PAŠMAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PAZIN</td><td>22,00%</td><td>30,00%</td></tr>
<tr><td>PERUŠIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PETERANEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PETLOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PETRIJANEC</td><td>20,00%</td><td>27,00%</td></tr>
<tr><td>PETRIJEVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PETRINJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PETROVSKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PIĆAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PIROVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PISAROVINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PITOMAČA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PLAŠKI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PLETERNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PLITVIČKA JEZERA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PLOČE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODBABLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODCRKAVLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODGORA</td><td>18,00%</td><td>30,00%</td></tr>
<tr><td>PODGORAČ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODRAVSKA MOSLAVINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODRAVSKE SESVETE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODSTRANA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PODTUREN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POJEZERJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POKUPSKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POLAČA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POLIČNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POPOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POPOVAČA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POREČ - PARENZO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POSEDARJE</td><td>18,00%</td><td>30,00%</td></tr>
<tr><td>POSTIRA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POVLJANA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>POŽEGA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PREGRADA</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>PREKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRELOG</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRESEKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRGOMET</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRIBISLAVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRIMORSKI DOLAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRIMOŠTEN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRIVLAKA (VUKOVAR)</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PRIVLAKA (ZADAR)</td><td>17,00%</td><td>30,00%</td></tr>
<tr><td>PROLOŽAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PROMINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PUČIŠĆA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PULA - POLA</td><td>22,00%</td><td>32,00%</td></tr>
<tr><td>PUNAT</td><td>15,00%</td><td>30,00%</td></tr>
<tr><td>PUNITOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>PUŠĆA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RAB</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RADOBOJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RAKOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RAKOVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RASINJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RAŠA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RAVNA GORA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RAŽANAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>REŠETARI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RIBNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RIJEKA</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>ROGOZNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ROVINJ - ROVIGNO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ROVIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RUGVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RUNOVIĆI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>RUŽIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SABORSKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SALI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SAMOBOR</td><td>18,00%</td><td>27,00%</td></tr>
<tr><td>SATNICA ĐAKOVAČKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SEGET</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SELCA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SELNICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SEMELJCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SENJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SEVERIN</td><td>18,00%</td><td>28,00%</td></tr>
<tr><td>SIBINJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SIKIREVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SINJ</td><td>18,00%</td><td>30,00%</td></tr>
<tr><td>SIRAČ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SISAK</td><td>21,60%</td><td>31,60%</td></tr>
<tr><td>SKRAD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SKRADIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SLATINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SLAVONSKI BROD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SLAVONSKI ŠAMAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SLIVNO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SLUNJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SMOKVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SOKOLOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SOLIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SOPJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SPLIT</td><td>21,50%</td><td>32,00%</td></tr>
<tr><td>SRAČINEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STANKOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STARA GRADIŠKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STARI GRAD</td><td>20,00%</td><td>31,00%</td></tr>
<tr><td>STARI JANKOVCI</td><td>15,00%</td><td>25,00%</td></tr>
<tr><td>STARI MIKANOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STARIGRAD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STARO PETROVO SELO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STON</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STRAHONINEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STRIZIVOJNA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STUBIČKE TOPLICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>STUPNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SUĆURAJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SUHOPOLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SUKOŠAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SUNJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SUPETAR</td><td>20,50%</td><td>31,00%</td></tr>
<tr><td>SUTIVAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETA MARIJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETA NEDELJA (LABIN)</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETA NEDELJA (SAMOBOR)</td><td>18,00%</td><td>28,00%</td></tr>
<tr><td>SVETI ĐURĐ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI FILIP I JAKOV</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI ILIJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI IVAN ZELINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI IVAN ŽABNO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI JURAJ NA BREGU</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI KRIŽ ZAČRETJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI LOVREČ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI MARTIN NA MURI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI PETAR OREHOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETI PETAR U ŠUMI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>SVETVINČENAT</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠANDROVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠENKOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠESTANOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠIBENIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠKABRNJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠODOLOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠOLTA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠPIŠIĆ BUKOVICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠTEFANJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠTITAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŠTRIGOVA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TAR-VABRIGA - TORRE-ABREGA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TINJAN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TISNO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TKON</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TOMPOJEVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TOPUSKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TORDINCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TOUNJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TOVARNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TRIBUNJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TRILJ</td><td>15,00%</td><td>30,00%</td></tr>
<tr><td>TRNAVA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TRNOVEC BARTOLOVEČKI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TROGIR</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>TRPANJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TRPINJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>TUČEPI</td><td>17,00%</td><td>30,00%</td></tr>
<tr><td>TUHELJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>UDBINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>UMAG - UMAGO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>UNEŠIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VALPOVO</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>VARAŽDIN</td><td>21,00%</td><td>32,00%</td></tr>
<tr><td>VARAŽDINSKE TOPLICE</td><td>21,00%</td><td>30,00%</td></tr>
<tr><td>VELA LUKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKA GORICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKA KOPANICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKA LUDINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKA PISANICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKA TRNOVITICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKI BUKOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKI GRĐEVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKO TRGOVIŠĆE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VELIKO TROJSTVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIDOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VILJEVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VINICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VINKOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VINODOLSKA OPĆINA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIRJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIROVITICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIS</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VISOKO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIŠKOVCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIŠKOVO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIŠNJAN - VISIGNANO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VIŽINADA - VISINADA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VLADISLAVCI</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>VOĆIN</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VODICE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VODNJAN - DIGNANO</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VOĐINCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VOJNIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRATIŠINEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRBANJA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRBJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRBNIK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRBOVEC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRBOVSKO</td><td>21,00%</td><td>31,00%</td></tr>
<tr><td>VRGORAC</td><td>21,00%</td><td>25,00%</td></tr>
<tr><td>VRHOVINE</td><td>18,00%</td><td>30,00%</td></tr>
<tr><td>VRLIKA</td><td>18,00%</td><td>28,00%</td></tr>
<tr><td>VRPOLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRSAR - ORSERA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VRSI</td><td>15,00%</td><td>30,00%</td></tr>
<tr><td>VUKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>VUKOVAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZABOK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZADAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZADVARJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZAGORSKA SELA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZAGREB</td><td>23,00%</td><td>33,00%</td></tr>
<tr><td>ZAGVOZD</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZAPREŠIĆ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZAŽABLJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZDENCI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZEMUNIK DONJI</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZLATAR</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZLATAR BISTRICA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ZMIJAVCI</td><td>20,00%</td><td>25,00%</td></tr>
<tr><td>ZRINSKI TOPOLOVAC</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŽAKANJE</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŽMINJ</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŽUMBERAK</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŽUPA DUBROVAČKA</td><td>20,00%</td><td>30,00%</td></tr>
<tr><td>ŽUPANJA</td><td>21,00%</td><td>31,00%</td></tr>


	</tbody></table>
  HTML
end

def  to_float(str)
  n = str.gsub("%", "").gsub(",", ".").to_f
  return n/100
end

def seed_city_taxes

  html = table
  doc = Nokogiri::HTML.fragment(html)

  city_taxes =
    doc.css("tr").map do |tr|
      tds = tr.css("td").map { _1.text.strip }
      next if tds.size < 3

      {
        title: tds[0],
        lower_rate: to_float(tds[1]),  
        higher_rate: to_float(tds[2])   
      }
    end.compact

  # Optional: wipe existing to avoid duplicates
  CityTaxRate.delete_all

  CityTaxRate.insert_all!(city_taxes)
end

