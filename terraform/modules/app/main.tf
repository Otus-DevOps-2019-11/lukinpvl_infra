resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params { image = var.app_disk_image }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
   provisioner "remote-exec" {
    inline = [<<EOF
      set -e
      cat > /tmp/puma.service <<'EOT'
      [Unit]
      Description=Puma HTTP Server
      After=network.target

      [Service]
      Type=simple
      User=appuser
      WorkingDirectory=/home/appuser/reddit
      Environment=DATABASE_URL=${var.reddit_db_ip}
      ExecStart=/usr/local/bin/puma -C /var/lib/gems/2.3.0/gems/puma-3.10.0/lib/puma.rb --dir /home/appuser/reddit
      Restart=always

      [Install]
      WantedBy=multi-user.target
      EOF
    ]
  }
  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
