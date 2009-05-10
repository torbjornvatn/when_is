
module DateConverter
  require 'date'
  @days = 0
  today = Date.today
  @day = today.day
  @month = today.month
  @year = today.year
  @date = strong("hei")
  
  def parse_date
    date_string = "#{@year}-#{@month}-#{@day}"
    @date = Date.parse(date_string).to_s
    
  end
end

Shoes.app(:title => "when_is", :resizable => false) do
  extend DateConverter
  background lavender
  banner 'when is'
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    @before = edit_line :text => "days", :width => 50
    @before.change do |b|
      @days = b.text.to_i
    end
  end
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    list_box :items => (1..31).to_a, :choose => 1, :width => 50 do |d|
      @day = d.text
      parse_date
    end
    list_box :items => Date::ABBR_MONTHNAMES, :choose => 'Jan', :width => 50 do |m|
      @month = m.text
      parse_date
    end
    list_box :items => (2009..2050).to_a, :choose => Date.today.year, :width => 50 do |y|
      @year = y.text
      parse_date
    end
  end
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    @after = edit_line :text => "days", :width => 50
    @after.change do |b|
      days = -b.text.to_i
    end
  end
  para @date
end