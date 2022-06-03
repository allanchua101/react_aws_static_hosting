project_name="react-movies"
domain_name="foo.com" # Replace this with your Domain name
sub_domain="movies.foo.com" # Replace this with your Sub-Domain name
env_name="dev" # Replace this with either dev, uat, or prd

# You will have to generate a public SSL certificate 
# using AWS certificate manager.
acm_cert_arn="arn:aws:acm:region:account:certificate/certificate_ID"
ip4_whitelist=[
  "200.200.200.122/32" # Use your public IP here instead
]