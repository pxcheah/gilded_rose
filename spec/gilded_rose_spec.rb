require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { "item" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    context "normal item" do
      let(:name) { "item" }

      context "before expiry" do
        it "quality should be initial_quality-1" do
          expect(item.quality).to eql(initial_quality-1)
        end
      end

      context "on expiry" do
        let(:initial_sell_in) { 0 }

        it "quality should be initial_quality-2" do
          expect(item.quality).to eql(initial_quality-2)
        end
      end

      context "after expiry" do
        let(:initial_sell_in) { -2 }

        it "quality should be initial_quality-2" do
          expect(item.quality).to eql(initial_quality-2)
        end
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      context "before expiry" do
        let(:initial_sell_in) { 5 }
        let(:initial_quality) { 10 }
        it "quality should be initial_quality+1" do
          expect(item.quality).to eql(initial_quality+1)
        end
      end

      context "on expiry" do
        let(:initial_sell_in) { 0 }

        it "quality should be initial_quality+2" do
          expect(item.quality).to eql(initial_quality+2)
        end
      end

      context "after expiry" do
        let(:initial_sell_in) { -2 }

        it "quality should be initial_quality+2" do
          expect(item.quality).to eql(initial_quality+2)
        end
      end

      context "at max quality" do
        let(:initial_sell_in) { -2 }
        let(:initial_quality) { 49 }

        it "quality should cap at 50" do
          expect(item.quality).to eql(50)
        end
      end
    end

    context "Backstage Pass" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      context "initial_sell_in > 10" do
        let(:initial_sell_in) { 15 }

        it "quality should be initial_quality+1" do
          expect(item.quality).to eql(initial_quality+1)
        end
      end

      context "5 < initial_sell_in <= 10" do
        let(:initial_sell_in) { 6 }

        it "quality should be initial_quality+2" do
          expect(item.quality).to eql(initial_quality+2)
        end
      end

      context "0 < initial_sell_in <= 5" do
        let(:initial_sell_in) { 2 }

        it "quality should be initial_quality+3" do
          expect(item.quality).to eql(initial_quality+3)
        end
      end

      context "after expiry" do
        let(:initial_sell_in) { 0 }

        it "quality should be 0" do
          expect(item.quality).to eql(0)
        end
      end

      context "at max quality" do
        let(:initial_sell_in) { 3 }
        let(:initial_quality) { 48 }

        it "quality should cap at 50" do
          expect(item.quality).to eql(50)
        end
      end
    end

    context "Sulfuras" do
      let(:initial_quality) { 80 }
      let(:name) { "Sulfuras, Hand of Ragnaros" }

      it "quality should never decrease" do
        expect(item.sell_in).to eql(initial_sell_in)
        expect(item.quality).to eql(80)
      end
    end

    context "Conjured Items" do
      let(:name) { "Conjured item" }

      context "before expiry" do
        let(:initial_sell_in) { 5 }
        let(:initial_quality) { 10 }
        it "quality should be initial_quality-2" do
          expect(item.quality).to eql(initial_quality-2)
        end
      end

      context "on expiry" do
        let(:initial_sell_in) { 0 }

        it "quality should be initial_quality-4" do
          expect(item.quality).to eql(initial_quality-4)
        end
      end

      context "after expiry" do
        let(:initial_sell_in) { -2 }

        it "quality should be initial_quality-4" do
          expect(item.quality).to eql(initial_quality-4)
        end
      end
    end
  end

  # context "with multiple items" do
  #   let(:items) {
  #     [
  #       Item.new("NORMAL ITEM", 5, 10),
  #       Item.new("Aged Brie", 3, 10),
  #       Item.new("Conjured item", 6, 3)
  #     ]
  #   }
  #
  #   before { update_quality(items) }
  #
  #   it "your specs here" do
  #
  #   end
  # end
end
