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
      articles = @parsed_page.xpath("//div[@class='listings-cards']/div")

      articles.map do |product|
        product = {
          # img: product.xpath(".//div[@class='listing-card_image_inner']/img")
          # name: product.xpath(".//div[@class='listing-card_header-content']/div")
        }
      end
    end
    
end