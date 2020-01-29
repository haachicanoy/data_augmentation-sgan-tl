# Obtain latent space from StyleGAN snapshots
# By: Harold Achicanoy
# Universidad del Valle

options(warn = -1, scipen = 999)
suppressMessages(library(readr))

# Define working directory
root <- '/media/argos/DATA/HTH'
setwd(root) # Harold THesis

source_list <- c('portraits','pokemon','paintings','cats','bedrooms')
target_list <- c('beans','chars','young_faces')

for(target in target_list){
  for(source in source_list){
    
    cat('>>> List trained models ...\n')
    dir <- paste0(root,'/simulations/stylegan_from_',source,'_to_',target,'/results/00000-sgan-custom-1gpu')
    pkl <- basename(list.files(path = dir, pattern = '*.pkl$', full.names = T))
    if(length(grep('submit_config.pkl',pkl)) > 0){
      pkl <- pkl[-grep('submit_config.pkl',pkl)]
    }
    
    for(m in pkl){
      cat(paste0('>>> Obtain latent space for: ',target,' from ',source,' snapshot ',m,'\n'))
      obtain_ls     <- readLines(paste0(root, '/scripts/obtain_latent_vectors.py'))
      obtain_ls[11] <- paste0('model_path = "',root,'/simulations/stylegan_from_',source,'_to_',target,'/results/00000-sgan-custom-1gpu/',m,'"')
      obtain_ls[26] <- paste0('np.savetxt("',root,'/latent_space/',target,'/ls_',source,'2',target,'_',tools::file_path_sans_ext(m),'.csv','", latent_array, delimiter=",")')
      readr::write_lines(obtain_ls,paste0(paste0(root,'/simulations/stylegan_from_',source,'_to_',target,'/ols_',source,'2',target,'_',tools::file_path_sans_ext(m),'.py')))
      
      system(paste0('python ',root,'/simulations/stylegan_from_',source,'_to_',target,'/ols_',source,'2',target,'_',tools::file_path_sans_ext(m),'.py'))
      cat(paste0('StyleGAN latent space from ',source," to ",target,' model ',tools::file_path_sans_ext(m),' obtained successfully!\n'))
    }
  }
}
