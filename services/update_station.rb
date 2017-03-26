# Service object to create new Secret using all columns
class UpdateStation
  def self.call(sna:, sbi:, mday:, bemp:, act:)
    secret = Secret.by_sna(sna)
    secret.sbi = sbi
    secret.mday = mday
    secret.bemp = bemp
    secret.act = act
  end
end
