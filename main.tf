resource "datadog_cost_budget" "cost_budgets" {
  for_each = var.cost_budgets

  end_month     = each.value.end_month
  metrics_query = each.value.metrics_query
  name          = each.value.name
  start_month   = each.value.start_month

  dynamic "budget_line" {
    for_each = each.value.budget_line != null ? each.value.budget_line : []
    content {
      amounts = budget_line.value.amounts
      dynamic "child_tag_filters" {
        for_each = budget_line.value.child_tag_filters != null ? budget_line.value.child_tag_filters : []
        content {
          tag_key   = child_tag_filters.value.tag_key
          tag_value = child_tag_filters.value.tag_value
        }
      }
      dynamic "parent_tag_filters" {
        for_each = budget_line.value.parent_tag_filters != null ? budget_line.value.parent_tag_filters : []
        content {
          tag_key   = parent_tag_filters.value.tag_key
          tag_value = parent_tag_filters.value.tag_value
        }
      }
      dynamic "tag_filters" {
        for_each = budget_line.value.tag_filters != null ? budget_line.value.tag_filters : []
        content {
          tag_key   = tag_filters.value.tag_key
          tag_value = tag_filters.value.tag_value
        }
      }
    }
  }

  dynamic "entries" {
    for_each = each.value.entries != null ? each.value.entries : []
    content {
      amount = entries.value.amount
      month  = entries.value.month
      dynamic "tag_filters" {
        for_each = entries.value.tag_filters != null ? entries.value.tag_filters : []
        content {
          tag_key   = tag_filters.value.tag_key
          tag_value = tag_filters.value.tag_value
        }
      }
    }
  }
}

