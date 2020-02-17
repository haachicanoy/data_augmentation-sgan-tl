library(tidyverse)
library(RColorBrewer)

tbl <- readxl::read_excel('/Volumes/BACKUP/Documents/Data/Faces/ALL_estadisticasImages_GVISFAce_Ages.xlsx', sheet = 1)
tbl <- tbl[1:9,]
colnames(tbl)[1] <- 'Dataset'
tbl %>%
  tidyr::pivot_longer(cols = '0':'119',
                      names_to = 'Edad',
                      values_to = 'Frecuencia') %>%
  dplyr::filter(Dataset %in% c('ADB','APR','UTK','WKI')) %>%
  dplyr::mutate(Dataset = factor(Dataset, levels = c('ADB','APR','UTK','WKI'), labels = c('AgeDB','APPA-REAL','UTKFace','IMDB-WIKI'))) %>%
  # dplyr::group_by(Dataset) %>%
  # dplyr::mutate(Frecuencia2 = scale(Frecuencia)) %>%
  ggplot2::ggplot(aes(x = as.numeric(Edad), y = Frecuencia, group = Dataset)) +
  ggplot2::geom_line(aes(colour = Dataset)) +
  ggplot2::scale_colour_brewer(palette = 'Dark2') +
  ggplot2::xlab('Edad (años)') +
  ggplot2::ylab('Número de imágenes') +
  ggplot2::scale_y_continuous(expand = c(0,0)) +
  ggplot2::scale_x_continuous(breaks = seq(0,120,5), expand = c(0,0)) +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text = element_text(size = 14),
                 axis.text.x = element_text(angle = 90),
                 axis.title = element_text(size = 17),
                 legend.text = element_text(size = 14),
                 legend.title = element_text(size = 17)) +
  ggplot2::geom_rect(aes(xmin = 5, xmax = 19, ymin = -Inf, ymax = Inf), alpha = I(0.002), fill = "yellow") +
  ggplot2::ggsave(filename = "/Volumes/BACKUP/Documents/Data/Faces/faces_datasets_distribution.png", device = "png", width = 8, height = 6, units = "in")
