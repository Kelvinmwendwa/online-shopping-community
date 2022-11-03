# frozen_string_literal: true

class DeleteExpiredJob
  include Sidekiq::Job

  def perform(*_args)
    # Do something
    expired = Product.where('expire_at<?', Time.now)
    expired.destroy_all
  end
end
