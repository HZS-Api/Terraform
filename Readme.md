# HZS Api - Terraform

Infratructure for HZS Api Project

## AWS access

- Use [AWS Vault](https://github.com/99designs/aws-vault)

## How to run it

- Go to component, you want to deploy
    ```bash
    cd component/<component-name>
    ```
- Initialize
    ```bash
    terraform init
    ```
- Apply
    ```bash
    terraform apply -var-file="config.var.tfvars"
    ```
