resource "aws_cloudwatch_dashboard" "ec2_dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({
    widgets = [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
          "metrics": [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id],
            ["CWAgent", "mem_used_percent", "InstanceId", var.instance_id],
            ["CWAgent", "disk_used_percent", "InstanceId", var.instance_id],
            ["AWS/EC2", "NetworkIn", "InstanceId", var.instance_id],
            ["AWS/EC2", "StatusCheckFailed", "InstanceId", var.instance_id]
          ],
          "view": "timeSeries",
          "stacked": false,
          "region": "us-east-1",
          "title": "EC2 Monitoring Metrics"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggered when CPU utilization exceeds 80%."
  dimensions = {
    InstanceId = var.instance_id
  }
  actions_enabled = false
}

resource "aws_cloudwatch_metric_alarm" "memory_usage" {
  alarm_name          = "HighMemoryUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggered when memory usage exceeds 80%."
  dimensions = {
    InstanceId = var.instance_id
  }
  actions_enabled = false
}

resource "aws_cloudwatch_metric_alarm" "disk_usage" {
  alarm_name          = "HighDiskUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggered when disk usage exceeds 80%."
  dimensions = {
    InstanceId = var.instance_id
  }
  actions_enabled = false
}

resource "aws_cloudwatch_metric_alarm" "network_in" {
  alarm_name          = "HighNetworkIn"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Sum"
  threshold           = 100000000
  alarm_description   = "Triggered when network input exceeds 100 MB."
  dimensions = {
    InstanceId = var.instance_id
  }
  actions_enabled = false
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "StatusCheckFailed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Triggered when status check fails."
  dimensions = {
    InstanceId = var.instance_id
  }
  actions_enabled = false
}
