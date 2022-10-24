require 'watir'
require 'webdrivers'
require 'nokogiri'
require "awesome_print"

class Amazon

    def initialize(search)
      browser = Watir::Browser.new
      browser.goto "https://www.amazon.com/s?k=#{search}"

      @parsed_page = Nokogiri::HTML(browser.html)
      browser.close
    end

    def parsed
      ap @parsed_page
    end

    def products
      articles = @parsed_page.xpath(".//div[@class='a-section a-spacing-base']")

      articles.map do |product|
        product = {
          image: product.xpath(".//img[@class='s-image']").attr("src").to_s,
          name: product.xpath(".//span[@class='a-size-base-plus a-color-base a-text-normal']/text()").to_s,
          price: product.xpath(".//span[@class='a-price']/span/text()").to_s,
          price_before_discount: product.xpath(".//span[@class='a-price a-text-price']/span[1]/text()").to_s,
          ratings: product.xpath(".//i[@class='a-icon a-icon-star-small a-star-small-4-5 aok-align-bottom']/span/text()").to_s,
          rated_products: product.xpath(".//a[@class='a-link-normal s-underline-text s-underline-link-text s-link-style']/span/text()").to_s
        }

      end.filter{ |product| product[:price] != "" }
    end
    
end