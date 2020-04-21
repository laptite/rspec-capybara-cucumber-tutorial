class TwitterService

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "QjI9yjrVCr7rkrAVZd6nx9udS"
      config.consumer_secret     = "rbFaEoiLtQnSb8R8524gTO3cs69gC0rFB1hdDua8tX617Mu69l"
      config.access_token        = "109004372-vtNnJ2tW1I1GOMnCdlskoiJ6Ci6nPyLKAiEsK7TV"
      config.access_token_secret = "QdcjIBloYKTjGvI8kLHhSbUrSq4QKaShPSq9ZS9zrJQYN"
    end
  end

  def tweet(message)
    @client.update(message)
  end
end