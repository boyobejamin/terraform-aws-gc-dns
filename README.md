# terraform-aws-gc-dns

This is a sample repository to codify how an entity can update DNS entries for services created in AWS GovCloud in AWS Commercial environments.

In the `aws-app-govcloud` module we create two load balancers, internal and external to load balance our services within the VPC and from the public internet. In our AWS Commercial and GovCloud accounts we will have Route53 zones to host records for our applications. Within GovCloud (via `aws-app-govcloud`), we will create a private hosted zone and resolve all app traffic to the internal load balancers cname. From AWS Commercial (via `aws-route53-commercial`), we search (`data`) for an existing public Route53 hosted zone in our account (already purchased) and resolve all app traffic on the public internet to the public load balancer.

Note that a public load balancer cannot be used internally.

Note that Route53 in GovCloud cannot be publically exposed, it must be private to the account and more specifically a VPC.

Last thing, I'm not creating the NS delegations in this example. More details on delegation can be found here <https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/route-53-concepts.html>

## Workflow

Given a Route53 publically hosted zone exists in AWS Commercial, then Run `aws-app-govcloud` via GitLab CI/CD to provision an app, then run `aws-route53-commercial` to update the publically hosted zone

Bam, app is now available and resolvable privately and publically

## Warning

There is no s3 state management here and there is no creation of a VPC or subnets. This is just sample code.