options(warn = -1, scipen = 999)

suppressPackageStartupMessages(library(googlesheets))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(RColorBrewer))

eval <- googlesheets::gs_title("Loss metrics")

metrics <- googlesheets::gs_read(eval)
metrics %>% dplyr::glimpse()
metrics$Value <- metrics$Value %>% gsub(',','.',.) %>% as.numeric

metrics %>%
  dplyr::filter(Metric %in% c('Loss scores real','Loss scores fake')) %>%
  dplyr::mutate(Metric = factor(Metric, levels = c('Loss scores real','Loss scores fake'))) %>%
  dplyr::group_by(Source, Target) %>%
  dplyr::mutate(Time = (Step-min(Step)),
                Source = factor(Source, levels = c('Paintings','Portraits','Pokemon','Bedrooms','Cats'))) %>%
  ggplot2::ggplot(aes(x = Time/1000, y = Value, colour = Source)) +
  ggplot2::geom_line(aes(linetype = Metric), size = 1.2) +
  ggplot2::facet_wrap(~Target) +
  ggplot2::xlim(0, 1000) +
  ggplot2::xlab('Iterations') +
  ggplot2::ylab('Loss scores') +
  ggplot2::geom_hline(yintercept = 0, linetype = 'dashed') +
  ggplot2::scale_color_brewer(palette = 'Set1') +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text = element_text(size = 17),
                 axis.title = element_text(size = 20),
                 legend.text = element_text(size = 17),
                 legend.title = element_text(size = 20),
                 strip.text.x = element_text(size = 20)) +
  ggplot2::ggsave(filename = "/Volumes/BACKUP/Documents/Masters/Loss_scores.png", device = "png", width = 14, height = 8, units = "in")
