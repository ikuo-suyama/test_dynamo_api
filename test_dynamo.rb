#!/usr/bin/ruby

#require 'aws-sdk-core'
require 'bundler'
Bundler.require

ddb = Aws::DynamoDB::Client.new(
	# N. Versinia
    endpoint: 'https://dynamodb.us-east-1.amazonaws.com', 
    region: 'us-east-1'
)

# list databases
#result = ddb.list_tables
#result.table_names.each do |table|
#	puts table
#end

response = ddb.batch_write_item({
  request_items: { # required
    "SimpleDB" => [
      {
        put_request: {
          item: {
            "sample_id" => 1,
            "name" => "Suyamai"
          }
        },
      },
      {
        put_request: {
          item: {
            "sample_id" => 2,
            "name" => "Hata"
          }
        },
      },
      # これがあるとエラー
      # {
      #   put_request: {
      #     item: {
      #       "sample_id" => 2,
      #       "name" => "Hata"
      #     }
      #   },
      # },
    ],
  },
  return_consumed_capacity: "INDEXES", # accepts INDEXES, TOTAL, NONE
  return_item_collection_metrics: "SIZE", # accepts SIZE, NONE
})

puts response.inspect

# エラー内容
#/Users/a14059/src/test_dynamo_api/vender/bundle/ruby/2.2.0/gems/aws-sdk-core-2.1.7/lib/seahorse/client/plugins/raise_response_errors.rb:15:in `call': Provided list of item keys contains duplicates (Aws::DynamoDB::Errors::ValidationException)
#	from /Users/a14059/src/test_dynamo_api/vender/bundle/ruby/2.2.0/gems/aws-sdk-core-2.1.7/lib/aws-sdk-core/plugins/dynamodb_simple_attributes.rb:112:in `call'
#	from /Users/a14059/src/test_dynamo_api/vender/bundle/ruby/2.2.0/gems/aws-sdk-core-2.1.7/lib/aws-sdk-core/plugins/param_converter.rb:21:in `call'
#	from /Users/a14059/src/test_dynamo_api/vender/bundle/ruby/2.2.0/gems/aws-sdk-core-2.1.7/lib/seahorse/client/plugins/response_target.rb:21:in `call'
#	from /Users/a14059/src/test_dynamo_api/vender/bundle/ruby/2.2.0/gems/aws-sdk-core-2.1.7/lib/seahorse/client/request.rb:70:in `send_request'
#	from /Users/a14059/src/test_dynamo_api/vender/bundle/ruby/2.2.0/gems/aws-sdk-core-2.1.7/lib/seahorse/client/base.rb:207:in `block (2 levels) in define_operation_methods'
#	from test_dynamo.rb:19:in `<main>'
