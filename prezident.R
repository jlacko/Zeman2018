# úvodní orientace ve volebních výsledcích prezidentských voleb
library(sf)
library(tidyverse)
library(RCzechia)
library(tmap)
library(RColorBrewer)
library(leaflet)

# osoby a obsazení...
src <- read.csv2(url("https://raw.githubusercontent.com/jlacko/Zeman2018/master/src/prezident.csv"), stringsAsFactors = F) # výsledky voleb
pecoco <- read.csv2(url("https://raw.githubusercontent.com/jlacko/Zeman2018/master/src/pecoco.csv"), stringsAsFactors = F) # číselník obcí

kandidati <- data_frame(cislo = 1:9,
                        jmeno = c("Mirek Topolánek",
                                  "Michal Horáček",
                                  "Pavel Fischer",
                                  "Jiří Hynek",
                                  "Petr Hannig",
                                  "Vratislav Kulhánek",
                                  "Miloš Zeman",
                                  "Marek Hilšer",
                                  "Jiří Drahoš"))

druheKolo <- pecoco %>%
  left_join(src, by = "OBEC") %>%
  filter(CHYBA == 0) %>% # bez chyby
  filter(KOLO == 2) %>% # druhé kolo only...
  group_by(OBEC) %>%
  summarize(celkem = sum(PL_HL_CELK), # celkem platných hlasů
            zeman = sum(HLASY_07),  # kandidát č.7 = Miloš Zeman
            drahos = sum(HLASY_09)) %>% # kandidát č.9 = Jiří Drahoš
  mutate(KOD = as.character(OBEC), # kod obce v RCzechia je text :(
         pct_zeman = zeman / celkem,
         pct_drahos = drahos / celkem) 

obce <- obce_polygony %>%
  select(KOD = KOD_OBEC,
         NAZEV = NAZ_OBEC)

casti <- casti %>% # městské části pouze na vývojové RCzechia (zatím...)
  select(KOD, NAZEV)

podklad <- obce %>% # všechny obce
  rbind(casti) %>% # plus všechny části
  inner_join(druheKolo) # přilinkovat pouze ty, které mají volební výsledek

metropole <- c("Praha", "Brno", "Plzeň", "Ostrava")
mesta <- obce_polygony[obce_polygony$NAZ_OBEC %in% metropole, ]

mapa <- tm_shape(republika) + tm_borders(col = "grey30", lwd = 2) +
  tm_shape(podklad) + tm_fill(col = "pct_zeman" , palette = "YlOrBr", title = "Zemanův zisk", id = "NAZEV") + 
  tm_shape(mesta) + tm_borders(col = "grey30", lwd = 1.5) +
  tm_style_white("Volební výsledky", frame = F, 
                 legend.format = list(text.separator =  "-", 
                                      fun = function(x) paste0(formatC(x * 100, digits = 0, format = "f"), " %")),
                 legend.text.size = 0.8, 
                 legend.title.size = 1.3) +
  tm_legend(position = c("RIGHT", "top")) +
  tm_view(basemaps = "Stamen.Toner")

tmap_mode("view")
print(mapa)
  