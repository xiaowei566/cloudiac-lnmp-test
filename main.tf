
 terraform {
    required_providers {
      alicloud = {
        source = "aliyun/alicloud"
        version = "1.99.0"
      }
          linux = {
        source = "TelkomIndonesia/linux"
        version = "0.2.3"
      }
        nginx = {
        source = "getstackhead/nginx"
        version = "1.3.2"
      }
        mysql = {
        source = "ZobairQ/mysql"
        version = "1.11.1"
      }
    }
  }
      
