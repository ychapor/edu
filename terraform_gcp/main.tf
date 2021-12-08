terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210927"
    }
  }

  tags = ["http-server"]

  metadata = {
    ssh-keys = format("%s:${file(var.ssh_public_key)}", var.ssh_username)
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file("apache_install_script")
}

output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
