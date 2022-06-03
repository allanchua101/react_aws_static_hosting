# React AWS Static Site Hosting

Demo repository for hosting a React web app using Terraform, AWS, CloudFront, WAF &amp; Lambda @ Edge

![Static Site Hosting on AWS](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/architecture-diagram-v4.jpg)

<p align="center">
  View a larger version of the architecture diagram @ <a href="https://imgur.com/RDssWFm">imgur</a>.
</p>

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

### Local Build and Deploy Process

![Build Process](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/build_process.png)

The diagram above depicts the process involved in running semi-automated deployments from a developer's machine. This process could be broken into four various parts:

1. Build React WebApp -> This stage is used for compiling the React web application so that we could produce static assets that could be deployed to our AWS-based static website hosting infrastructure.
2. Upload to main S3 -> This stage is used for deploying (Uploading) the build artifacts produced on stage 1 into the our main S3 bucket.
3. Upload to failover S3 -> This stage is used for deploying (Uploading) the build artifacts produced on stage 1 into our failover S3 bucket.
4. Flush Cached files inside CloudFront edge servers -> This stage is used for flushing the cached files inside CloudFront servers which ensures elimination of static assets from old builds.

You could build the React web app and deploy it to the main and failover S3 bucket by running the following command:

```sh
AWS_PROFILE="foo-profile" \
  ENV_NAME="dev" \
  PROJECT_NAME="movie-search" \
  MAIN_DISTRIBUTION_ID="YOUR_CF_DISTRIBUTION_ID_HERE" \
  ./003_build.sh
```
