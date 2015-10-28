Delayed::Worker.configure do |config|
  # optional params:
 # config.aws_config = '~/stuff/things/aws.yml' # Specify the file location of the AWS configuration YAML if you're not using Rails and you want to use a YAML file instead of calling AWS.config
  config.default_queue_name = 'Smart_Tools' # Specify an alternative default queue name
  #config.delay_seconds = # Sets the default delay in seconds for messages sent to the queue.
  #config.message_retention_period = 345600 # The number of seconds Amazon SQS retains a message. Must be an integer from 3600 (1 hour) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
  #config.visibility_timeout = 30 # The length of time (in seconds) that a message received from a queue will be invisible to other receiving components when they ask to receive messages. Valid values: integers from 0 to 43200 (12 hours).
  #config.wait_time_seconds = # How many seconds to wait for a response
end
