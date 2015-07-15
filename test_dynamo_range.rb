#!/usr/bin/ruby

#require 'aws-sdk-core'
require 'bundler'
Bundler.require

ddb = Aws::DynamoDB::Client.new(
	# N. Versinia
    endpoint: 'https://dynamodb.us-east-1.amazonaws.com', 
    region: 'us-east-1'
)

ts1 = Time.now.to_i
ts2 = ts1 + 1

response = ddb.batch_write_item({
  request_items: { # required
    "SimpleRangeDB1" => [
      {
        put_request: {
          item: {
            "id" => "1234_aaaabbcc",
            "ts" => 1436958370,
            "some_attributes" => "some_attributes"
          }
        },
      },
      {
        put_request: {
          item: {
            "id" => "1234_aaaabbdd",
            "ts" => ts1,
            "some_attributes" => "some_attributes"
          }
        },
      },
      {
        put_request: {
          item: {
            "id" => "1234_aaaabbcc",
            "ts" => ts2,
            "some_attributes" => "some_attributes"
          }
        },
      },
      {
        put_request: {
          item: {
            "id" => "1234_aaaabbdd",
            "ts" => ts2,
            "some_attributes" => "some_attributes"
          }
        },
      },
    ],
  },
  return_consumed_capacity: "INDEXES", # accepts INDEXES, TOTAL, NONE
  return_item_collection_metrics: "SIZE", # accepts SIZE, NONE
})

puts response.inspect
