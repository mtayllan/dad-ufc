require 'aws-sdk-lambda'
require 'aws-sdk-s3'
require 'json'
require 'securerandom'

module GetImage
  @aws_lambda = Aws::Lambda::Client.new(
    region: 'us-east-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  )

  @aws_s3 = Aws::S3::Client.new(
    region: 'us-east-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  )

  def self.call(html)
    lambda_response = @aws_lambda.invoke({
      function_name: ENV['LAMBDA_ARN'],
      payload: { html: html }.to_json
    })

    base64_image = JSON.parse(lambda_response[:payload].string)['base64']
    filename = "#{SecureRandom.hex(16)}.png"

    object = @aws_s3.put_object({
      body: Base64.decode64(base64_image),
      bucket: ENV['S3_BUCKET'],
      key: filename
    })

    "https://#{ENV['S3_BUCKET']}.s3.amazonaws.com/#{filename}"
  end
end
