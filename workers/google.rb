require 'json'
require 'nokogiri'
require 'rest-client'

class GoogleWorker
  EXCLUDE_DOMAINS = ['globosatplay.globo.com', 'premierefc.globo.com', 'adobe.com', 'sky.com.br', 'skyonline.com.br', 'baixaki.com.br',
                     'adobe-premiere-pro-.softonic.com.br', 'netcombo.com.br', 'clarotv.claro.com.br', 'assine.vivo.com.br', 'pt.wikipedia.org',
                     'sportv.globo.com', 'itunes.apple.com', 'premiereempregos.com.br', 'oi.com.br', 'mxcursos.com', 'premierefitness.com.br',
                     'adobe-premiere.en.softonic.com', 'play.google.com', 'mundogloob.globo.com', 'globoplay.globo.com', 'globo.com',
                     'tecnoblog.net', 'vivo.com.br', 'bol.uol.com.br', 'saraiva.com.br', 'enjoei.com.br'].join(' -site:')

  def self.search query
    response = request_search query
    json_data = parse_response_to_json response.body
    query_results = process_data json_data
    final_result = evaluate_results query_results

    return final_result
  end

  def self.request_search query
    final_query = "#{query} -site:#{EXCLUDE_DOMAINS}"
    params = {sclient: 'psy-ab',
              safe: 'off',
              num: 100,
              hl: 'pt',
              biw: '1080',
              bih: '1920',
              site: 'webhp',
              q: final_query,
              pbx: '1',
              bav: 'on.2,or.r_cp.',
              bvm: 'bv.147448319,d.Y2I',
              fp: '5047cddfc513b732',
              pf: 'p',
              gs_rn: '64',
              gs_ri: 'psy-ab',
              tok: 'GwqlFYN3FRY7BvbTjY60SQ',
              pq: final_query,
              cp: '9',
              gs_id: '2v',
              xhr: 't',
              tch: '1',
              ech: '2',
              psi: 'uOmmWNrAM4GWwATp1IWgBg.1487333817326.3'}

    response = RestClient.get('https://www.google.com.br/search?', {params: params})

    return response
  end

  def self.parse_response_to_json body
    better_body = body.gsub('/*""*/', ',').gsub('\\\\', '')
    parsed_response = "[#{better_body}]".gsub(',]', ']')

    json_data = JSON.parse(parsed_response.force_encoding("ISO-8859-1").encode("UTF-8"))

    return json_data
  end

  def self.process_data json_data
    query_results = []

    json_data.each do |data|
      html_page = Nokogiri::HTML(data['d'])
      results = html_page.css('.r')
      results.each do |result|
        url_link = URI.unescape(result.css('a').attr('href').value.gsub('/url?q=', ''))
        query_results << {title: result.css('a').text, link: url_link, status: nil}
      end
    end

    return query_results
  end

  def self.evaluate_results query_results
    threads = []

    query_results.each do |result|
      threads << Thread.new {
        begin
          response = RestClient.get(result[:link])
          if response.code.between?(200, 204)
            screenshot_slug = result[:title].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
            screenshot = IMGKit.new(response.body, quality: 50)
            screenshot.to_file("#{Dir.pwd}/public/#{screenshot_slug}.jpg")

            result[:status] = response.code
          end
        rescue Exception => e
        end
      }
    end 

    threads.each {|t| t.join}

    return query_results.delete_if{|query| query[:status].nil?}
  end
end
