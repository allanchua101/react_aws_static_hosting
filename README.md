# React AWS Static Site Hosting

![Static Site Hosting on AWS](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/architecture-diagram-v4.jpg)

Demo repository for hosting static React websites using AWS, CloudFront, WAF &amp; Lambda @ Edge

### Design Advantages

- Static asset caching
- SSL and HTTPS support
- Less operational effort required for managing and operating static site infrastructure.
- Free public SSL certificate from ACM (If you registered your domain from Route 53)
- Higher tolerance against surge of request thanks to CloudFront
- Repeatable and reliable provisioning process thanks to Terraform
- Optional IP whitelisting demo for back office related portals
- Tolerance against single region failures
- Security headers are attached using Lambda @ Edge
