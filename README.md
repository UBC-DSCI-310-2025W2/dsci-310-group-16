# Predicting Child Height from Parental Height: A Linear Regression Analysis of the Galton Height Dataset

Authors:
- Euna Ao
- Alice Le
- Isaac So
- Mandy Yu

## Project Introduction

Our project explores the relationship between parents' height and offspring gender in predicting offspring height. We performed a multi-variate regression with Sir Francis Galton's GaltonFamilies Height Dataset (Galton, 1886) with a 80/20 train/test split. Our results suggest a statistically significant relationship between midparent height (the weighted average of parents' height) and offspring height, as well as a statistically significant interaction between offspring gender and offspring height. 

Our project uses a Docker container that is configured to run R and RStudio (version 4.5.2) with `tidyverse`. Provided are the instructions for reproducing the environment. 


## Instructions for Use


#### Using Docker-Compose 

We strongly recommend using `docker-compose up` to launch and build the Docker container. It uses a `docker-compose.yml` which configures, creates, and starts the Docker container in just one command. To manually build the image, refer below to the section titled "Manually Building the Docker Image"

Docker Desktop will be required to reproduce our computational environment and run the project. Below are the basic steps in installing Docker Desktop and cloning the project repo. 

1) Download Docker Desktop [here](https://docs.docker.com/desktop/setup/install/windows-install/). Instructions for download can be found on the webpage.  
2) Have Docker Desktop actively running.  
3) To create a copy of this project, clone this project repo to your local computer with the command  
```bash
git clone git@github.com:UBC-DSCI-310-2025W2/dsci-310-group-16.git'
```
4) Navigate to the project root. It should look something like `[*system path...*]/dsci-310-group-16`.    
5) Ensure you are at the project root. Run the command  
```bash
docker-compose up
```
 It will automatically pull the Docker image and build it according to specified configurations. Once the process is complete, you will see the end message of *analysis-env-1  | [services.d] done.*  
 
6) Open a computer browser and type in "localhost:8787". Enter in the following credentials:  
> username: rstudio  
> password: group16
7) On the right-hand side, you will find the file navigation file. Within the `project/` folder, you will find the contents of the repository.  
8) Ensure you are within the `project/ folder`. Navigate to the RProj file. It should be titled *dsci-310-group-16.Rproj`*. Click on the RProj file to open the project. 
9) Once the project is open, restore the R environment to load the necessary packages needed to run the analysis. To do so, navigate to the console and enter:

```bash
renv::restore()
```
It will take a few moments for the environment to initialize and all the packages to load. Once the environment is initialized, proceed to running the analysis. 

#### Running The Analysis with Make

The project is set up with a Makefile to automate the workflow. This will allow the entire project to be run from start to finish, including but not limited to, reading in data, running the analysis, creating intermediate objects, rendering the report, and cleaning the repository. The steps are as follows:

10) To run the entire analysis, type the following using Bash:
   
```bash
make all
```

The intermediate outputs will automatically generate. Once the process is complete, the rendered reports can be found within the 'results/' folder.

11) To clean the repository and remove intermediate outputs, type the following using Bash:

```
make clean
```

This will remove the intermediate outputs as well as the rendered reports. 

#### Closing the Container 

12) To close the Docker container, hold the **Ctrl** key and click "C" twice. This will stop the running process. To stop and remove the container, enter the command:
```
docker-compose down
```  

### Manually Building the Docker Image

#### Building From the Dockerfile 

While we recommend using  `docker-compose`, the Docker container can also be built directly from the Dockerfile.  

1) Navigate to the project repository root.  
2) Using bash, run the command `docker build --tag dsci-310-group-16 .`. It will take a moment for the process to complete.  
3) After the process has complete, run the following command in bash:

```bash
    docker run \
    --rm \
    -p 8787:8787 \
    -e PASSWORD="group16" \
    dsci-310-group-16`
```
4) Proceed with Step 6-11 from the instructions above (i.e. section "Instructions for Use") to finish setting up the environment and run the analysis
5) To close the container, make sure to save your progress. The command `exit` in Bash will stop the container.  
6) Optional: To clean up the container afterwards, run the following command to clean up any dangling images, unused containers, or unused cache:
```bash
docker system prune
```


#### Creating Docker container from Dockerhub 

The Docker container can also be built from pulling the Docker image off Dockerhub. The image can be found on Dockerhub [here](https://hub.docker.com/r/eao939/dsci310-group16-docker).

1) Navigate to the project repository root.  
2) In bash, run the following command to pull the Docker image from Dockerhub
```bash
docker pull eao939/dsci310-group16-docker
```
3) After the process has complete, run the following command in bash:

```bash
    docker run \
    --rm \
    -p 8787:8787 \
    -e PASSWORD="group16" \
    eao939/dsci310-group16-docker`
```

4) Proceed with Step 6-11 from the instructions above (i.e. section "Instructions for Use") to finish setting up the environment and run the analysis
5) To close the container, make sure to save your progress. The command `exit` in bash will stop the container.  
6) Optional: To clean up the container afterwards, run the following command to clean up any dangling images, unused containers, or unused cache:
```bash
docker system prune
```

## Dependencies 
- tidyverse
- tidymodels
- janitor
- HistData
- rmarkdown
- IRkernel
- renv

## License 

MIT License   
CC BY-NC-ND 4.0


## References

Carlos Bozzoli, Angus Deaton, & Climent Quintana-Domeque. (2009). Adult Height and Childhood Disease. Demography, 46(4), 647–669. https://doi.org/10.1353/dem.0.0079  

Galton, F. (1886). Regression Towards Mediocrity in Hereditary Stature **Journal of the Anthropological Institute**, 15, 246-263  

Jelenkovic, A., Sund, R., Yokoyama, Y., Latvala, A., Sugawara, M., Tanaka, M., Matsumoto, S., Freitas, D. L., Maia, J. A., Knafo-Noam, A., Mankuta, D., Abramson, L., Ji, F., Ning, F., Pang, Z., Rebato, E., Saudino, K. J., Cutler, T. L., Hopper, J. L., & Ullemar, V. (2020). Genetic and environmental influences on human height from infancy through adulthood at different levels of parental education. Scientific Reports, 10(1), 7974. https://doi.org/10.1038/s41598-020-64883-8  

Tanner, J. M., Goldstein, H., & Whitehouse, R. H. (1970). Standards for Children’s Height at Ages 2-9 Years Allowing for Height of Parents. Archives of Disease in Childhood, 45(244), 755–762. https://doi.org/10.1136/adc.45.244.755
