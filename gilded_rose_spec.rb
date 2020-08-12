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

    it "will not decrease quality or sell_in for Sulfuras, Hand of Ragnaros" do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=10, quality=10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(10)
      expect(items[0].quality).to eq(10)
    end

  
  end

end
