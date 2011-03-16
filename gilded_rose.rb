
class Aged_Brie
  def initialize item
    @my_item = item
  end

  def get_quality
    @my_item.quality += 2 if @my_item.sell_in <= 0
    @my_item.quality += 1 if @my_item.sell_in > 0
    @my_item.quality = 50 if @my_item.quality > 50

    return @my_item.quality
  end

  def get_sell_in
    @my_item.sell_in -= 1
  end
end

class Sulfuras
  def initialize item
    @my_item = item
  end

  def get_quality
    @my_item.quality
  end

  def get_sell_in
    @my_item.sell_in
  end
end

class Backstage
  def initialize item
    @my_item = item
  end

  def get_quality
    if @my_item.sell_in > 10
      @my_item.quality += 1
    elsif @my_item.sell_in > 5
      @my_item.quality += 2
    elsif @my_item.sell_in > 0
      @my_item.quality += 3
    else
      @my_item.quality = 0
    end

    @my_item.quality = 50 if @my_item.quality > 50

    @my_item.quality
  end

  def get_sell_in
    @my_item.sell_in - 1
  end
end

module Item_Factory
  def Item_Factory.create item
    return Aged_Brie.new(item) if item.name == 'Aged Brie'
    return Sulfuras.new(item) if item.name == 'Sulfuras, Hand of Ragnaros'
    return Backstage.new(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def Item_Factory.can_create? item_name
    item_name == 'Aged Brie' ||
    item_name == 'Sulfuras, Hand of Ragnaros' ||
    item_name == 'Backstage passes to a TAFKAL80ETC concert'
  end
end

def update_quality(items)
  include Item_Factory
  items.each do |item|

    if Item_Factory.can_create? item.name 
      i = Item_Factory.create(item)
      item.quality = i.get_quality
      item.sell_in = i.get_sell_in
    else

      if item.quality > 0
        item.quality -= 1
      end

      item.sell_in -= 1

      if item.sell_in < 0
        if item.quality > 0
          item.quality -= 1
        end
      end
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

