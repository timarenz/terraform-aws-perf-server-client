# tf_aws_perf_server_client
A terraform module to deploy the Avi Networks performance server and client instance on AWS. This module in deploy one client in a specified (public) network and a specific number of servers in a specified (private) network.

Make sure to change the ami id as this is not a public image and may not be available in your region.

## Input variables

### Required
* `environment_name` - Used as prefix for all supported object names
* `public_subnet_id` - public key used for SSH access to the Avi Controller.
* `private_subnet_id` - Password for the Avi Controller admin account.

### Optional
* `instance_type` - AWS instance typ used to deploy the instances
* `server_count` - Number of server instaces that should be deployed
* `ami_id` - Id of performance server and client AMI

## Output variables

* `client_public_ip` - Public IP address of the performance client
* `server_private_ips` - Private IP address(es) of the performance servers

## Example
```hcl
module "avicontroller-aws" {
  source                = "github.com/timarenz/tf_aws_avicontroller"

  public_subnet_id      = "subnet-19915954"
  private_subnet_id     = "subnet-98765678"
  environment_name      = "tim-staging"
}
```

## Authors
Created and maintaned by [Tim Arenz](https://github.com/timarenz)

## License
[MIT](LICENSE)