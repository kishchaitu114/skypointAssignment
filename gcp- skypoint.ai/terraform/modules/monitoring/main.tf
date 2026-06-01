resource "google_logging_metric" "error_count" {
  name   = replace(var.sink_name, "-", "_")
  filter = "severity>=ERROR"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
