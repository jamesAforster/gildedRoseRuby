require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it "will correctly update standard items before their expiry date" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(19)
    end

    it "will degrade standard items twice as fast after expiry" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=0, quality=20)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq(18)
    end

    it "will never decrease quality below 0" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=0, quality=0)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq(0)
    end

    it "will never increase an item's quality above 50" do
      items = [Item.new(name="Aged Brie", sell_in=-20, quality=50)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(-21)
      expect(items[0].quality).to eq(50)
    end


    it "will not decrease quality or sell_in for Sulfuras, Hand of Ragnaros" do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=10, quality=10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(10)
      expect(items[0].quality).to eq(10)
    end

    it "will increase the quality of Aged Brie the older that it gets" do
      items = [Item.new(name="Aged Brie", sell_in=10, quality=10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(11)
    end

    it "will increase the quality of Backstage passes to a TAFKAL80ETC concert by 2 when 10 days or less until sell_in date" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(12)
    end
  end

end
