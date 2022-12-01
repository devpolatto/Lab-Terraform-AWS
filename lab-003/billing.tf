resource "aws_ce_cost_allocation_tag" "lab_id_key" {
  tag_key = "LAB_ID"
  status  = "Active"
}

resource "aws_ce_cost_allocation_tag" "env_key" {
  tag_key = "ENV"
  status  = "Active"
}

resource "aws_ce_cost_category" "this" {
  name         = "Lab Environment ${lookup(var.common_tags, "LAB_ID", null)}"
  rule_version = "CostCategoryExpression.v1"
  rule {
    value = "lab"
    rule {
      dimension {
        key           = "LAB_ID"
        values        = ["${lookup(var.common_tags, "LAB_ID", null)}"]
        match_options = ["EQUALS"]
      }
    }
  }
}

# Verificar como inserir a TAG no key da rule