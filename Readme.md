# .github

Repository used to provide administrative capabilities to other repositories.

## Base files

- [**Pull request templates**](./PULL_REQUEST_TEMPLATE)
- [**Issue templates**](./ISSUE_TEMPLATE)
- [**Code of conduct**](./CODE_OF_CONDUCT.md)

## Utility workflows

- Identify stale repositories: [**stale_repo_identifier**](.github/workflows/stale_repo_identifier.yaml)
- Delete workflow runs: [**delete_workflow_run**](.github/workflows/delete_workflow_runs.yaml)

## Starter workflows

- Deploy a Bicep template: [**bicep_deploy**](workflow-templates/bicep_deploy.yaml)
- Destroy a Bicep deployment: [**bicep_destroy**](workflow-templates/bicep_destroy.yaml)
- Deploy a Terraform module: [**terraform_deploy**](workflow-templates/terraform_deploy.yaml)
- Delete workflow runs: [**delete_workflow_run**](workflow-templates/delete_workflow_runs.yaml)
- Identify stale repositories: [**stale_repo_identifier**](workflow-templates/stale_repo_identifier.yaml)
