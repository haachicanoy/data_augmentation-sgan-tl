# Calculating metrics for generative models
# By: Harold Achicanoy
# Universidad del Valle

options(warn = -1, scipen = 999)
suppressMessages(library(readr))

# Define working directory
root <- '/media/argos/MultimediaAn/HTH'
setwd(root) # Harold THesis

source_list <- c("portraits","pokemon","paintings","cats","bedrooms")
target_list <- c("beans")

for(target in target_list){
  for(source in source_list){
    
    # Set working directory
    setwd(paste0("/media/argos/MultimediaAn/HTH/simulations/stylegan_from_", source, "_to_", target))
    # Setting up run_metrics.py
    run_metrics <- readLines('./run_metrics.py')
    run_metrics[77] <- paste0("    #tasks += [EasyDict(run_func_name='run_metrics.run_pickle', network_pkl='https://drive.google.com/uc?id=1MEGjdvVpUsu1jB4zrXZN7Y4kBBOzizDQ', dataset_args=EasyDict(tfrecord_dir='ffhq', shuffle_mb=0), mirror_augment=True)] # karras2019stylegan-ffhq-1024x1024.pkl")
    run_metrics[79] <- paste0("    tasks += [EasyDict(run_func_name='run_metrics.run_all_snapshots', run_id=0)]")
    readr::write_lines(run_metrics, './run_metrics.py')
    rm(run_metrics)
    
    system('python run_metrics.py')
    cat(paste0('Evaluation metrics for experiment stylegan from ', source, " to ", target, ' calculated successfully!\n'))
    
  }
}
