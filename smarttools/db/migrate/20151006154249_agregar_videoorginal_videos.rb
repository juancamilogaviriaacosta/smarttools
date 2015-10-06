class AgregarVideoorginalVideos < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :videooriginals3
  end

  def self.down
    remove_attachment :videos, :videooriginals3
  end
end
