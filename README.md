# React AWS Static Site Hosting

Demo repository for hosting a React web app using Terraform, AWS, CloudFront, WAF &amp; Lambda @ Edge

![Static Site Hosting on AWS](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/architecture-diagram-v4.jpg)

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

### Demo Application

![Home Page](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/website-home.png)

Our demo application is a React web app designed for providing a means of searching movies so that you don't get subjected to Advertisements and various IP trackers.

### Build Deployment

You could build the React web app and deploy it to the main and failover S3 bucket by running the following command:

```sh
AWS_PROFILE="foo-profile" \
  ENV_NAME="dev" \
  PROJECT_NAME="movie-search" \
  MAIN_DISTRIBUTION_ID="YOUR_CF_DISTRIBUTION_ID_HERE" \
  ./003_build.sh
```
