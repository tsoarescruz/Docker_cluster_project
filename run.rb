#!/usr/bin/env ruby
require 'json'
require 'unirest'

URLs = ['https://www.google.com.br/search?']

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
          pq: 'premiere',
          cp: '9',
          gs_id: '2v',
          xhr: 't',
          tch: '1',
          ech: '2',
          psi: 'uOmmWNrAM4GWwATp1IWgBg.1487333817326.3'}

URLs.each do |url|
  response = Unirest.get(url, headers: {}, parameters: params)

  better_body = response.body.gsub('/*""*/', ',').gsub('\\\\', '')
  parsed_response = "[#{better_body}]".gsub(',]', ']')

  json = JSON.parse(parsed_response)

  json.each do |result|
    puts result['d']
  end
end






