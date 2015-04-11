require 'pry'
require 'pry-byebug'
path = "/Users/keithjohnson/play/code_jam/pancakes.txt"

#Input
# 3
# 1
# 3
# 4
# 1 2 1 2
# 1
# 4

#Output
# Case #1: 3
# Case #2: 2
# Case #3: 3
class Diner
  attr_accessor :total_pancakes

  def self.all
    @diners ||= []
  end

  def self.with_most_pancakes
    Diner.all.max_by(&:total_pancakes)
  end

  def self.each_eat_a_pancake
    all.each { |diner| diner.eat_a_pancake }
  end

  def initialize(total_pancakes)
    self.total_pancakes = total_pancakes
    Diner.all << self
  end

  def eat_a_pancake
    @total_pancakes -= 1
  end

  def should_share?
    total_pancakes > 3
  end

  def share
    number_of_pancakes_to_give = @total_pancakes / 2
    @total_pancakes -= (@total_pancakes - number_of_pancakes_to_give)
  end
end

class EatPancakes
  attr_accessor :file, :read_file, :total_cases, :array, :output,
                :total_diners, :pancakes_by_diner, :minutes

  def initialize(filepath)
    self.file = File.open(filepath)
    self.read_file = file.readlines
    self.total_cases = read_file.first
    self.array = read_file[1..-1]
    self.minutes = 0
    self.output = []
  end

  def diners
    @diners ||= Diner.all
  end

  def perform
    @case_number = 0


    array.each_slice(2) do |pair|
      minutes = 0
      @case_number + 1

      @total_diners = pair.first.to_i
      @pancakes_by_diner = pair.last.split(' ').map(&:to_i)
      @total_pancakes = pancakes_by_diner.inject(:+)


      @pancakes_by_diner.each { |pancake_count| Diner.all << Diner.new(pancake_count) }

      run_pancake_round until diners.each { |diner| diner.total_pancakes <= 0 }
      # if diners.any?(&:should_share?)
      #   Diner.with_most_pancakes.share
      #   minutes += 1
      # elsif diners.any? {|diner| diner.total_pancakes > 0 }
      #   Diner.each_eat_a_pancake
      #   minutes += 1
      # end
      output << minutes
      puts output
    end
  end

  def run_pancake_round
    if diners.any?(&:should_share?)
      Diner.with_most_pancakes.share
    elsif diners.any? {|diner| diner.total_pancakes > 0 }
      Diner.each_eat_a_pancake
    end
    minutes +=1
  end

end
EatPancakes.new(path).perform
