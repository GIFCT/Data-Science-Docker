# Data-Science-Docker

Set up an automated data science environment using Docker

Any changes to the Dockerfile will be automatically built in Docker Hub, so just pull the container:

`docker pull gifct/data-science`

Then you can either run the container interactively:

1. linux: `docker run -it -v ~/GitProjects:/root/GitProjects --network=host -i gifct/data-science`
2. MacOS or Windows: `docker run -it -v ~/GitProjects:/root/GitProjects -p 8888:8888 -i gifct/data-science`

Or run the container in a detached mode so that you can use Jupyter Notebooks but still use bash

1. linux:
```
docker run -d --name data-science -v ~/GitProjects:/root/GitProjects --network=host -i gifct/data-science
docker exec -it data-science bash
```
2. MacOS or Windows:
```
docker run --name data-science -v ~/GitProjects:/root/GitProjects -p 8888:8888 -i gifct/data-science
docker exec -it data-science bash
```

To access Jupyter Lab on your host machine, just navigate to `localhost:8888` and enter the token specified in your terminal.

#Build
docker build -t data-science .
