resource "yandex_compute_instance" "ca" {
  #checkov:skip=CKV_YC_2:This host should have public ip
  allow_stopping_for_update = true
  name                      = "ca"
  hostname                  = "ca"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.default_image
      type     = "network-ssd"
      size     = 25
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-main.id
    nat        = true
    ip_address = "10.133.0.3"
  }

  metadata = {
    user-data = local.admin_secret
  }

  # wait til the instance is ready
  provisioner "remote-exec" {
    inline = ["# connected"]
    connection {
      type        = "ssh"
      user        = var.admin_username
      host        = yandex_compute_instance.ca.network_interface.0.nat_ip_address
      private_key = file(var.private_key)
    }
  }
}

resource "yandex_compute_instance" "dns" {
  #checkov:skip=CKV_YC_2:This host should have public ip
  allow_stopping_for_update = true
  name                      = "dns"
  hostname                  = "dns"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.default_image
      type     = "network-ssd"
      size     = 25
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-main.id
    nat        = true
    ip_address = "10.133.0.4"
  }

  metadata = {
    user-data = local.admin_secret
  }

  # wait til the instance is ready
  provisioner "remote-exec" {
    inline = ["# connected"]
    connection {
      type        = "ssh"
      user        = var.admin_username
      host        = yandex_compute_instance.ca.network_interface.0.nat_ip_address
      private_key = file(var.private_key)
    }
  }
}

resource "yandex_compute_instance" "server" {
  #checkov:skip=CKV_YC_2:This host should have public ip
  count                     = 2
  allow_stopping_for_update = true
  name                      = "server-${count.index}"
  hostname                  = "server-${count.index}"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.default_image
      type     = "network-ssd"
      size     = 25
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-main.id
    nat        = true
    ip_address = "10.133.0.${count.index + 5}"
  }

  metadata = {
    user-data = local.admin_secret
  }

  # wait til the instance is ready
  provisioner "remote-exec" {
    inline = ["# connected"]
    connection {
      type        = "ssh"
      user        = var.admin_username
      host        = yandex_compute_instance.ca.network_interface.0.nat_ip_address
      private_key = file(var.private_key)
    }
  }
}

resource "yandex_compute_instance" "client" {
  #checkov:skip=CKV_YC_2:This host should have public ip
  count                     = 2
  allow_stopping_for_update = true
  name                      = "client-${count.index}"
  hostname                  = "client-${count.index}"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.default_image
      type     = "network-ssd"
      size     = 25
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-main.id
    nat        = true
    ip_address = "10.133.0.${count.index + 8}"
  }

  metadata = {
    user-data = local.admin_secret
  }

  # wait til the instance is ready
  provisioner "remote-exec" {
    inline = ["# connected"]
    connection {
      type        = "ssh"
      user        = var.admin_username
      host        = yandex_compute_instance.ca.network_interface.0.nat_ip_address
      private_key = file(var.private_key)
    }
  }
}

