locals {
  project_env_name = join("-", [var.project_name, var.env_name])
}