class Lane < ApplicationRecord
  self.table_name = "bowling"
  attribute :date_match, :boolean

  def self.query(date=nil, time=nil, lanes=nil)
    date = date.nil? ? Date.today : Date.strptime(date, "%d-%m-%Y")
    time = time.nil? ? Time.now : DateTime.parse(time, "%H:%M").to_time
    lanes = lanes.nil? ? 1 : lanes.to_i
    result = Lane.where("date LIKE '%#{date.strftime "%Y-%m-%d"}%'").to_a
    result.each do |lane|
      if !(lane.date =~ /#{date.strftime "%Y-%m-%d"}/).nil? &&
        !(lane.date =~ /#{time.strftime("%H") + ":00:00"}/).nil? &&
        lane.lanes == lanes
        lane[:date_match] = true
      end
    end
  end

  def self.update(date=nil, time=nil, lanes=nil)
    date = date.nil? ? Date.today : Date.strptime(date, "%d-%m-%Y")
    time = time.nil? ? Time.now : DateTime.parse(time, "%H:%M").to_time
    lanes = lanes.nil? ? 1 : lanes.to_i
    date_str = date.strftime "%d-%m-%Y"
    time_str = time.strftime("%H") + ":00"
    system("#{Rails.root.join("scripts", "bowling")} #{date_str} #{time_str} #{lanes}")
  end
end
