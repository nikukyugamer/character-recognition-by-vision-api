require "character_recognition_by_vision_api/version"
require 'rest-client'
require 'base64'
require 'json'

module CharacterRecognitionByVisionApi
  extend self

  def extract_to_text(image_file, api_key)
    JSON.parse(response_json(image_file, api_key))['responses'][0]['fullTextAnnotation']['text']
  end

  def payload(image_file)
    {
      requests: [
        {
          image:
            {
              content: Base64.encode64(open(image_file).read)
            },
          features: [
            {
              type: "TEXT_DETECTION",
              maxResults: 10,
            }
          ]
        }
      ]
    }
  end

  def headers_for_post
    {
      'Content-Type': 'application/json',
    }
  end

  def request_uri(api_key)
    "https://vision.googleapis.com/v1/images:annotate?key=#{api_key}"
  end

  def response_json(image_file, api_key)
    begin
      RestClient.post(
        request_uri(api_key),
        payload(image_file).to_json,
        headers_for_post,
      )
    rescue => e
      puts e
      exit(1)
    end
  end
end
