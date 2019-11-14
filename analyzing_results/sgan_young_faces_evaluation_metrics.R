options(warn = -1, scipen = 999)

suppressPackageStartupMessages(library(googlesheets))
suppressPackageStartupMessages(library(tidyverse))

eval <- googlesheets::gs_title("Young faces evaluation metrics")

metrics <- googlesheets::gs_read(eval)
# metrics <- read.table("clipboard", sep = "\t", header = T); metrics$fid <- metrics$fid %>% as.character() %>% gsub(",", ".", ., fixed = T) %>% as.numeric()
metrics <- metrics %>% dplyr::mutate(fid = fid/1e4)

metrics %>%
  ggplot2::ggplot(aes(x = run, y = fid, colour = source_domain)) +
  ggplot2::geom_line() +
  ggplot2::ylim(0, 100) +
  ggplot2::labs(colour = "Source domain") +
  ggplot2::xlab("Iteration") +
  ggplot2::ylab("Frechet Inception Distance") +
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
  ggplot2::labs(colour = "Source domain") +
  ggplot2::xlab("Iteration") +
  ggplot2::ylab("Frechet Inception Distance") +
  ggplot2::theme(axis.text = element_text(size = 15),
                 axis.title = element_text(size = 17),
                 legend.text = element_text(size = 15),
                 legend.title = element_text(size = 17))

metrics %>%
  ggplot2::ggplot(aes(x = run, y = fid)) +
  ggplot2::geom_line() +
  ggplot2::xlab("Iteration") +
  ggplot2::ylab("Frechet Inception Distance") +
  ggplot2::facet_wrap(~source_domain, scales = "free_x") +
  ggplot2::theme(axis.text = element_text(size = 15),
                 axis.title = element_text(size = 17))
