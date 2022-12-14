#########################
## Name: Matt Watkins
## Date: Dec. 13th / 22
## Project: fri_land_cover
## Objective: Clean up Erika's land cover csv file
## Inputs: ws_FRIlandcover_percentages.csv
## Outputs: cleaned dataframe with updated column names
#########################

## 0. NOTES ----

## 1. PREPARE ----

rm(list=ls())
options(stringsASfactors = FALSE, scipen = 999, encoding = "UTF-8")

library(tidyverse)
library(readxl)

## 2. IMPORT ----

fri_data <- read.csv("ws_FRIcover_percentages.csv")

## 3. TIDY // PROCESS ----

### 3.01 - Remove some of the unnecessary legacy ArcGIS columns, change catchment names and put site as first column

fri_subset <- fri_data %>% 
  select(-Shape_Leng, -Shape_Le_1, -Shape_Le_2, -Shape_Le_3, -area, -geometry) %>% 
  mutate(site = case_when(OBJECTID == "11" ~ "WS 11",
                           OBJECTID == "17" ~ "WS 17",
                           OBJECTID == "36" ~ "WS 36",
                           OBJECTID == "40" ~ "WS 40",
                           OBJECTID == "43" ~ "WS 43",
                           OBJECTID == "44" ~ "WS 44",
                           OBJECTID == "45" ~ "WS 45",
                           OBJECTID == "46" ~ "WS 46",
                           OBJECTID == "47" ~ "WS 47",
                           OBJECTID == "52" ~ "WS 52",
                           OBJECTID == "54" ~ "WS 54",
                           OBJECTID == "66" ~ "WS 66",
                           OBJECTID == "67" ~ "WS 67",
                           OBJECTID == "73" ~ "WS 73",
                           OBJECTID == "75" ~ "WS 75",
                           OBJECTID == "76" ~ "WS 76",
                           OBJECTID == "77" ~ "WS 77",
                           OBJECTID == "82" ~ "WS 82",
                           OBJECTID == "84" ~ "WS 84",
                           OBJECTID == "87" ~ "WS 87",
                           OBJECTID == "92" ~ "WS 92",
                           OBJECTID == "93" ~ "WS 93",
                           OBJECTID == "96" ~ "WS 96",
                           OBJECTID == "104" ~ "WS 104",
                           OBJECTID == "108" ~ "WS 108",
                           OBJECTID == "110" ~ "WS 110",
                           OBJECTID == "111" ~ "WS SSR",
                           OBJECTID == "112" ~ "WS SBC",
                           OBJECTID == "113" ~ "WS BL2",
                           OBJECTID == "114" ~ "WS BL1")) %>% 
  select(-OBJECTID) %>% 
  select("site", everything())

### 3.02 - I've identified all of the important columns (tree species, water, rock, brush, etc), grab these only in a subset dataframe ----

fri_Out <- fri_subset %>% 
  select(site, Pl_per, UCL_per, RCK_per, Bw_per, U999_per, Ab_per, OMS_per, FOR_per, Sb_per, Pw_per, Sw_per, TMS_per, Pr_per, La_per, Mh_per, Pt_per, Bf_per, Mr_per, Bp_per, BSH_per, Cw_per, WAT_per, Pb_per, U997_per, U998_per)

### 3.03 - change column names to be less cryptic

colnames(fri_Out) <- c("site", "largetooth.aspen", "unclassified", "rock", "white.birch", "unclassified.residential", "black.ash", "open.wetland", "productive.forest", "black.spruce", "eastern.white.pine", "white.spruce", "treed.wetland", "red.pine", "tamarack", "sugar.maple", "trembling.aspen", "balsam.fir", "red.maple", "european.white.birch", "brush.and.alder", "eastern.white.cedar", "open.water", "balsam.poplar", "unclassified.commercial", "unclassified.utilities")

### 3.04 - Get percents out of decimals and into ones and tens values

fri_Out

fri_percents <- fri_Out[2:26] * 100

site <- pull(fri_Out, site)

fri_per_join  <- cbind(fri_percents, site)
  
fri_arranged <- fri_per_join %>% 
  select("site", everything())

## 4. PLOTTING ----

## 5. SAVING // EXPORTING ----

## 6. TRIAL // JUNK CODE ----

