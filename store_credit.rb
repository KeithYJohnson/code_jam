#https://code.google.com/codejam/contest/351101/dashboard#s=p0
file_path = "/Users/keithjohnson/Downloads/A-small-practice.in"
@array = File.open(file_path).readlines
#skip the first line which only give the number of cases
@array = @array[1..-1]

@count = 0
@output = []
#step(3) cuz case data comes in three line chunks
#first line is your store credit
#second line is the number of items in a store
#third line is a the price of all those items
(0..@array.length-1).step(3) do |index|
  @count +=1
  credit = @array[index].to_i
  item_cost_array = @array[index+2].split(' ').map(&:to_i)
  item_cost_array.each_with_index do |item, items_index|
    item_cost_array.drop(items_index+1).each_with_index do |next_item, next_items_index|
      if item + next_item == credit
        @output << "Case ##{@count}: #{items_index}, #{next_items_index+items_index+1}"
        break
      end
    end
  end
end
puts @output
