require 'watir'
require 'webdrivers'
require 'nokogiri'
require "awesome_print"

class JumiaScrape

    def initialize(search)
        browser=Watir::Browser.new
        browser.goto "https://www.jumia.co.ke/catalog/?q=#{search}"
        
        @parsed_page=Nokogiri::HTML(browser.html)
        browser.close
    end

    def parsed
        ap @parsed_page
    end

    def products
        articles=@parsed_page.xpath("//div[@class='-paxs row _no-g _4cl-3cm-shs']/article/a")

        articles.map do |product|
            product={
                img: product.xpath(".//img[@class='img']").attr("data-src").to_s,
                name: product.xpath(".//div[@class='info']/h3/text()").to_s,
                price: product.xpath(".//div[@class='prc']/text()").to_s,
                price_before_discount: product.xpath(".//div[@class='old']/text()").to_s,
                discount: product.xpath(".//div[@class='bdg _dsct _sm']/text()").to_s,
                ratings: product.xpath(".//div[@class='stars _s']/text()").to_s,
                rated_products:""
            }  
          end.filter{|product| product[:name] !=""}
    end
end