class Journal < ActiveRecord::Base
  def self.queryJournal(size=60)
    Journal.limit(size).order("created_at DESC")
  end
end
