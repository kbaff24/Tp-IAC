terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}


provider "docker" {}
# provider "docker" {
#   host = "unix:///Users/username/.docker/run/docker.sock"
# }

resource "docker_network" "my_network" {
  name = "my_network"
}


# 1. Conteneur MySQL
resource "docker_container" "data" {
  name  = "data"
  image = "mysql:latest"
  env   = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=testdb"
  ]
}

# 2. Conteneur PHP-FPM
resource "docker_container" "php" {
  image = docker_image.php.image_id
  name  = "php-fpm"
  networks_advanced {
    name = docker_network.my_network.name
  }
volumes {
    host_path      = "C:/Users/brude/Documents/Cours_EFREI/Cours_M2/DEVOPS_MLOPS/IAC/TP1/ETAPE_2/test_bdd.php"
    container_path = "/usr/share/nginx/html/test_bdd.php"  # Chemin dans le conteneur
    read_only      = true
}
}

# 3. Conteneur NGINX
resource "docker_container" "nginx" {
  depends_on = [docker_container.php]
  image      = docker_image.nginx.image_id
  name       = "nginx"
  networks_advanced {
    name = docker_network.my_network.name
  }
  ports {
    internal = 80
    external = 8080
  }
  volumes {
    host_path      = "${path.cwd}/default.conf"
    container_path = "/etc/nginx/default.conf"
    read_only      = true
  }
  volumes {
    host_path      = "C:/Users/brude/Documents/Cours_EFREI/Cours_M2/DEVOPS_MLOPS/IAC/TP1/ETAPE_2/test_bdd.php"
    container_path = "/usr/share/nginx/html/test_bdd.php"  # Chemin dans le conteneur
    read_only      = true
  }
}




resource "docker_image" "nginx" {
  name = "nginx:1.27"
}

resource "docker_image" "php" {
  name = "php:8.3-fpm"
}
resource "docker_image" "mysql"{
  name = "mysql:latest"
}


