require 'rails_helper'

describe NotifyWhenRentOverWorker, type: :worker do
  let(:book) { create(:book) }
  let!(:rent) { create(:rent, book: book, to: Date.new(2017, 6, 21)) }
  let!(:wishes) { create_list(:wish, 10, book: book) }

  it 'creates notifications for users that wished the book' do
    expect do
      Timecop.travel(Time.local(2017,6,21)) do
        NotifyWhenRentOverWorker.new.perform
      end
    end.to change { Notification.count }.by(wishes.count)
  end
end
