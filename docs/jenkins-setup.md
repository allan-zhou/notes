# Jenkins Setup

Jenkins is an open source automation server written in Java.

Jenkins helps to automate the non-human part of software development process, with **continuous integration** and facilitating technical aspects of **continuous delivery**.

## Depends

- [Java8](./install-jdk.md)
- [Docker](./install-docker-ce.md)

## Install Jenkins using docker

- insall

```bash
docker run \
  -u root \
  --rm \
  -d \
  -p 9000:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name jenkins-blueocean \
  jenkinsci/blueocean
```

- open a browser on `http://hostIP:9000`

- unlocking jenkins

get initialAdminPassword

```bash
# enter the container
docker exec -it jenkins-blueocean bash

# cat the password
cat /var/jenkins_home/secrets/initialAdminPassword
```

## Using Jenkins

### Pipeline

Jenkins Pipeline is a suite of plugins which supports implementing and integrating **continuous delivery pipelines** into Jenkins.

The definition of a Jenkins Pipeline is written into a text file ,called a Jenkinsfile.

[see more ..](https://jenkins.io/doc/book/pipeline/)

### Blue Ocean

Blue Ocean rethinks the user experience of Jenkins.

[see more ..](https://jenkins.io/doc/book/blueocean/)

## gitlab integration

在执行docker run时，增加如下配置，即不需进入jenkins container配置hosts访问gitlab

```bash
  --add-host=gitlab.example.com:192.168.1.20
```

## reference

- [jenkins.io/doc](https://jenkins.io/doc/)
- [Comparison of continuous integration software](https://en.wikipedia.org/wiki/Comparison_of_continuous_integration_software)
- [jenkins gitlab plugin](https://github.com/jenkinsci/gitlab-plugin)