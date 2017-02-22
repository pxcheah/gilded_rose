def update_quality(items)
  items.each do |item|
    puts "Name: #{item.name}, Quality: #{item.quality}, Sell in: #{item.sell_in}"

    case item.name
    when "Aged Brie"
      AgedBrieUpdater.new.update(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassUpdater.new.update(item)
    when /^Conjured/
      ConjuredItemUpdater.new.update(item)
    when "Sulfuras, Hand of Ragnaros"
      LegendaryItemUpdater.new.update(item)
    else
      ItemUpdater.new.update(item)
    end
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

class LegendaryItemUpdater < ItemUpdater
  def update_quality(item)
  end
  def update_sell_in(item)
  end
end

class AgedBrieUpdater < ItemUpdater
  def update_quality(item)
    if item.sell_in <= 0
      change_quality(item, 2)
    else
      change_quality(item, 1)
    end
  end
end

class BackstagePassUpdater < ItemUpdater
  def update_quality(item)
    if item.sell_in > 10
      change_quality(item, 1)
    elsif item.sell_in > 5
      change_quality(item, 2)
    elsif item.sell_in > 0
      change_quality(item, 3)
    else
      item.quality = 0
    end
  end
end

class ConjuredItemUpdater < ItemUpdater
  def update_quality(item)
    if item.sell_in <= 0
      change_quality(item, -4)
    else
      change_quality(item, -2)
    end
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
