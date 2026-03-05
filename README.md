# ProjectTitle

---
> **instructions - delete later**
> In the main README.md file for this project you should include: - the project title - the list of contributors/authors - a short summary of the project (view from 10,000 feet) - how to run your data analysis - a list of the dependencies needed to run your analysis - the names of the licenses contained in LICENSE.md

---

Authors:
- Euna Ao
- Alice Le
- Issac So
- Mandy Yu

### Project Introduction

Our project uses a Docker container that is configured to run R and RStudio, version 4.4.2. Provided are the instructions for reproducing the environment. 

##### Using `docker-compose up`

`docker-compose up` will streamline the process of building and launching the Docker container, making it ideal for making edits and changes to the project. It uses a `docker-compose.yml` which configures, creates, and starts the Docker container in just one command. To manually build the image, refer below to the next section. 

1) Download Docker Desktop [here](https://docs.docker.com/desktop/setup/install/windows-install/). Instructions for download can be found on the webpage
2) Have Docker Desktop actively running
3) To create a copy of this project, clone this project repo to your local computer with the command `git clone git@github.com:UBC-DSCI-310-2025W2/dsci-310-group-16.git'
4) Navigate to the project root. It should look something like [*system path...*]/dsci-310-group-16
5) Run the command  `docker-compose up`. It will automatically pull the Docker image and build it according to specified configurations. Once the process is complete, you will see the end message of *analysis-env-1  | [services.d] done.*
6) Open a computer browser and type in "localhost:8787". Enter in the following credentials:
> username: rstudio
> password: group16
7) On the right-hand side, you will find the file navigation file. Within the project/ folder, you will find the contents of the repo.
8) To close the Docker container, hold the **Ctrl** key and click "C" twice. This will stop the running process. Once the process stops, enter the command  `docker-compose down`

### Dependencies 



### License 

MIT License 
