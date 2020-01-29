options(warn = -1, scipen = 999)

suppressMessages(library(pacman))
suppressMessages(pacman::p_load(tidyverse))

root  <- "/Volumes/BACKUP/Documents/Data/UTKFaces/Aligned_cropped/UTKFace/"
files <- list.files(root, pattern = "*.jpg$", full.names = F)

files_spltd <- strsplit(x = files, split = "_", fixed = T)

# Age distribution
files_spltd %>% purrr::map(1) %>% unlist() %>% as.numeric() %>% gtools::mixedsort() %>% table() %>% barplot(main = "Age distribution")
ages <- files_spltd %>% purrr::map(1) %>% unlist() %>% as.numeric() %>% gtools::mixedsort() %>% table()
ages <- ages %>% base::as.data.frame()
colnames(ages) <- c("Age","Frequency")
ages$Age <- ages$Age %>% as.character() %>% as.numeric()

g <- ages %>% ggplot2::ggplot(aes(x = Age, y = Frequency)) +
  ggplot2::geom_bar(stat = "identity", fill = "steelblue") +
  ggplot2::xlab("Edad (años)") +
  ggplot2::ylab("Número de imágenes") +
  ggplot2::scale_x_continuous(breaks = seq(0, 120, 10)) +
  ggplot2::geom_rect(aes(xmin = 5, xmax = 18, ymin = -Inf, ymax = Inf), alpha = 0.005, fill = "red") +
  ggplot2::geom_rect(aes(xmin = 60, xmax = 116, ymin = -Inf, ymax = Inf), alpha = 0.005, fill = "red")
ggplot2::ggsave(filename = "/Volumes/BACKUP/Documents/Data/UTKFaces/utkfaces_distribucion.png", plot = g, device = "png", width = 8, height = 6, units = "in")

# Gender distribution 0:male 1:female
files_spltd %>% purrr::map(2) %>% unlist() %>% as.numeric() %>% gtools::mixedsort() %>% table() %>% barplot(main = "Gender distribution")

# Race distribution 0:White 1:Black 2:Asian 3:Indian 4:Others
files_spltd %>% purrr::map(3) %>% unlist() %>% as.numeric() %>% gtools::mixedsort() %>% table() %>% barplot(main = "Race distribution")
