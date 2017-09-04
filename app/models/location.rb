class Location < ApplicationRecord
  has_and_belongs_to_many :events

  validates :name, presence: true

  def conflicts?(event)
    events = self.events.where('id IS NOT ?', event.id)
    events = events.where('starts_at > ? AND starts_at < ?', event.starts_at, event.ends_at)
      .or(events.where('ends_at > ? AND ends_at < ?', event.starts_at, event.ends_at))
      .or(events.where('starts_at <= ? AND ends_at >= ?', event.starts_at, event.ends_at))
    events.exists?
  end
end
