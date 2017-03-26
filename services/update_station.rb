# Service object to create new Secret using all columns
class UpdateStation
  def self.call(sno:, sbi:, mday:, bemp:, act:)
    s = Station.by_sno(sno)
    s.sbi = sbi
    s.mday = mday
    s.bemp = bemp
    s.act = act
    s.save
  end
end
