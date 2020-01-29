options(warn = -1, scipen = 999)

suppressPackageStartupMessages(library(googlesheets))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(RColorBrewer))

eval <- googlesheets::gs_title("All_evaluation_metrics")

metrics <- googlesheets::gs_read(eval)
metrics %>% dplyr::glimpse()
metrics <- metrics %>% dplyr::mutate(FID = FID/1e4)

metrics %>%
  dplyr::group_by(Origen, Objetivo) %>%
  dplyr::summarise(FID_mdn = median(FID, na.rm = T),
                   FID_mad = mad(FID, na.rm = T)) %>%
  ggplot2::ggplot(aes(x = factor(Objetivo, levels = c('Semillas','Carbonizados','Rostros')), y = FID_mdn, fill = factor(Origen, levels = c('Pinturas','Retratos','Pokemon','Habitaciones','Gatos')))) +
  ggplot2::geom_bar(stat = "identity", position = position_dodge()) +
  ggplot2::geom_errorbar(aes(ymin = FID_mdn-FID_mad, ymax = FID_mdn+FID_mad), width = .2, position = position_dodge(.9)) +
  ggplot2::scale_fill_brewer(palette = 'Set1') +
  ggplot2::scale_y_continuous(expand = c(0,0), limits = c(0, 70)) +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text = element_text(size = 17),
                 axis.title = element_text(size = 20),
                 legend.text = element_text(size = 17),
                 legend.title = element_text(size = 20)) +
  ggplot2::xlab('Dominio objetivo') +
  ggplot2::ylab('FID (mediana)') +
  ggplot2::labs(fill = 'Dominio de origen') +
  ggplot2::ggsave(filename = "/Volumes/BACKUP/Documents/Masters/FID_median_transfer_learning.png", device = "png", width = 8, height = 6, units = "in")

metrics %>%
  dplyr::mutate(Objetivo = factor(Objetivo, levels = c('Semillas','Carbonizados','Rostros'))) %>%
  dplyr::mutate(Origen = factor(Origen, levels = c('Pinturas','Retratos','Pokemon','Habitaciones','Gatos'))) %>%
  dplyr::group_by(Origen, Objetivo) %>%
  dplyr::mutate(Duración = (Iteración-min(Iteración))/30) %>%
  ggplot2::ggplot(aes(x = Duración, y = FID, group = Origen, colour = Origen)) +
  ggplot2::geom_line(size = 1.2) +
  ggplot2::geom_vline(xintercept = 24, linetype="dotted", size = 1.2) +
  ggplot2::facet_wrap(~Objetivo, scales = 'free') +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text = element_text(size = 17),
                 axis.title = element_text(size = 20),
                 legend.text = element_text(size = 17),
                 legend.title = element_text(size = 20),
                 strip.text = element_text(size = 20),
                 legend.position = "bottom") +
  ggplot2::scale_colour_brewer(palette = 'Set1') +
  ggplot2::xlab('Duración (horas)') +
  ggplot2::labs(colour = 'Dominio de origen') +
  ggplot2::ggsave(filename = "/Volumes/BACKUP/Documents/Masters/FID_over_time_transfer_learning.png", device = "png", width = 12, height = 6, units = "in")