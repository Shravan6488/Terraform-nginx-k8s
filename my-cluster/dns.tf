resource "google_dns_managed_zone" "primary" {
  name        = "shravan-zone"
  dns_name    = "devops.challenge."
  description = "DNS zone for the Raddit domain"
}

resource "google_dns_record_set" "a_shravan" {
  name = "${google_dns_managed_zone.primary.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.primary.name}"

  rrdatas = ["${google_compute_global_address.shravan_static_ip.address}"]
}

resource "google_dns_record_set" "cname_shravan" {
  name = "www.${google_dns_managed_zone.primary.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.primary.name}"

  rrdatas = ["${google_dns_managed_zone.primary.dns_name}"]
}

