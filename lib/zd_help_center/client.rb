module ZDHelpCenter
  # API client to talk to ZD Help Center, exposes only needed functionality
  class Client
    PER_PAGE = 10
    API_URL = 'https://support.zendesk.com/api/v2/help_center/en-us/articles'.freeze

    def self.request_faqs_by_page(page)
      Rails.cache.fetch(['zd_faqs', page], expires_in: 3.minutes) do
        response = HTTParty.get("#{API_URL}?per_page=#{PER_PAGE}&page=#{page}")
        raise ZDHelpCenter::APIError, 'Not Found' if response.code != 200

        JSON.parse(response.body)
      end
    end
  end
end
