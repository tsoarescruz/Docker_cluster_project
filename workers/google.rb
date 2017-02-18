require 'json'
require 'unirest'
require 'nokogiri'

class GoogleWorker
  EXCLUDE_DOMAINS = ['globosatplay.globo.com', 'premierefc.globo.com', 'adobe.com', 'sky.com.br', 'skyonline.com.br', 'baixaki.com.br',
                     'adobe-premiere-pro-.softonic.com.br', 'netcombo.com.br', 'clarotv.claro.com.br', 'assine.vivo.com.br', 'pt.wikipedia.org',
                     'sportv.globo.com', 'itunes.apple.com', 'premiereempregos.com.br', 'oi.com.br', 'mxcursos.com', 'premierefitness.com.br',
                     'adobe-premiere.en.softonic.com', 'play.google.com', 'mundogloob.globo.com', 'globoplay.globo.com', 'globo.com'].join(' -site:')

  def self.run query
    query_results = []

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

    puts "Requesting: #{final_query}\nhttps://www.google.com.br/search?\n"
    response = Unirest.get('https://www.google.com.br/search?', headers: {}, parameters: params)

    better_body = response.body.gsub('/*""*/', ',').gsub('\\\\', '')
    parsed_response = "[#{better_body}]".gsub(',]', ']')

    json_data = JSON.parse(parsed_response.force_encoding("ISO-8859-1").encode("UTF-8"))

    json_data.each do |data|
      html_page = Nokogiri::HTML(data['d'])
      results = html_page.css('.r')
      results.each do |result|
        query_results << {title: result.css('a').text, link: result.css('a').attr('href').value.gsub('/url?q=', '')}
      end
    end

    return query_results
  end
end