#Cluster Name
cluster_name = "ats-production"
# DigitalOcean API token
do_token = "token----change--me"
# Admin password to access Rancher
admin_password = "pwd---change--me"
# Resources will be prefixed with this to avoid clashing names
prefix = "myrancher"
# rancher/rancher image tag to use
rancher_version = "v2.1.1"
# Region where resources should be created
region = "blr1"
# Count of agent nodes with role all with small resources 2CPU 4GB
count_agent_all_small_nodes = "2"
# Count of agent nodes with role all with medium resources 4CPU 8GB
count_agent_all_medium_nodes = "1"
# Count of agent nodes with role etcd
count_agent_etcd_nodes = "0"
# Count of agent nodes with role controlplane
count_agent_controlplane_nodes = "0"
# Count of agent nodes with role worker with small resources 2CPU 4GB 
count_agent_worker_small_nodes = "0"
# Count of agent nodes with role worker with medium resources 2CPU 4GB 
count_agent_worker_medium_nodes = "0"
# Docker version of host running `rancher/rancher`
docker_version_server = "18.06"
# Docker version of host being added to a cluster (running `rancher/rancher-agent`)
docker_version_agent = "18.06"
# Droplet size
rancher_etcd_size = "s-2vcpu-4gb"
rancher_controlplane_size = "s-2vcpu-4gb"
rancher_server_size = "s-1vcpu-3gb"
rancher_all_role_small_agent_size = "s-2vcpu-4gb"
rancher_all_role_medium_agent_size = "s-4vcpu-8gb"

rancher_worker_small_agent_size = "s-2vcpu-4gb"
rancher_worker_medium_agent_size = "s-4vcpu-8gb"

# DigitalOcean ssh-keyid: retrieve using `curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/account/keys?per_page=200"  | jq -r '.ssh_keys[] | select(.name=="YOUR_KEY_NAME") | .id'`
# ssh_keys = [ "your_key_id" ]
# If this is not specified, you will get an email with the root password
#ssh_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3AVJvg82NO4JTmgRaj8HIdmIfDf5Igv39kGBSCJiMIUgYxCoLRlW1R23VyYD027hUN8OGkiPEviIhVUOLlhX1y4zYZidMW1Bp9F+p8zNkwZmIntyY6GAqponZtrYjPPkcnL5z0h23caNLQWpkEhynF3F84r3Jbp0XxTb3JQW6NmI4V6Cz+Ll1a3b5JH35ZvQeXRK+X1lXKjwQNBFG36GnmsI3JCYVbTlhQ6JVfbbTqNOFg1+dfVr7gq9O4ok0dG4HqCLvHDU8sqrfxwenFpSjlW8j3OkmiDmi4rThtxBmoEn62KR3e6ZqsqBM/wRn1SRB7npDO8vcYXMFwEzMQAyJ"]
ssh_keys = []
