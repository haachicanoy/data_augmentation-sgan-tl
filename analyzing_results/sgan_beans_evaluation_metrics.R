options(warn = -1, scipen = 999)

suppressPackageStartupMessages(library(googlesheets))
suppressPackageStartupMessages(library(tidyverse))

eval <- googlesheets::gs_title("Evaluation metrics")

metrics <- googlesheets::gs_read(eval)
metrics <- metrics %>% dplyr::mutate(fid = fid/1e4)

metrics %>%
  ggplot2::ggplot(aes(x = run, y = fid, colour = source_domain)) +
  ggplot2::geom_line() +
  ggplot2::ylim(0, 270) +
  ggplot2::labs(colour = "Dominio original") +
  ggplot2::xlab("Iteración") +
  ggplot2::ylab("Fréchet Inception Distance") +
  ggplot2::theme(axis.text = element_text(size = 15),
                 axis.title = element_text(size = 17),
                 legend.text = element_text(size = 15),
                 legend.title = element_text(size = 17))

metrics %>%
  dplyr::group_by(source_domain) %>%
  dplyr::mutate(run = scale(run)) %>%
  ggplot2::ggplot(aes(x = run, y = fid, colour = source_domain)) +
  ggplot2::geom_line() +
  ggplot2::ylim(0, 270) +
  ggplot2::labs(colour = "Dominio de origen") +
  ggplot2::xlab("Número de corrida") +
  ggplot2::ylab("Fréchet Inception Distance") +
  ggplot2::theme(axis.text = element_text(size = 15),
                 axis.title = element_text(size = 17),
                 legend.text = element_text(size = 15),
                 legend.title = element_text(size = 17))

metrics %>%
  ggplot2::ggplot(aes(x = run, y = fid)) +
  ggplot2::geom_line() +
  ggplot2::xlab("Número de corrida") +
  ggplot2::ylab("Fréchet Inception Distance") +
  ggplot2::facet_wrap(~source_domain, scales = "free_x") +
  ggplot2::theme(axis.text = element_text(size = 15),
                 axis.title = element_text(size = 17))
