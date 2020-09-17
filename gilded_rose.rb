class GildedRose

  def initialize(items)
    @items = items
    @standard_items = ["+5 Dexterity Vest", "Elixir of the Mongoose"]
  end

  def update_quality()
    @items.each do |item|
      if @standard_items.include?(item) 
        puts "Item is found in standard_item array"
        daily_update(item)
      end
    end
  end

  def daily_update(item)
    item.sell_in -= 1
    puts "Item has been passed to daily update"
    item.quality -= 1
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

end
