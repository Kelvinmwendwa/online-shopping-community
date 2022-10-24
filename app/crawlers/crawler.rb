require 'uri'
require 'openssl'
require "awesome_print"
require 'nokogiri'


class Crawler
    def initialize(search)
        url_jumia = URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fwww.jumia.co.ke%2fcatalog%2f%3fq%3d#{search}&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")
        url_killmall=URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fwww.kilimall.co.ke%2fnew%2fcommoditysearch%3fq%3d#{search}&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")
        url_ebay=URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fwww.ebay.com%2fsch%2fi.html%3f_from%3dR40%26_trksid%3dp2380057.m570.l1313%26_nkw%3d#{search}&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")
        url_sky=URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fsky.garden%2fsearch%2f#{search}%2fproducts&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")


       @pages={
        jumia: self.response(url_jumia),
        killmall: self.response(url_killmall),
        ebay: self.response(url_ebay),
        sky_garden: response(url_sky)
       }
    end

     def response(url)
        http=Net::HTTP.new(url.host,url.port)
        http.use_ssl=true
        http.verify_mode=OpenSSL::SSL::VERIFY_NONE

        request=Net::HTTP::Get.new(url)

        self.data(http.request(request))
     end

    def data(res)
        browser_html=res.read_body
        parsed_page=Nokogiri::HTML(browser_html)  
    end

    def parsed_pages
        @pages
    end


    def jumia
        articles=@pages[:jumia].xpath("//div[@class='-paxs row _no-g _4cl-3cm-shs']/article/a")
        raw=articles.map do |product|
            product={
                image_url: product.xpath(".//img[@class='img']").attr("data-src").to_s,
                name: product.xpath(".//div[@class='info']/h3/text()").to_s,
                price: product.xpath(".//div[@class='prc']/text()").to_s,
                price_before_discount: product.xpath(".//div[@class='old']/text()").to_s,
                discount: product.xpath(".//div[@class='bdg _dsct _sm']/text()").to_s,
                ratings: product.xpath(".//div[@class='stars _s']/text()").to_s
            }  
          end.slice(0,6)
          self.create_products(raw)
    end
    def killmall
        cards=@pages[:killmall].xpath("//div[@class='el-row']/div/div")
        byebug
        cards.map do |card|
            price=card.xpath(".//div[@class='wordwrap-price']")
                {
                   image_url:card.xpath(".//div[@class='imgClass']/img").attr("src").to_s,
                   name:card.xpath(".//div[@class='wordwrap']/div/text()").to_s,
                   price:price.xpath("./span[1]/text()").to_s,
                   price_before_discount:price.xpath(".//span[@class='twoksh']/text()").to_s,
                   discount:card.xpath(".//span[@class='greenbox']/text()").to_s,
                   ratings:card.xpath(".//div[@class='el-rate rateList']").attr("aria-valuenow").to_s,
                   rated_products: card.xpath(".//span[@class='sixtwo']/text()").to_s
                }
            end.slice(6)
    end


    def ebay
        cards=@pages[:ebay].xpath("//div[@class='s-item__wrapper clearfix']")

        raw=cards.map do |card|
            {
                image_url:card.xpath(".//img[@class='s-item__image-img']").attr("src").to_s,
                name:card.xpath(".//span[@role='heading']/text()").to_s,
                price:card.xpath(".//span[@class='s-item__price']/text()").to_s,
                price_before_discount: card.xpath(".//span[@class='STRIKETHROUGH']/text()").to_s,
                discount: card.xpath(".//span[@class='BOLD']/text()").to_s,
                ratings:"",
                rated_products:"",
                return_policy:card.xpath(".//span[@class='s-item__free-returns s-item__freeReturnsNoFee']/text()").to_s,
                shipping:card.xpath(".//span[@class='s-item__shipping s-item__logisticsCost']/text()").to_s,
                coupon_discount: card.xpath(".//span[@class='NEGATIVE BOLD']/text()").to_s
            }.slice(0,6)

            self.create_products(raw)
        end
    end
    def sky_garden
        articles = @pages[sky_garden].xpath("//div[@class='col-lg-s-4 col-md-s-3 col-sm-s-6 center-flex no-padding ng-star-inserted']/app-product/div")
  
       raw= articles.map do |product|
          product = {
            image_url: product.xpath(".//div[@class='card-img-container']/img").attr("src").to_s,
            name: product.xpath(".//p[@class='card-title']/text()").to_s,
            price: product.xpath(".//span[@class='price-normal ng-star-inserted']/text()").to_s,
            price_before_discount: product.xpath(".//span[@class='price-original d-none d-sm-inline-block ng-star-inserted']/text()").to_s,
            price_discounted: product.xpath(".//span[@class='price-discounted d-none d-sm-inline-block']/text()").to_s,
            shop:"sky garden"
          }.slice(0,6)
        end

        self.create_products(raw)
      end

    def create_products(raw_products)
        raw_products.map{|p| Product.create(p)}
    end

    def all_products
        [*self.jumia,*self.ebay]
    end
end