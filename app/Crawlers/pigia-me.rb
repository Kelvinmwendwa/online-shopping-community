require 'watir'
require 'webdrivers'
require 'nokogiri'
require "awesome_print"

class PigiaMeScrape
    def initialize(search)
      browser = Watir::Browser.new
      browser.goto "https://www.pigiame.co.ke/classifieds?q=#{}"
    end
end