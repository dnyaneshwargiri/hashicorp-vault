job "instagram-post" {
  datacenters = ["dc1"]
  group "instagram-post-group" {
    count = 1
    vault {
        address = "http://127.0.0.1:8200/"
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
        export POSTGRES_HOST="{{ .Data.data.POSTGRES_HOST }}"
        export POSTGRES_USER="{{ .Data.data.POSTGRES_USER }}"
        export POSTGRES_PASSWORD="{{ .Data.data.POSTGRES_PASSWORD }}"
        export POSTGRES_DB="{{ .Data.data.POSTGRES_DB }}"
        export POSTGRES_PORT="{{ .Data.data.POSTGRES_PORT }}"
        {{- end }}
        EOF
        destination = "/local/secrets/env.sh" 
        env         = true
      }
      config {
        load = "instagram-post.tar"
        image = "instagram-post"
        ports = ["http"]
        entrypoint = ["/bin/sh", "-c"]
        args = [
          ". /local/secrets/env.sh && node index.js"
        ]
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
