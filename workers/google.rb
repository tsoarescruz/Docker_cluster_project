require 'json'
require 'nokogiri'
require 'rest-client'

class GoogleWorker
  EXCLUDE_DOMAINS = ['globo.com', 'adobe.com', 'google.com.br', 'google.com', 'sky.com.br', 'skyonline.com.br', 'nowonline.com.br',
                     'netcombo.com.br', 'claro.com.br', 'assineskyagora.com.br', 'apple.com', 'premiereempregos.com.br', 'oi.com.br',
                     'mxcursos.com', 'premierefitness.com.br', 'microsoft.com', 'baixaki.com.br', 'vivo.com.br', 'vivoplay.com.br',
                     'telecineon.com.br',

                     'softonic.com.br', 'softonic.com', 'cnet.com', 'tecnoblog.net', 'uol.com.br', 'saraiva.com.br', 'enjoei.com.br',
                     'techtudo.com.br', 'reclameaqui.com.br', 'eonline.com', 'biblegateway.com', 'bible.com', 'estadao.com.br',
                     'spotify.com', 'archive.org', 'vagalume.com.br', 'ebay.com', 'proteste.org.br', 'adorocinema.com', 'wikipedia.org',
                     'busindia.com', 'aptoide.com', 'oiplay.tv', 'meiobit.com', 'huffpostbrasil.com', 'vejario.abril.com.br',
                     'correio24horas.com.br', 'tecmundo.com.br']
  GOOGLE_EXCLUDE_DOMAINS = EXCLUDE_DOMAINS.first(20)

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

    begin
      response = RestClient.get('https://www.google.com.br/search?', {params: params})
    rescue Exception => e
      response = nil
    end

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
        unless invalid_domain = EXCLUDE_DOMAINS.map{|domain| url_link.include? domain}.any?
          query_results << {title: result.css('a').text, link: url_link, status: nil, from: 'Google', screenshot: nil}
        end
      end
    end

    return query_results
  end

  def self.save_results query_results
    query_results.each do |result|
      begin
        response = RestClient::Request.execute(method: :get, url: result[:link], timeout: 15)
        result[:status] = response.code
        result[:screenshot] = self.create_image(response.body)

      rescue RestClient::NotFound => e
        result[:status] = e.response.code
        result[:screenshot] = self.create_image(e.response.body)

      rescue Exception => e
        result[:status] = 500

        puts "#{result[:link]} -> #{e}"
      end

      SearchResult.find_or_create result
      
      if result[:screenshot]
        result[:screenshot].unlink
      end
    end
  end

  def self.create_image html
    begin
      # create screenshot image
      image_kit = IMGKit.new(html, quality: 50)
      image = image_kit.to_img(:jpg)
      temp_file_name = (0...8).map { (65 + rand(26)).chr }.join.downcase
      image_file = Tempfile.new(["screenshot_#{temp_file_name}", 'jpg'], 'tmp', encoding: 'ascii-8bit')
      image_file.write(image)
      image_file.flush
    rescue Exception => e
      image_file = nil
    end

    return image_file
  end
end
