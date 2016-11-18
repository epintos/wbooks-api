class MailingWorker
  include Sidekiq::Worker

  def perform(email)
    ArticlesMailer.latest(email).deliver
  end
end
