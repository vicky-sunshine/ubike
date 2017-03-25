require 'sequel'
require 'json'

# Holds and persists an account's information
class Station < Sequel::Model
  plugin :timestamps, update_on_create: true
  set_allowed_columns :sno, :sna, :tot, :sbi,
                      :sarea, :mday, :lat, :lng,
                      :ar, :sareaen, :snaen, :aren,
                      :bemp, :act
  # scope
  dataset_module do
    def by_sna(sna)
      where(:sna => sna)
    end

    def available
      where(:act => 0).invert
    end

    def not_available
      where(:act => 0)
    end

    def empty
      where(:sbi => 0)
    end

    def not_empty
      filter{sbi > 0}
    end

    def not_full
      filter{bemp > 0}
    end

    def full
      where(:bemp => 0)
    end

    def by_distance(user_lat, user_lng)
      order(Sequel.lit("(lat-#{user_lat})*(lat-#{user_lat})+(lng-#{user_lng})*(lng-#{user_lng})"))
    end
  end

  def distance(user_lat, user_lng)
    Math.hypot(lat-user_lat, lng-user_lng)
  end

  def to_json(options = {})
    JSON({
           "station": sna,
           "num_ubike": sbi
        },
        options)
  end
end
