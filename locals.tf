locals {
  topic_type = format("%s.%s", element(split("/", var.source_resource_id), 6), element(split("/", var.source_resource_id), 7))
}
