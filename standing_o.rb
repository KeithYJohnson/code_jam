require 'pry'
require 'pry-byebug'
# path = "/Users/keithjohnson/play/code_jam/standing_o.txt"
path = "/Users/keithjohnson/Downloads/A-large.in"
#case 1: 0
#case 2: 1
#case 3: 2
#case 4: 0
class StandingO
  attr_accessor :file, :array, :max_shyness, :audience, :case_number, :solution,
                :invitee_count, :people_standing, :output, :total_cases, :read_file
  def initialize(filepath)
    self.file = File.open(filepath)
    self.read_file = file.readlines
    self.total_cases = read_file.first
    self.array = read_file[1..-1]
    self.invitee_count = 0
    self.people_standing = 0
    self.output = []
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
          @people_standing += ((shy_level - people_standing) + number)
        end
      end
      @output << "Case ##{case_number}: #{@invitee_count || 0}\n"
    end
    last = @output.pop.tr("\n","")
    @output << last
    file_body = @output.join
    IO.write('standing_o_solution.out', file_body)
  end
end
StandingO.new(path).perform

