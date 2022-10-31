# frozen_string_literal: true

require 'watir'
require 'webdrivers'
require 'nokogiri'

require 'awesome_print'

class KillmallScrape
  def initialize(search)
    browser = Watir::Browser.new

    browser.goto "https://www.kilimall.co.ke/new/commoditysearch?q=#{search}"

    @parsed_page = Nokogiri::HTML(browser.html)
    browser.close
  end

  def parsed
    @parsed_page
  end

  def cards
    cards = parsed.xpath("//div[@class='el-row']/div/div")
  end

  def products
    cards.map do |card|
      price = card.xpath(".//div[@class='wordwrap-price']")
      {
        img: card.xpath(".//div[@class='imgClass']/img").attr('src').to_s,
        name: card.xpath(".//div[@class='wordwrap']/div/text()").to_s,
        price: price.xpath('./span[1]/text()').to_s,
        price_before_discount: price.xpath(".//span[@class='twoksh']/text()").to_s,
        discount: card.xpath(".//span[@class='greenbox']/text()").to_s,
        ratings: card.xpath(".//div[@class='el-rate rateList']").attr('aria-valuenow').to_s,
        rated_products: card.xpath(".//span[@class='sixtwo']/text()").to_s
      }
    end.filter { |product| product[:name] != '' }
  end
end
