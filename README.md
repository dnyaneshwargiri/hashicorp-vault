# hashicorp-vault

A next level tutorial of Hashicorp Vault

This tutorial demonstrates the integration of Nomad with Vault for
fetching the secrets in this case database credentials and successfully
runs the node js app.

# Pre-requistes
1. Nomad version 1.8.1
2. Vault 1.18.0
3. Consul 1.19.0

## How to Run

1. Clone the repo 😉
2. Install dependenices `yarn install`
2. Run `yarn postgress:start` this spins up postgress instance over docker container
3. Run `yarn consul:start` and `yarn nomad:start` this spin up consul and nomad instances
4. Run `yarn vault:start`, `yarn vault:login`, `yarn vault:credential:add` in sequence this starts and configure vault instance
5. Launch the node js app over docker using `yarn launch` <--- this handles build to deploy all steps in single command
6. Finally deploy this node js app image in Nomad as Job `yarn nomad:job:run` 
7. App is successfully running on `localhost:3000` also check nomad logs. 
8. Congratulation 💫✨ you successfully intgrated Hashicorp Nomad and Vault for your custom node js app.
