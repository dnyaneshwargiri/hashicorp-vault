vault {
  enabled = true
  address = "$VAULT_ADDR"
  task_token_ttl = "1h"
  create_from_role = "nomad-cluster"
  token = "$VAULT_TOKEN"
}
