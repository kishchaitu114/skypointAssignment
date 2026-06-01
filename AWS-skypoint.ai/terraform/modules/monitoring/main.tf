resource "aws_cloudwatch_metric_alarm" "placeholder" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Placeholder alarm — wire to Container Insights or Prometheus"
  treat_missing_data  = "notBreaching"
}
