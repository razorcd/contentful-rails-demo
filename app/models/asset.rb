class Asset < ActiveRecord::Base
  has_many :products
  has_attached_file :file

  validates_attachment_file_name :file, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/, /mp4\Z/, /pdf\Z/]

  def self.delete_all_and_remove_files
    self.delete_all
    FileUtils.rm_rf("#{ENV['LOCAL_STORAGE_PATH']}/assets")
  end
end
