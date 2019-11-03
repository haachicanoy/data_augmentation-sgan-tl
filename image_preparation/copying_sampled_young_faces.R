
library(tidyverse); library(gtools)

input <- "D:/Data/Faces/with_background/GVISFace_Age_512"
output <- "D:/Data/Faces/with_background/GVISFace_Age_512_5-19"

if(!dir.exists(output)){dir.create(output)}

all           <- list.files(path = input, pattern = "*.jpg$", full.names = F)
grep2         <- Vectorize(grep, vectorize.args = "pattern")
all_age_range <- grep2(pattern = paste0("^", 5:19), x = all, fixed = F) %>% as.numeric()
set.seed(1235)
smp           <- sample(x = all_age_range, size = 2417, replace = F)

sset          <- all[smp] %>% gtools::mixedsort()

for(s in sset){
  file.copy(from = paste0(input, "/", s), to = paste0(output, "/", s))
}
