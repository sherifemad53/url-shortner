terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

resource "kubernetes_namespace" "LOCALURL_SHORTNER_PLATFORM" {
  metadata {
    name = "LOCALURL_SHORTNER_PLATFORM"
  }
}

resource "kubernetes_deployment" "LOCALURL_SHORTNER_PLATFORM" {
  metadata {
    name = "LOCALURL_SHORTNER_PLATFORM"
    namespace = kubernetes_namespace.LOCALURL_SHORTNER_PLATFORM.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "LOCALURL_SHORTNER_PLATFORM"
      }
    }

    template {
      metadata {
        labels = {
          app = "LOCALURL_SHORTNER_PLATFORM"
        }
      }

      spec {
        container {
          image = "ghcr.io/sherifemad53/LOCALURL_SHORTNER_PLATFORM:latest"
          name  = "LOCALURL_SHORTNER_PLATFORM"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LOCALURL_SHORTNER_PLATFORM" {
  metadata {
    name      = "LOCALURL_SHORTNER_PLATFORM"
    namespace = kubernetes_namespace.LOCALURL_SHORTNER_PLATFORM.metadata[0].name
  }

  spec {
    selector = {
      app = "LOCALURL_SHORTNER_PLATFORM"
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "NodePort"
  }
}
