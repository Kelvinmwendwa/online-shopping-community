require 'watir'
require 'webdrivers'
require 'nokogiri'
require "awesome_print"

class PigiaMe

    def initialize(search)
      browser = Watir::Browser.new
      browser.goto "https://www.pigiame.co.ke/classifieds?q=#{search}"

      @parsed_page = Nokogiri::HTML(browser.html)
      browser.close
    end

    def parsed
      ap @parsed_page
    end

    def products
      articles = @parsed_page.xpath(".//div[@class='listing-card listing-card--tab listing-card--has-contact listing-card--has-content']/a")

      articles.map do |product|
        product = {
          img: product.xpath(".//img[@class='listing-card__image__resource vh-img']").attr("src").to_s,
          name: product.xpath(".//div[@class='listing-card__header__title']/text()").to_s,
          price: product.xpath(".//span[@class='listing-card__price']/span/text()").to_s,
          
        }

      end
    end
    
end