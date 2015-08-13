uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:3000")
REDIS = Redis.new(:url => uri, port: uri.port, password: uri.password)