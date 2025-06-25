terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

resource "kubernetes_namespace" "url-shortner" {
  metadata {
    name = "url-shortner"
  }
}

resource "kubernetes_deployment" "url-shortner" {
  metadata {
    name = "url-shortner"
    namespace = kubernetes_namespace.url-shortner.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "url-shortner"
      }
    }

    template {
      metadata {
        labels = {
          app = "url-shortner"
        }
      }

      spec {
        container {
          image = "ghcr.io/sherifemad53/url-shortner:latest"
          name  = "url-shortner"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "url-shortner" {
  metadata {
    name      = "url-shortner"
    namespace = kubernetes_namespace.url-shortner.metadata[0].name
  }

  spec {
    selector = {
      app = "url-shortner"
    }

    
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}
