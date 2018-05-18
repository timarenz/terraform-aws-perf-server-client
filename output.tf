output client_public_ip {
  value = "${aws_instance.client.public_ip}"
}

output "server_private_ips" {
  value = "${aws_instance.server.*.private_ip}"
}
