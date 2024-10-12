job "instagram-post" {
  datacenters = ["dc1"]
  group "instagram-post-group" {
    count = 1
    vault {
        address = "http://localhost:8200"
        policies = ["read"]
        token = "root"
    }
    task "node" {
      driver = "docker"
      artifact {
        source = "http://localhost:8080/instagram-post.tar"
        options {
          archive = false
        }
      }
     
      template {
        data = <<EOF
        {{- with secret "secret/data/database" -}}
        export POSTGRES_HOST="{{ .Data.POSTGRES_HOST }}"
        export POSTGRES_USER="{{ .Data.POSTGRES_USER }}"
        export POSTGRES_PASSWORD="{{ .Data.POSTGRES_PASSWORD }}"
        export POSTGRES_DB="{{ .Data.POSTGRES_DB }}"
        {{- end }}
        EOF
        destination = "secrets/config.json"
        change_mode = "restart"
      }
      config {
        load = "instagram-post.tar"
        image = "instagram-post"
        ports = ["http"]
        // entrypoint = ["/bin/sh", "-c"]
        // args = [
        //   ". secrets/env.sh && node app.js"
        // ]
      }
      resources {
        cpu    = 500
        memory = 256
      }
      service {
        name = "node-service"
        port = "http"
        check {
          name     = "http"
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
    network {
      port "http" {
        static = 3000
      }
    }
  }
}
