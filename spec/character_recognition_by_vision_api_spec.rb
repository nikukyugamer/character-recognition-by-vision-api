RSpec.describe CharacterRecognitionByVisionApi do
  it "has a version number" do
    expect(CharacterRecognitionByVisionApi::VERSION).not_to be nil
  end

  before do
    @image_file = 'spec/sample_image.png'
  end

  it 'the return value is correct headers' do
    expect(CharacterRecognitionByVisionApi.headers_for_post).to eq(
      {
        'Content-Type': 'application/json',
      }
    )
  end

  it 'the return value is correct uri' do
    expect(CharacterRecognitionByVisionApi.request_uri('abcdefghijklmnopqrstuvwxyz')).to eq("https://vision.googleapis.com/v1/images:annotate?key=abcdefghijklmnopqrstuvwxyz")
  end

  it 'the return value is correct json for post' do
    expect(CharacterRecognitionByVisionApi.payload(@image_file)).to eq(
      {
        requests: [
          {
            image:
              {
                content: Base64.encode64(open(@image_file).read)
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
    )
  end

  # oops... 'extract_to_text' and 'response_json' method are NOT tested...
end
