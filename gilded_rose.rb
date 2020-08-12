class GildedRose

  def initialize(items)
    @items = items

    @item_properties = [
      {
      name: "+5 Dexterity Vest",
      sell_in_adjustment: 1,
      quality_adjustment: 1
      },
    
      {
      name: "Elixir of the Mongoose",
      sell_in_adjustment: 1,
      quality_adjustment: 1
      }
    ]
  end

  def update_quality()
    @items.map do |item|
      @item_properties.each do |property|
        if item.name == property[:name]
          item.sell_in -= property[:sell_in_adjustment]
          item.quality -= property[:quality_adjustment]
        end
      end
    end
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
