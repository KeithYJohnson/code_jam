require 'pry'
require 'pry-byebug'
# path = "/Users/keithjohnson/play/code_jam/standing_o.txt"
path = "/Users/keithjohnson/Downloads/A-small-attempt0.in"
#case 1: 0
#case 2: 1
#case 3: 3
#case 4: 0
class StandingO
  attr_accessor :file, :array, :max_shyness, :audience, :case_number, :solution,
                :invitee_count, :people_standing, :output
  def initialize(filepath)
    self.file = File.open(filepath)
    self.array = file.readlines[1..-1]
    self.invitee_count = 0
    self.people_standing = 0
    self.output = File.open('standing_o_solution.txt', 'w')
  end

  def perform
    @case_number = 0
    array.each do |line|
      @case_number +=1
      split_line = line.split(' ')

      @max_shyness = split_line.first
      @audience = split_line.last

      @people_standing = 0
      @invitee_count   = 0
      audience.split("").map(&:to_i).each_with_index do |number, shy_level|
        if shy_level <= @people_standing
          @people_standing += number
        else
          @invitee_count   += (shy_level - people_standing)
          @people_standing += (shy_level - people_standing)
        end
      end
      File.open('standing_o_solution.txt', 'a') { |file| file.puts("Case ##{case_number}: #{@invitee_count || 0}") }
    end
  end
end
StandingO.new(path).perform

