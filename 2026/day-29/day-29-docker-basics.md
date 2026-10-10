# Day 29 – Introduction to Docker 🚀

## Task 1: What is Docker?

### What is a Container?

A container is a lightweight and portable package that contains an application along with all its dependencies, libraries, and configurations.

Benefits:

* Consistent environments
* Fast deployment
* Easy scalability
* Better resource utilization

---

## Containers vs Virtual Machines

| Containers           | Virtual Machines       |
| -------------------- | ---------------------- |
| Share host OS kernel | Have separate guest OS |
| Lightweight          | Heavyweight            |
| Fast startup         | Slower startup         |
| Less resource usage  | More resource usage    |
| Portable             | Less portable          |

---

## Docker Architecture

Docker consists of:

### Docker Client

Used to interact with Docker.

Example:

```bash
docker run nginx
```

### Docker Daemon

Runs in the background and manages Docker objects.

### Docker Images

Read-only templates used to create containers.

Example:

```bash
nginx
ubuntu
mysql
```

### Docker Containers

Running instances of Docker images.

### Docker Registry

Stores Docker images.

Example:

* Docker Hub

---

## Docker Architecture Flow

```text
Docker Client
      │
      ▼
Docker Daemon
      │
 ┌────┴────┐
 ▼         ▼
Images  Containers
      │
      ▼
Docker Hub
```

---

# Task 2: Install Docker

## Verify Installation

```bash
docker --version
```

### Output

```text
Docker version 28.x.x
```

---

## Run Hello World

```bash
docker run hello-world
```

### Observation

Docker downloaded the image from Docker Hub and started a container successfully.

---

# Task 3: Run Real Containers

## Run Nginx Container

```bash
docker run -d -p 8080:80 --name my-nginx nginx
```

Access:

```text
http://localhost:8080
```

---

## Run Ubuntu Container

```bash
docker run -it ubuntu bash
```

Inside container:

```bash
ls
pwd
cat /etc/os-release
```

---

## List Running Containers

```bash
docker ps
```

---

## List All Containers

```bash
docker ps -a
```

---

## Stop Container

```bash
docker stop my-nginx
```

---

## Remove Container

```bash
docker rm my-nginx
```

---

# Task 4: Docker Exploration

## Detached Mode

```bash
docker run -d nginx
```

### Observation

Container runs in the background.

---

## Custom Name

```bash
docker run -d --name devops-nginx nginx
```

---

## Port Mapping

```bash
docker run -d -p 8080:80 nginx
```

Host Port:
8080

Container Port:
80

---

## View Logs

```bash
docker logs devops-nginx
```

---

## Execute Command Inside Running Container

```bash
docker exec -it devops-nginx bash
```

Example:

```bash
ls
pwd
```

---

# Commands Practiced

```bash
docker --version
docker run hello-world
docker run -d -p 8080:80 nginx
docker run -it ubuntu bash
docker ps
docker ps -a
docker stop my-nginx
docker rm my-nginx
docker logs devops-nginx
docker exec -it devops-nginx bash
```

---

# What I Learned

1. Docker containers are lightweight compared to virtual machines.
2. Images are templates used to create containers.
3. Containers can run in foreground or background mode.
4. Port mapping allows access to containerized applications.
5. Docker is a core technology used in modern DevOps and Kubernetes environments.

