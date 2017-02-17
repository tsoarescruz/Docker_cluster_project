#!/usr/bin/env ruby
require 'json'
require 'unirest'
require 'nokogiri'

URLs = ['https://www.google.com.br/search?']
QUERY = ['premiere']

query_results = []

URLs.each do |url|
  QUERY.each do |query|
    params = {sclient: 'psy-ab',
              safe: 'off',
              hl: 'pt',
              biw: '1440',
              bih: '450',
              site: 'webhp',
              q: 'premiere',
              pbx: '1',
              bav: 'on.2,or.r_cp.',
              bvm: 'bv.147448319,d.Y2I',
              fp: '5047cddfc513b732',
              pf: 'p',
              gs_rn: '64',
              gs_ri: 'psy-ab',
              tok: 'GwqlFYN3FRY7BvbTjY60SQ',
              pq: query,
              cp: '9',
              gs_id: '2v',
              xhr: 't',
              tch: '1',
              ech: '2',
              psi: 'uOmmWNrAM4GWwATp1IWgBg.1487333817326.3'}

    response = Unirest.get(url, headers: {}, parameters: params)

    better_body = response.body.gsub('/*""*/', ',').gsub('\\\\', '')
    parsed_response = "[#{better_body}]".gsub(',]', ']')

    json_data = JSON.parse(parsed_response)

    json_data.each do |data|
      html_page = Nokogiri::HTML(data['d'])
      results = html_page.css('.r')
      results.each do |result|
        query_results << {title: result.css('a').text, link: result.css('a').attr('href').value.gsub('/url?q=', '')}
      end
    end
  end
end

puts query_results
