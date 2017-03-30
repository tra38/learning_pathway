require 'csv'

module HeuristicHelper
  def self.profile(name:, rf:, rl:, ri:,l:)
    CSV::Row.new(["Student Name", "RF", "RL", "RI", "L"], [name,rf,rl,ri,l])
  end
end