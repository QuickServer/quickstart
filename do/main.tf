# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

variable "do_token" {
  default = "xxx"
}

variable "prefix" {
  default = "yourname"
}

variable "rancher_version" {
  default = "latest"
}

variable "count_agent_all_small_nodes" {
  default = "1"
}

variable "count_agent_all_medium_nodes" {
  default = "1"
}

variable "count_agent_etcd_nodes" {
  default = "0"
}

variable "count_agent_controlplane_nodes" {
  default = "0"
}

variable "count_agent_worker_small_nodes" {
  default = "0"
}

variable "count_agent_worker_medium_nodes" {
  default = "0"
}

variable "admin_password" {
  default = "admin"
}

variable "cluster_name" {
  default = "ats-default-cluster"
}

variable "region" {
  default = "blr1"
}

variable "rancher_etcd_size" {
  default = "s-2vcpu-4gb"
}

variable "rancher_controlplane_size" {
  default = "s-2vcpu-4gb"
}

variable "rancher_server_size" {
  default = "s-2vcpu-4gb"
}

variable "rancher_all_role_small_agent_size" {
  default = "s-2vcpu-4gb"
}

variable "rancher_all_role_medium_agent_size" {
  default = "s-2vcpu-4gb"
}

variable "rancher_worker_small_agent_size" {
  default = "s-2vcpu-4gb"
}

variable "rancher_worker_medium_agent_size" {
  default = "s-2vcpu-4gb"
}

variable "docker_version_server" {
  default = "18.06"
}

variable "docker_version_agent" {
  default = "18.06"
}

variable "ssh_keys" {
  default = []
}

resource "digitalocean_droplet" "rancherserver" {
  count     = "1"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancherserver"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_server_size}"
  user_data = "${data.template_file.userdata_server.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-small-all" {
  count     = "${var.count_agent_all_small_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancheragent-small-${count.index}-all"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_all_role_small_agent_size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-medium-all" {
  count     = "${var.count_agent_all_medium_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancheragent-medium-${count.index}-all"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_all_role_medium_agent_size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-etcd" {
  count     = "${var.count_agent_etcd_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancheragent-${count.index}-etcd"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_etcd_size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-controlplane" {
  count     = "${var.count_agent_controlplane_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancheragent-${count.index}-controlplane"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_controlplane_size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-worker-small" {
  count     = "${var.count_agent_worker_small_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancheragent-${count.index}-worker"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_worker_small_agent_size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-worker-medium" {
  count     = "${var.count_agent_worker_medium_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-rancheragent-${count.index}-worker"
  region    = "${var.region}"
  monitoring = "true"
  size      = "${var.rancher_worker_medium_agent_size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

data "template_file" "userdata_server" {
  template = "${file("files/userdata_server")}"

  vars {
    admin_password        = "${var.admin_password}"
    cluster_name          = "${var.cluster_name}"
    docker_version_server = "${var.docker_version_server}"
    rancher_version       = "${var.rancher_version}"
  }
}

data "template_file" "userdata_agent" {
  template = "${file("files/userdata_agent")}"

  vars {
    admin_password       = "${var.admin_password}"
    cluster_name         = "${var.cluster_name}"
    docker_version_agent = "${var.docker_version_agent}"
    rancher_version      = "${var.rancher_version}"
    server_address       = "${digitalocean_droplet.rancherserver.ipv4_address}"
  }
}

output "rancher-url" {
  value = ["https://${digitalocean_droplet.rancherserver.ipv4_address}"]
}
