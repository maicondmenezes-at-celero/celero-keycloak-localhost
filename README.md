# Celero Keycloak Localhost

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Project Components](#components)
  - [Importing Extensions](#importing_extensions)
  - [Importing Themes](#importing_themes)
- [Usage](#usage)
- [Maintenance](#maintenance)
- [Contributing](../CONTRIBUTING.md)
- [References](#references)

## About <a name = "about"></a>

Celero Keycloak Localhost is a project designed to extend Keycloak's capabilities with custom extensions and themes, specifically tailored for Celero's development environment. This project allows developers to deploy a local instance of Keycloak, providing a simplified environment to test applications that interact with the Celero Keycloak Server.

The project includes the following components:

- **Keycloak with Custom Extensions**: The primary service includes a two-factor authentication (2FA) extension that enhances security by integrating Keycloak with various authenticator applications, such as Google Authenticator and Authy. Additionally, it provides custom themes to customize the user interface of the Keycloak login and administration portals.

- **PostgreSQL Database**: A PostgreSQL database is included to manage Keycloak’s data. This ensures that your local Keycloak instance has a robust and reliable database backend, mirroring the production environment as closely as possible.

- **Mailhog**: Mailhog is included to capture and display emails sent by Keycloak. This is particularly useful for testing email-based features, such as account verification and password recovery, without needing to send real emails.

## Getting Started <a name = "getting_started"></a>

These instructions will guide you through setting up a local copy of the project for development, testing, and customization.

### Prerequisites

Before you begin, ensure you have the following installed on your machine:

- Docker
- Docker Compose
- Maven
- Git

### Cloning the Project

Clone the repository to your local machine:

```bash
git clone https://github.com/maicondmenezes-at-celero/celero-keycloak-localhost
cd celero-keycloak-localhost
```

### Running the Project

Use the Makefile to build and run the project. This will start Keycloak and Mailhog services.

1. **Build the Docker Containers:**

   ```bash
   make build
   ```

2. **Start the Services:**

   ```bash
   make up
   ```

## Project Components <a name = "components"></a>

### Importing Extensions <a name = "importing_extensions"></a>

Extensions in Keycloak can be imported either by directly using the compiled JAR files or by building the extensions from source code.

#### Using Precompiled JAR Files

To import an extension using a precompiled JAR file:

1. Place the JAR files in the `extensions` directory:

   ```bash
   migration-local/celero-keycloack/extensions/your-extension.jar
   ```

2. Ensure your `docker-compose.yml` mounts the `extensions` directory to the Keycloak container:

   ```yaml
   volumes:
     - ./extensions:/opt/keycloak/providers
   ```

#### Building Extensions from Source Code

To import an extension using the source code:

1. **Add the Source Code:**

   Place the source code of the extension in the `extensions` directory:

   ```bash
   migration-local/celero-keycloack/keycloak/extensions/your-extension/
   ```

2. **Build the Extension:**

   Ensure that the source code includes a `pom.xml` file for Maven. The project will be built as part of the Keycloak Docker image build process.

3. **Mount the Compiled JAR:**

   After the Docker build process, the compiled JAR file will be automatically included in the Keycloak container’s `providers` directory.

### Importing Themes <a name = "importing_themes"></a>

The `themes` directory contains custom Keycloak themes to customize the user interface.

To import a theme into the project:

1. Place your theme in the `themes` directory following the structure:

   ```bash
   migration-local/celero-keycloack/themes/your-theme/
   ```

2. Ensure your `docker-compose.yml` mounts the `themes` directory to the Keycloak container:

   ```yaml
   volumes:
     - ./themes:/opt/keycloak/themes
   ```

## Usage <a name = "usage"></a>

### Accessing Keycloak

Once the services are up and running, you can access the Keycloak Admin Console:

- **URL:** `http://localhost:8080`
- **Admin Username:** `admin`
- **Admin Password:** `admin`

### Setting Up Mailhog in Keycloak

To configure Mailhog as the SMTP server for your Keycloak instance, follow these steps:

1. **Access Keycloak Admin Console**:
   - Go to `http://localhost:8080` and log in with your admin credentials.

2. **Navigate to Realm Settings**:
   - Select the realm you are working with from the dropdown menu in the upper-left corner.

3. **Configure SMTP Server**:
   - In the left-hand menu, select `Realm Settings` and then click on the `Email` tab.
   - Enter the following SMTP configuration settings:

     - **SMTP Server**: `mailhog`
     - **SMTP Port**: `1025`
     - **From**: `no-reply@yourdomain.com` (This can be any valid email format)
     - **From Display Name**: `Keycloak`
     - **Reply To**: `support@yourdomain.com` (Optional)
     - **Enable SSL/TLS**: Leave unchecked
     - **Enable StartTLS**: Leave unchecked
     - **Authentication Enabled**: Leave unchecked

   - Click `Save` to apply the changes.

4. **Test Email Configuration**:
   - Click the `Test Connection` button to verify that Keycloak can send emails using Mailhog. If configured correctly, the email should appear in the Mailhog interface at `http://localhost:8025`.

### Accessing Mailhog

Mailhog is used for testing email functionality within the Keycloak environment. You can access it at:

- **URL:** `http://localhost:8025`

## Maintenance <a name = "maintenance"></a>

The Makefile provides several commands to manage the Docker services. Below are some of the most commonly used commands:

### Starting and Stopping Services

- **Start the services:**

  ```bash
  make up
  ```

- **Stop the services:**

  ```bash
  make down
  ```

### Building the Project

- **Build the Docker images:**

  ```bash
  make build
  ```

### Restarting Services

- **Restart all services:**

  ```bash
  make restart
  ```

### Viewing Logs

- **View logs for all services:**

  ```bash
  make logs
  ```

- **View logs for Keycloak only:**

  ```bash
  make logs-keycloak
  ```

- **View logs for PostgreSQL only:**

  ```bash
  make logs-postgres
  ```

- **View logs for Mailhog only:**

  ```bash
  make logs-mailhog
  ```

### Cleaning Up

- **Remove all services and associated volumes:**

  ```bash
  make clean
  ```

### Resetting the Project

- **Stop, rebuild, and start the services with logs:**

  ```bash
  make reset
  ```

- **Hard reset (removes volumes, rebuilds, and restarts the services):**

  ```bash
  make hard-reset
  ```

## References <a name = "references"></a>

- [Keycloak Documentation](https://www.keycloak.org/documentation)
- [Docker Documentation](https://docs.docker.com/)
- [Maven Documentation](https://maven.apache.org/guides/index.html)
