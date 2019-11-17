# prevent landing when the weather is stormy - done
# raises error if trying to take off plane that isnt in the airport
# plane can only take off from the airport they are in
# raise error if trying to take off when the plane is already flying


# things that could be improved upon
# Capacity dependent on the size of the aircraft
# whether the aircraft is reported broken


require 'airport'

describe Airport do
  airport = Airport.new

  describe "initialize" do 
    it "should have a default capacity of 10 planes if no argument is entered" do
      expect(Airport::DEFAULT_CAPACITY).to eq(10)
    end

    it "should have a default capacity of 20 planes if 20 is entered as an argument" do
      airport = Airport.new(20)
      expect(airport.capacity).to eq(20)
    end
  end

  let(:fair_weather) { double(:fair_weather, stormy?: false) }
  let(:stormy_weather) { double(:stormy_weather, stormy?: true) }
  let!(:plane) { double(:plane) }
  
  describe "#land_plane" do

    it "should have a land_plane method" do 
      expect(subject).to respond_to(:land_plane).with(2).argument
    end

    it "should be able to land a plane if fair weather" do
      expect(subject.land_plane(plane, fair_weather)).to eq([plane])
    end

    it "should raise an error if trying to land a plane when the airport is at capacity" do
      expect { 11.times { subject.land_plane(plane, fair_weather) } }.to raise_error "Plane cannot land as the Airport is full"
    end

    it "should be able to land 10 planes if user does not specify a capacity" do
      expect { 10.times { subject.land_plane(plane, fair_weather) } }.to_not raise_error
    end

    it "should prevent landing if the weather is stormy" do
      expect { subject.land_plane(plane, stormy_weather)}.to raise_error "Plane cannot land as the conditions are stormy"
    end
  end

  describe "#take_off" do

    it "should allow planes to take off" do
      subject.land_plane(plane, fair_weather)
      expect(subject.take_off(fair_weather)).to eq("Plane has taken-off")
    end

    it "should raise an error if instructing a plane to take off when there are no planes to take off" do 
      expect { subject.take_off(fair_weather) }.to raise_error "No planes at the airport"
    end

    it "should prevent take off if the weather is stormy" do
      subject.land_plane(plane, fair_weather)
      expect { subject.take_off(stormy_weather) }.to raise_error "Plane cannot take off due stormy weather"
    end
  end
end
