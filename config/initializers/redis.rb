uri = URI.parse("redis://redistogo:03d5b7f0973a86269bc16207879404a0@tarpon.redistogo.com:10927/")
REDIS = Redis.new(:url => uri)