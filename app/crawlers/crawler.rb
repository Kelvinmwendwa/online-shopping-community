require 'uri'
require 'openssl'
require "awesome_print"
require 'nokogiri'


class Crawler
    def initialize(search)
        url_jumia = URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fwww.jumia.co.ke%2fcatalog%2f%3fq%3d#{search}&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")
       # url_killmall=URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fwww.kilimall.co.ke%2fnew%2fcommoditysearch%3fq%3d#{search}&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")
        url_ebay=URI("https://api.webscrapingapi.com/v1?url=https%3a%2f%2fwww.ebay.com%2fsch%2fi.html%3f_from%3dR40%26_trksid%3dp2380057.m570.l1313%26_nkw%3d#{search}&api_key=6eV6gM5df91vMGdWk1L8kDt5boVIVCgz")


       @pages={
        jumia: self.response(url_jumia),
        # killmall: self.response(url_killmall)
        ebay: self.response(url_ebay)
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


    def products_jumia
        articles=@pages[:jumia].xpath("//div[@class='-paxs row _no-g _4cl-3cm-shs']/article/a")
        articles.map do |product|
            product={
                img: product.xpath(".//img[@class='img']").attr("data-src").to_s,
                name: product.xpath(".//div[@class='info']/h3/text()").to_s,
                price: product.xpath(".//div[@class='prc']/text()").to_s,
                price_before_discount: product.xpath(".//div[@class='old']/text()").to_s,
                discount: product.xpath(".//div[@class='bdg _dsct _sm']/text()").to_s,
                ratings: product.xpath(".//div[@class='stars _s']/text()").to_s
            }  
          end.filter{|product| product[:name] !=""}
    end
    def products_killmall
        cards=@pages[:killmall].xpath("//div[@class='el-row']/div/div")
        byebug
        cards.map do |card|
            price=card.xpath(".//div[@class='wordwrap-price']")
                {
                   img:card.xpath(".//div[@class='imgClass']/img").attr("src").to_s,
                   name:card.xpath(".//div[@class='wordwrap']/div/text()").to_s,
                   price:price.xpath("./span[1]/text()").to_s,
                   price_before_discount:price.xpath(".//span[@class='twoksh']/text()").to_s,
                   discount:card.xpath(".//span[@class='greenbox']/text()").to_s,
                   ratings:card.xpath(".//div[@class='el-rate rateList']").attr("aria-valuenow").to_s,
                   rated_products: card.xpath(".//span[@class='sixtwo']/text()").to_s
                }
            end.filter{|product| product[:name]!=""}
    end


    def products_ebay
        cards=@pages[:ebay].xpath("//div[@class='s-item__wrapper clearfix']")

        cards.map do |card|
            {
                img:card.xpath(".//img[@class='s-item__image-img']").attr("src").to_s,
                name:card.xpath(".//span[@role='heading']/text()").to_s,
                price:card.xpath(".//span[@class='s-item__price']/text()").to_s,
                price_before_discount: card.xpath(".//span[@class='STRIKETHROUGH']/text()").to_s,
                discount: card.xpath(".//span[@class='BOLD']/text()").to_s,
                ratings:"",
                rated_products:"",
                return_policy:card.xpath(".//span[@class='s-item__free-returns s-item__freeReturnsNoFee']/text()").to_s,
                shipping:card.xpath(".//span[@class='s-item__shipping s-item__logisticsCost']/text()").to_s,
                coupon_discount: card.xpath(".//span[@class='NEGATIVE BOLD']/text()").to_s
            }
        end
    end
end