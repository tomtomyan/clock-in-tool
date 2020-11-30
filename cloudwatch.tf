resource "aws_cloudwatch_event_rule" "clock_in" {
  name                = "Clock_In"
  description         = "Clocks in at 9:00 on weekdays"
  is_enabled          = false
  schedule_expression = "cron(0 13 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_rule" "clock_out" {
  name                = "Clock_Out"
  description         = "Clocks out at 5:30 on weekdays"
  is_enabled          = false
  schedule_expression = "cron(30 21 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "clock_in" {
  rule = aws_cloudwatch_event_rule.clock_in.name
  arn  = aws_lambda_function.clock_in.arn
}

