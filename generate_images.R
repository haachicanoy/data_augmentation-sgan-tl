# Master code generative modeling thesis: generate images
# By: Harold Achicanoy
# Universidad del Valle

options(warn = -1, scipen = 999)
suppressMessages(library(readr))

data.frame(Source = c(c('paintings','portraits','pokemon','bedrooms','cats'),
                      c('paintings','bedrooms','cats'),
                      c('paintings','portraits','pokemon','bedrooms','cats')),
           Target = c(rep('beans',5),
                      rep('chars',3),
                      rep('young_faces',5)))
set.seed(1235)
seeds <- sample(0:100000, 5, replace = F)

generate_images <- function(source_domain = "paintings",
                            target_domain = "young_faces",
                            final_model = "network-final.pkl",
                            seed = seeds[1],
                            trunc_psi = 0.7)
{
  wk_dir <- paste0('stylegan_from_', source_domain, '_to_', target_domain)
  # Move to specific dir
  setwd(paste0('./', wk_dir))
  
  # Modify training_loop.py
  generating_imgs <- readLines('./generating_imgs.py')
  gen_imgs[] <- d # Model path
  gen_imgs[] <- s # Directory for saving images
}

gen_imgs <- readr::read_lines()
gen_imgs[] <- d # Model path
gen_imgs[] <- s # Directory for saving images