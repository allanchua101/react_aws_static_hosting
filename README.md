# React AWS Static Site Hosting

Demo repository for provisioning static site infrastructure and deploying React web apps using Terraform, AWS, CloudFront, WAF &amp; [CloudFront Response Header Policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/creating-response-headers-policies.html).

![Static Site Hosting on AWS](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/diagram-v6.png)

<p align="center">
  View a larger version of the architecture diagram @ <a href="https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/diagram-v6.png">assets folder</a>.
</p>

### Design Advantages

- Static asset caching
- SSL and HTTPS support
- Less effort required in managing and operating static site infrastructure.
- Lower cost of static asset distribution compared to VM and container-based architectures.
- Free public SSL certificate from AWS certificate manager.
- Higher tolerance against surge of requests. (Thanks to CloudFront traffic distribution across POPs)
- Repeatable, reliable and scalable provisioning process thanks to Terraform and environment-specific variable files.
- Optional static IP whitelisting for back office-related portals (WAF, Web ACLs and IP sets)
- Tolerance against single region failures. (Thanks to CloudFront origin groups)
- Security headers are applied on CloudFront responses using [CloudFront response header policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/creating-response-headers-policies.html), this is previously done using lambda@edge which requires intermediate request processing and extra fees. CloudFront does that for us with no additional processing fees. 
- Prevent caching of `index.html` files which often results to referencing of obsolete js and css assets for React and Vue apps.

### Demo Application

![Home Page](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/website-home.png)

Our demo application is a React web app designed for providing a means of searching movies so that you don't get subjected to Advertisements and various IP trackers.

### Setup `.env` configuration

In order to build the sample app, you will have to create environment variable file(s) for your desired environment(s) by copying the `.env.sample` file to either `.env`, `.env.local`, `.env.development`, `.env.production`. This process will require the creation of an API key from [The Movie Database API portal](https://www.themoviedb.org/signup).  

### Local Build and Deploy Process

![Build Process](https://github.com/allanchua101/react_aws_static_hosting/blob/main/assets/build_process.png)

The diagram above depicts the process involved in running semi-automated deployments from a developer's machine. This process could be broken into four various parts:

1. Build React WebApp -> This stage is used for compiling the React web application so that we could produce static assets that could be deployed to our AWS-based static website hosting infrastructure.
2. Upload to main S3 -> This stage is used for deploying (Uploading) the build artifacts produced on stage 1 into the our main S3 bucket.
3. Upload to failover S3 -> This stage is used for deploying (Uploading) the build artifacts produced on stage 1 into our failover S3 bucket.
4. Flush Cached files inside CloudFront edge servers -> This stage is used for flushing the cached files inside CloudFront servers which ensures elimination of static assets from old builds.

You could build the React web app and deploy it to the main and failover S3 bucket by running the following command:

```sh
cd ./scripts

AWS_PROFILE="foo-profile" \
  ENV_NAME="dev" \
  PROJECT_NAME="movie-search" \
  MAIN_DISTRIBUTION_ID="YOUR_CF_DISTRIBUTION_ID_HERE" \
  ./003_build.sh
```

## Future Improvements

- We could add version injection step in the build process
- We could add a WAF-less template to accomodate those who have public exposure needs.
- Serverless WAF honeypot samples
- SAST and DAST steps for CI/CD demos
- Run Jest-based Component Tests
- Storage of build artifacts in an S3 bucket.
- Make Terraform provider profiles dynamic
- Create a compilation-demo for Vite consumers

## FAQs

- How to disable WAF on this template? -> WAF could easily be disabled by removing the files associated to WAF (`waf_ipset.tf`, `waf_rule_group.tf`, `waf_web_acl.tf`) and removing line #8 on `cloudfront.tf` file that associates the WAF with the projects CloudFront distribution.
