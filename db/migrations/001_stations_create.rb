require 'sequel'

Sequel.migration do
  change do
    create_table(:stations) do
      primary_key :id

      String :sno
      String :sna
      Interger :tot
      Integer :sbi
      String :sarea
      String :mday
      Float :lat
      Float :lng
      String :ar
      String :sareaen
      String :snaen
      String :aren
      Integer :bemp
      Integer :act
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
