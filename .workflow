name: rsync_deploy

on:
  push:
    branches:
      - main
  workflow_dispatch:

defaults:
  run:
    shell: bash

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: checkout repo
      uses: actions/checkout@v2

    - name: map branch secrets
      uses: noliran/branch-based-secrets@v1
      with:
        secrets: DEPLOY_REMOTE_PATH,DEPLOY_REMOTE_HOST,DEPLOY_REMOTE_PORT,DEPLOY_REMOTE_USER,DEPLOY_REMOTE_KEY,DEPLOY_PROJECT

    - name: rsync deployments
      uses: burnett01/rsync-deployments@5.2
      with:
        switches: -avzrO --no-perms
        path: .
        remote_path: ${{ secrets[env.DEPLOY_REMOTE_PATH_NAME] }}
        remote_host: ${{ secrets[env.DEPLOY_REMOTE_HOST_NAME] }}
        remote_port: ${{ secrets[env.DEPLOY_REMOTE_PORT_NAME] }}
        remote_user: ${{ secrets[env.DEPLOY_REMOTE_USER_NAME] }}
        remote_key: ${{ secrets[env.DEPLOY_REMOTE_KEY_NAME] }}
