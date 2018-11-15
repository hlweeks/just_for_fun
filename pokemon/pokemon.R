# !diagnostics off

# source("https://bioconductor.org/biocLite.R")
# biocLite("EBImage")
# 

# install.packages(c("tidyverse", "here", "magrittr", "Hmisc"))

# devtools::install_github("GuangchuangYu/ggimage")

library(magrittr)
library(tidyverse)
library(ggimage)

shiny=F
if(!shiny){setwd(paste(here::here(), "pokemon", sep="/"))}

# Data downloaded from https://www.kaggle.com/mylesoneill/pokemon-sun-and-moon-gen-7-stats
pokemon <- read_csv("data/pokemon.csv", col_types=cols())

pokemon <- pokemon %>% rename(dex_no = ndex, name = species, form = forme) %>%
  mutate(gen = as.numeric(cut(dex_no, breaks=c(0,151,251,386,493,649,721,807))),
         name_id = tolower(gsub("\\.|\\s|'|’", "", name))) %>%
  mutate(name_id = gsub("♀", "f", name_id)) %>%
  mutate(name_id = gsub("♂", "m", name_id))

get_gen <- function(gen_no){
  pokemon %>% filter(gen==gen_no) %>%
    # Get rid of alternate forms/mega evolutions
    filter(name == form)
}

gen1 <- get_gen(1)
gen2 <- get_gen(2)


# Available stats to look at
stats <- Hmisc::Cs(hp, attack, defense, spattack, spdefense, speed, total)


# Modify the geom_pokemon function to pull the images from local directory for faster plot rendering
# Images are from https://github.com/Templarian/slack-emoji-pokemon/tree/master/emojis
geom_pokemon_local <- function(mapping=NULL, data=NULL, inherit.aes=TRUE,
                         na.rm=FALSE, by="width", ...) {
  geom_image(mapping, data, inherit.aes=inherit.aes, na.rm=na.rm, ..., 
             .fun = pokemon_local)
}

pokemon_local <- function(id) {
  paste0('emojis/', id, ".png") 
}


