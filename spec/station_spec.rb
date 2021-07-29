require 'station'

describe Station do
  it 'will return station name' do
    new_station = Station.new("Oxford", "3")
    expect(new_station.name).to eq "Oxford"
  end

  it 'will return station zone' do
    new_station = Station.new("Oxford", "3")
    expect(new_station.zone).to eq "3"
  end
end
