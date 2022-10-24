require 'watir'
require 'webdrivers'
require 'nokogiri'
require "awesome_print"

class SkyGarden

    def initialize(search)
      browser = Watir::Browser.new
      browser.goto "https://sky.garden/search/#{search}/products"

      @parsed_page = Nokogiri::HTML(browser.html)
      browser.close
    end

    def parsed
      ap @parsed_page
    end

    def products
      articles = @parsed_page.xpath("//div[@class='col-lg-s-4 col-md-s-3 col-sm-s-6 center-flex no-padding ng-star-inserted']/app-product/div")
      articles

      articles.map do |product|
        product = {
          img: product.xpath(".//img[@class='card-img ng-lazyloaded']").attr("data-src"),
          name: product.xpath(".//p[@class='card-title']/text()").to_s

        }
      end
    end
    
end