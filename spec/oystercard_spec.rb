require 'oystercard.rb'

describe Oystercard do

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'adds money to the card balance' do
    expect(subject.top_up(10)).to eq (10)
  end

  it 'can top up the balance' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it 'prevents topping up balance if it would go over the limit' do
    limit = Oystercard::LIMIT
    subject.top_up(limit)
    expect { subject.top_up 1 }.to raise_error "Top up would exceed limit of #{limit}."
  end

  it 'can deduct the balance' do
    expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
  end

  it 'starts not in journey' do
    expect(subject.journey?).to eq false
  end

  it 'starts journey when user touches in' do
    subject.touch_in
    expect(subject.journey?).to eq true
  end

end
