require 'rails_helper'
RSpec.describe DeleteExpiredJob, type: :job do
  
  describe "cron syntax" do
    schedule.each do |k,v|
      cron=v["cron"]
      it "#{k} has correct cron syntax" do
        expect {Fugit.do_parse(cron).not_to raise_error}
      end
    end
  end
end
