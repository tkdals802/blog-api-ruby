require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module BlogApi
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "http://localhost:5173" # for vue localhostと通信
        resource "*",
                 headers: :any,
                 methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
                 credentials: true
      end
    end
  end
end
