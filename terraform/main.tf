terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

resource "kubernetes_namespace" "url_shortner" {
  metadata {
    name = "url_shortner"
  }
}

resource "kubernetes_deployment" "url_shortner" {
  metadata {
    name = "url_shortner"
    namespace = kubernetes_namespace.url_shortner.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "url_shortner"
      }
    }

    template {
      metadata {
        labels = {
          app = "url_shortner"
        }
      }

      spec {
        container {
          image = "ghcr.io/sherifemad53/url_shortner:latest"
          name  = "url_shortner"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "url_shortner" {
  metadata {
    name      = "url_shortner"
    namespace = kubernetes_namespace.url_shortner.metadata[0].name
  }

  spec {
    selector = {
      app = "url_shortner"
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "NodePort"
  }
}
