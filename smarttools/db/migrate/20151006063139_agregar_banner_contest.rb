class AgregarBannerContest < ActiveRecord::Migration
  def self.up
    add_attachment :contests, :banner
  end

  def self.down
    remove_attachment :contests, :banner
  end
end
