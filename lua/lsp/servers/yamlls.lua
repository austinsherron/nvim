local schemastore = require 'schemastore'

return {
  settings = {
    yaml = {
      schemaStore = {
        -- disable built-in schemaStore; we use SchemaStore.nvim instead
        enable = false,
        url = '',
      },
      schemas = schemastore.yaml.schemas(),
    },
  },
}
