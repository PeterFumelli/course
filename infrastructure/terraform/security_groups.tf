resource "yandex_vpc_security_group" "bastion" {
  name       = "bastion-sg"
  network_id = yandex_vpc_network.main.id

    ingress {
    protocol       = "TCP"
    description    = "Allow SSH from anywhere (или пропиши свой IP)"
    port           = 22
    v4_cidr_blocks = ["46.228.7.154/32"]
  }

   egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}