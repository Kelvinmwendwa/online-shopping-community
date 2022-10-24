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
          img: product.xpath(".//div[@class='card-img-container']/img").attr("src").to_s,
          name: product.xpath(".//p[@class='card-title']/text()").to_s,
          price: product.xpath(".//span[@class='price-normal ng-star-inserted']/text()").to_s,
          price_before_discount: product.xpath(".//span[@class='price-original d-none d-sm-inline-block ng-star-inserted']/text()").to_s,
          price_discounted: product.xpath(".//span[@class='price-discounted d-none d-sm-inline-block']/text()").to_s
          # discount: "",
          # ratings: "",
          # rated_products: ""
        }
      end
    end
end