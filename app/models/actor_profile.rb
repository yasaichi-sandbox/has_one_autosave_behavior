class ActorProfile < ApplicationRecord
  attr_writer :memo_for_debug

  belongs_to :actor

  after_save do
    self.class.memo_for_debug += 1
    self.memo_for_debug += 1

    actor.update(name: "#{actor.name.split(' (').first} (as of #{Time.current.to_date})")
  end

  class << self
    attr_writer :memo_for_debug

    def memo_for_debug
      @memo_for_debug ||= 0
    end
  end

  def memo_for_debug
    @memo_for_debug ||= 0
  end
end
