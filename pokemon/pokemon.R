# setwd("/Users/hannahweeks/Documents/Vanderbilt/just_for_fun/pokemon")

# source("https://bioconductor.org/biocLite.R")
# biocLite("EBImage")
# devtools::install_github("GuangchuangYu/ggimage")
library(ggimage)

# Data downloaded from https://www.kaggle.com/abcsds/pokemon
pokemon <- read.csv("Pokemon.csv", stringsAsFactors = FALSE)
names(pokemon)[1] <- "dex"
# Restrict to original 151
pokemon <- subset(pokemon, pokemon$dex %in% c(1:151))
# Get rid of mega evolutions
pokemon <- pokemon[-grep("Mega", pokemon$Name),]

# Available stats to look at
stats <- names(pokemon)[5:11]

# Data frame with pokemon names and pokedex ids
pokenames <- list.pokemon(); pokenames <- pokenames[pokenames != "riolu"]
poke_id <- pokemon$dex[order(pokemon$Name)]
name_id <- data.frame(name = pokenames, id = poke_id)
name_id <- name_id[order(name_id$id),]

# Modify the geom_pokemon function to pull the images from local directory for faster plot rendering
# Images are from https://github.com/Templarian/slack-emoji-pokemon/tree/master/emojis
geom_pokemon_local <- function(mapping=NULL, data=NULL, inherit.aes=TRUE,
                         na.rm=FALSE, by="width", ...) {
  geom_image(mapping, data, inherit.aes=inherit.aes, na.rm=na.rm, ..., geom = 'pokemon_local')
}

pokemon_local <- function(id) {
  paste0('emojis/', id, ".png") # Not sure why I still have to call the full expression below and not just name
}

# # Example
# t0 <- Sys.time()
# ggplot(pokemon, aes(HP, Speed)) + geom_pokemon_local(aes(image = paste0('emojis/', pokelabel$pokenames, '.png')))
# tplot <- Sys.time() - t0 # About 7 seconds

