require 'json'
require 'nokogiri'
require 'rest-client'

class GoogleWorker
  GOOGLE_EXCLUDE_DOMAINS = ['']
  SEARCH_SIZE = 80

  def self.search query
    response = request_search query
    unless response.nil?
      json_data = parse_response_to_json response.body
      query_results = process_data json_data
      final_result = save_results query_results
    end
  end

  def self.request_search query
    final_query = "#{query} -site:#{GOOGLE_EXCLUDE_DOMAINS.join(' -site:')}"
    params = {
          'authority': 'www.google.com.br', ':method': 'GET', 'upgrade-insecure-requests': 1, q: final_query,
          sclient: 'psy-ab', safe: 'off', hl: 'pt', biw: '1080', bih: '1920', site: 'webhp', num: SEARCH_SIZE,
          pq: final_query, cp: '9', gs_id: '2v', xhr: 't', tch: '1', ech: '2', psi: 'uOmmWNrAM4GWwATp1IWgBg.1487333817326.3'
        }

    begin
      response = RestClient.get('https://www.google.com.br/search?', {params: params})
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error "GoogleWorker: Query #{query} - #{e}"
      response = nil
    end
    response
  end

  def parse_response_to_json(body)
    better_body = body.gsub('/*""*/', ',').gsub('\\\\', '')
    parsed_response = "[#{better_body}]".gsub(',]', ']')

    JSON.parse(parsed_response.force_encoding('ISO-8859-1').encode('UTF-8'))
  end

  def process_data(json_data)
    query_results = []
    # first item is more relavant
    relevance = 1

    json_data.each do |data|
      # get each result link
      html_page = Nokogiri::HTML(data['d'])
      results = html_page.css('.g')

      results.each do |result|
        # get the base URL link
        links = result.css('a')
        next if links.empty?
        url_link = sanitize_link(links.attr('href').value)
        # filter invalid domains
        # next if link_in_white_list?(url_link)
        # next if link_from_another_platform?(url_link)
        query_results << return_issue_data(result, relevance, url_link)
        relevance += 1
      end
    end

    query_results
  end

  def sanitize_link(link)
      link.gsub('/url?q=', '').gsub('/interstitial?url=', '').gsub(/&sa=.*/, '')
  end

  def return_issue_data(result, relevance, url_link)
    description = result.css('.st').map(&:text).join(' - ')
    {
      title: result.css('a').text,
      link: url_link,
      platform: 'Google',
      relevance: relevance,
      complementary_data: { description: description }
    }
  end

  def self.save_results query_results
    query_results.each do |result|
      begin
        response = RestClient::Request.execute(method: :get, url: result[:link], timeout: 15)
        result[:status] = response.code

      rescue RestClient::NotFound => e
        result[:status] = e.response.code

      rescue Exception => e
        result[:status] = 500

        puts "#{result[:link]} -> #{e}"
      end

      SearchResult.find_or_create result

    end
  end
end
