def update_quality(items)
  items.each do |item|
    # skip legendary item
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    # decrease sell_in value
    item.sell_in -= 1

    # adjust quality based on sell_in
    if item.name == 'Aged Brie'
      increase_quality
      if item.sell_in < 0
        increase_quality
      end
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
      increase_quality
      if item.sell_in < 10
        increase_quality
      end
      if item.sell_in < 5
        increase_quality
      end
      if item.sell_in < 0
        item.quality -= item.quality
      end
    else
      decrease_quality
      if item.sell_in < 0
        decrease_quality
      end
    end
  end
end

def increase_quality
  if item.quality < 50
    item.quality += 1
  end
end

def decrease_quality
  if item.quality > 0
    item.quality -= 1
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
