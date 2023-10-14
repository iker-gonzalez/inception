<h1 align="center">
🐳 inception 🐳
</h1>

<p align="center">
	<b><i>Development repo for 42cursus' inception project</i></b><br>
	For further information about 42cursus and its projects, please refer to <a href="https://github.com/iker-gonzalez/42_cursus"><b>42cursus repo</b></a>.
</p>

<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/iker-gonzalez/inception?color=blueviolet" />
	<img alt="Number of lines of code" src="https://img.shields.io/tokei/lines/github/iker-gonzalez/inception?color=blueviolet" />
	<img alt="Code language count" src="https://img.shields.io/github/languages/count/iker-gonzalez/inception?color=blue" />
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/iker-gonzalez/inception?color=blue" />
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/iker-gonzalez/inception?color=brightgreen" />
</p>

<h3 align="center">
	<a href="#%EF%B8%8F-about">About</a>
	<span> · </span>
	<a href="#%EF%B8%8F-usage">Usage</a>
</h3>

---

## 🗣️ About

>42_Inception is a Docker-compose project designed to streamline the creation of a robust LEMP stack, comprising Linux, Nginx, MariaDB, and PHP, all orchestrated seamlessly with WordPress. With this project, each service gets its own container, all operating within a dedicated Docker network, showcasing Docker as the key technology that powers this deployment. Additionally, the whole service is hosted within a dedicated Virtual Machine (using GCP Compute Engine service).

For detailed information, refer to the [**subject of this project**](https://github.com/iker-gonzalez/42_cursus/blob/main/_PDFs/en.subject_inception.pdf)


## 🏗 Arquitecture 

The system architecture for the "Inception" project is a comprehensive setup designed for system administration practice using Docker. It comprises various components and services orchestrated within a virtual machine environment. Here's a concise overview of the architecture:

- **Virtual Machine (VM):** The entire project takes place within a virtual machine, isolating and encapsulating the system components.

- **Dockerized Services:** The architecture involves multiple Docker containers, each serving a specific purpose. These containers are responsible for running various services, including NGINX, WordPress with PHP-FPM, and MariaDB. The containers are created using custom Dockerfiles, and each service operates within its dedicated container.

- **Volume Management:** Two volumes are utilized for data management. One volume holds the WordPress database, while the other stores the website files. These volumes ensure data persistence and separation.

- **Networking:** A custom Docker network connects the containers, facilitating communication and interaction between services.

- **TLS Encryption:** The NGINX container acts as the entry point into the infrastructure, serving via port 443. It provides TLSv1.2 or TLSv1.3 encryption, ensuring secure communication.

This architecture provides a robust environment for system administration learning, emphasizing Docker-based virtualization and the orchestration of multiple services within a virtual machine.


![System arquitecture](https://github.com/iker-gonzalez/inception/blob/main/inception_arquitecture.png)

 ## 🛠️ Usage
To run this project, follow these steps:

1. **Create a Virtual Machine:**
   - Create a VM with a user named "ikgonzal," and ensure that the "/home/ikgonzal" folder is in place.

2. **Edit Hosts File:**
   - Add the following line to your `/etc/hosts` file to set up the expected domain name:
     ```
     127.0.0.1 ikgonzal.42.fr
     ```

3. **Clone the Repository:**
   - Clone the 42_Inception repository to your VM by running the following command:
     ```bash
     git clone https://github.com/iker-gonzalez/inception.git
     ```

4. **Run the Project:**
   - Within the project folder, execute the following command:
     ```bash
     make all
     ```

5. **Access the Website:**
   - Open your web browser and visit "https://ikgonzal.42.fr."

6. **Certificate Warning:**
   - You may encounter a self-signed certificate warning; please proceed by ignoring this warning.
  
7. **Setup WordPress:**
   - Follow the initial setup steps for WordPress, and you'll be up and running with your website.
 
 ## 🔗 Resources
 
 [Docker-curriculum](https://docker-curriculum.com/)
 
 
