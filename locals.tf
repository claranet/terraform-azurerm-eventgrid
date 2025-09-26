locals {
  topic_type = var.source_resource_id != null ? format("%s.%s", element(split("/", var.source_resource_id), 6), element(split("/", var.source_resource_id), 7)) : null
}
