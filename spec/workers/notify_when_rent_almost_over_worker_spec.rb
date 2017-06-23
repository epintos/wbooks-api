require 'rails_helper'

describe NotifyWhenRentAlmostOverWorker, type: :worker do
  let(:book) { create(:book) }
  let!(:rent) { create(:rent, book: book, to: Time.zone.local(2017, 6, 21), returned_at: nil) }

  it 'creates notifications for users that wished the book' do
    expect do
      Timecop.travel(Time.zone.local(2017, 6, 18)) do
        NotifyWhenRentAlmostOverWorker.new.perform
      end
    end.to change { Notification.count }.by(1)
  end
end
