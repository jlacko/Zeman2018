# Vizualizace volebních výsledků Miloše Zemana v prezidentské volbě

Malé cvičení na vizualizaci, které si klade dva cíle:  
* ukázat, jak jsou v Zemích českých a na Moravě rozložení voliči Miloše Zemana
* ukázat, jak snadné je v prostředí RStudia vytvořit interaktivní mapovou vizualizaci

<p align="center">
  <img src="https://github.com/jlacko/Zeman2018/blob/master/img/big.png?raw=true" alt="Mapa v malém měřítku"/>
</p>

Zdrojový kód pro tvorbu mapy je `prezident.R`, výsledek je [`zeman.html`](https://rawgit.com/jlacko/Zeman2018/master/zeman.html). Prázdná místa jsou vojenské újezdy (kde se nevolí) a nepřesnosti dané tím, že potřebuju polygony obcí a obecních částí zjednodušit aby prošly dráty internetu; i tak má `zeman.html`přes deset mega. 

<p align="center">
  <img src="https://github.com/jlacko/Zeman2018/blob/master/img/small.png?raw=true" alt="Mapa v malém měřítku"/>
</p>

Pracuju s vývojovu verzí packge *RCzechia*, která je k dispozici zde na GitHubu (verze pro *sf* je datově hotová, ještě pracuji na dokumentaci).
```r
devtools::install_github("jlacko/RCzechia", ref = "sf-dev")

```

## Zdroje dat
* volební výsledky jsou ze [Staťáku](https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu)
* mapa je vytvořena pomocí [tmap](https://github.com/mtennekes/tmap) a [leaflet](http://leafletjs.com/)
* RCzechia je postavená na datech [Arc ČR500](https://www.arcdata.cz/media/download/1638)
