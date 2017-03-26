class CreateStations
  def self.import(seed_file:)
    file_path = "./db/seeds/#{seed_file}"
    @data = JSON.parse(File.read(file_path)).values
    @data.each do |e|
      s = Station.new(e)
      s.save
    end
  end
end
