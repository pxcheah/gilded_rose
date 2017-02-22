def update_quality(items)
  items.each do |item|
    puts "Name: #{item.name}, Quality: #{item.quality}, Sell in: #{item.sell_in}"
    ItemUpdater.new.update(item)
    # skip legendary item
    # return if item.name == 'Sulfuras, Hand of Ragnaros'

    # decrease sell_in value
    # item.sell_in -= 1

    # adjust quality based on sell_in
    # if item.name == 'Aged Brie'
    #   increase_quality
    #   if item.sell_in < 0
    #     increase_quality
    #   end
    # elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
    #   increase_quality
    #   if item.sell_in < 10
    #     increase_quality
    #   end
    #   if item.sell_in < 5
    #     increase_quality
    #   end
    #   if item.sell_in < 0
    #     item.quality -= item.quality
    #   end
    # elsif item.name.include? 'Conjured'
    #   decrease_quality
    #   decrease_quality
    # else
    #   decrease_quality
    #   if item.sell_in < 0
    #     decrease_quality
    #   end
    # end
  end
end

class ItemUpdater
  def update(item)
    update_quality(item)
    update_sell_in(item)
  end

  def update_quality(item)
    if item.sell_in <= 0
      change_quality(item, -2)
    else
      change_quality(item, -1)
    end
  end

  def change_quality(item, value)
    item.quality += value
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.quality < 0
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
