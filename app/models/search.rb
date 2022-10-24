class Search < ApplicationRecord

    
    after_create :crawl

    def crawl
        c=Crawler.new(self.search_term)
        c.all_products
    end
end
