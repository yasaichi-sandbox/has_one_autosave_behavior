class ArtistProfile < ApplicationRecord
  attr_writer :memo_for_debug

  belongs_to :artist

  after_save do
    self.class.memo_for_debug += 1
    self.memo_for_debug += 1
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