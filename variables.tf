variable "cost_budgets" {
  description = <<EOT
Map of cost_budgets, attributes below
Required:
    - end_month
    - metrics_query
    - name
    - start_month
Optional:
    - budget_line (block):
        - amounts (required)
        - child_tag_filters (optional, block):
            - tag_key (required)
            - tag_value (required)
        - parent_tag_filters (optional, block):
            - tag_key (required)
            - tag_value (required)
        - tag_filters (optional, block):
            - tag_key (required)
            - tag_value (required)
    - entries (block):
        - amount (required)
        - month (required)
        - tag_filters (optional, block):
            - tag_key (required)
            - tag_value (required)
EOT

  type = map(object({
    end_month     = number
    metrics_query = string
    name          = string
    start_month   = number
    budget_line = optional(list(object({
      amounts = map(number)
      child_tag_filters = optional(list(object({
        tag_key   = string
        tag_value = string
      })))
      parent_tag_filters = optional(list(object({
        tag_key   = string
        tag_value = string
      })))
      tag_filters = optional(list(object({
        tag_key   = string
        tag_value = string
      })))
    })))
    entries = optional(list(object({
      amount = number
      month  = number
      tag_filters = optional(list(object({
        tag_key   = string
        tag_value = string
      })))
    })))
  }))
}

