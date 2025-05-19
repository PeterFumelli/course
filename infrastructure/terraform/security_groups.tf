resource "yandex_vpc_security_group" "bastion" {
  name       = "bastion-sg"
  network_id = yandex_vpc_network.main.id

    ingress {
    protocol       = "TCP"
    description    = "Allow SSH from anywhere"
    port           = 22
    v4_cidr_blocks = ["46.228.7.154/32"]
  }

   egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "yandex_vpc_security_group" "nat" {
  name       = "nat-sg"
  network_id = yandex_vpc_network.main.id
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["46.228.7.154/32"]
    description    = "Allow SSH from your IP"
  }

  # Разрешаем весь трафик с private-subnet на NAT
  ingress {
    protocol       = "ANY"
    v4_cidr_blocks = ["10.10.2.0/24"]
    description    = "Allow from private subnet"
  }

  # Разрешаем NAT-инстансу выходить в интернет
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow outbound"
  }
}