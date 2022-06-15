provider "mysql" {
  endpoint = "120.77.78.168:3306"
  username = "app-user"
  password = "app-password"
}
provider "linux" {
    host = "120.77.78.168"
    port = 22
    user = "root"
    password = "lxw123"
}
provider "alicloud" {
     
}
provider "nginx" {
  enable_symlinks = false # all resources are created in the path defined at directory_available. directory_enabled is ignored.
}

# This will create file /etc/nginx/conf.d/test.conf
resource "nginx_server_block" "my-server" {
  filename = "test.conf"
  content = <<EOF
# content of file here
EOF
}
# Create a Database
resource "mysql_database" "app" {
  name = "my_awesome_app"
}
resource "linux_directory" "directory" {
    path = "/tmp/linux/dir"
    owner = 1000
    group = 1000
    mode = "755"
    overwrite = true
    recycle_path = "/tmp/recycle"
}

resource "linux_file" "file" {
    path = "/tmp/linux/file"
    content = <<-EOF
        hello world
    EOF
    owner = 1000
    group = 1000
    mode = "644"
    overwrite = true
    recycle_path = "/tmp/recycle"
}

resource "linux_script" "script" {
    lifecycle_commands {
        create = "apt update && apt install -y $PACKAGE_NAME=$PACKAGE_VERSION"
        read = "apt-cache policy $PACKAGE_NAME | grep 'Installed:' | grep -v '(none)' | awk '{ print $2 }' | xargs | tr -d '\n'"
        update = "apt update && apt install -y $PACKAGE_NAME=$PACKAGE_VERSION"
        delete = "apt remove -y $PACKAGE_NAME"
    }
    environment = {
        PACKAGE_NAME = "apache2"
        PACKAGE_VERSION = "2.4.18-2ubuntu3.4"
    }
}
