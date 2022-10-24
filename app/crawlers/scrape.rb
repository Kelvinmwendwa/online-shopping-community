require "wombat"

class Scrape
    include Wombat::Crawler

    base_url "https://www.jumia.co.ke"
    path "/catalog/?q=laptop"

    product xpath: "//div[@class='banner']"

    # Wombat.crawl do
        # base_url "https://www.jumia.co.ke"
        # path "/catalog/?q=laptop"

        # some_data xpath: "//div[@class='banner']"
    # end

end