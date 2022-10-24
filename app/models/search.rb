class Search < ApplicationRecord

    
    after_create :crawl

    def crawl
        c=Crawler.new(self.search_term)
        c.products
    end
end
