resource "yandex_vpc_network" "network-main" {
  name = "network-ad"
}

resource "yandex_vpc_subnet" "subnet-main" {
  name           = "subnet-main"
  network_id     = yandex_vpc_network.network-main.id
  v4_cidr_blocks = ["10.133.0.0/24"]
}