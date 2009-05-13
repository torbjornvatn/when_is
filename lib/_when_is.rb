require 'date'
class When_is
  attr_accessor :day, :month, :year, :today
  def initialize(app)
    @app = app
    @today = Date.today
    @day = @today.day
    @month = @today.month
    @year = @today.year
  end
  
  def change
    debug "changing"
    @date = Date.parse("#{@year}-#{@month}-#{@day}")
    @app.after((@date + @after_offset).to_s) unless @after_offset == nil
    @app.before((@date - @before_offset).to_s) unless @before_offset == nil
  end
  
  def subtract(days)
    @before_offset = days
    change
  end
  
  def add(days)
    @after_offset = days
    change
  end
  
  def to_s
    @date.to_s
  end
  
end
$version = 0.2
Shoes.app :title => "when_is", :width => 800, :height => 300, :resizable => false do
  when_is = When_is.new self
  today = when_is.today
  background oldlace
  
  def before(date)
    @before.replace date
  end
  
  def after(date)
    @after.replace date
  end
  
  stack :margin => [30,30,30,0] do
    title '_when is'
    
    flow :margin => 20 do
      flow(:width => 100){@before = caption strong("?"), :stroke => firebrick, :margin => [0,10,5,0], :align => 'right'}
      caption strong("="), :stroke => firebrick, :margin => [5,10,5,0]
      caption strong("days"), :stroke => firebrick, :margin => [5,10,5,0]
      edit_line :width => 50, :margin => [5,7,5,0] do |days|
        when_is.subtract days.text.to_i
      end
      subtitle strong("-"), :stroke => firebrick, :margin => [0,0,8,0]
      flow :width => 220 do
        #border firebrick, :strokewidth => 2
        flow(:left => -10, :top => -11) do
          fill oldlace
          stroke firebrick
          strokewidth 3
          rect 10, 10, 220, 40, 10
        end
        list_box :items => (1..31).to_a, :choose => today.day, :width => 67, :margin => [10,5,5,5] do |d|
          when_is.day = d.text
          when_is.change
        end
        month_names = Date::ABBR_MONTHNAMES
        list_box :items => month_names, :choose => month_names[today.month], :width => 70, :margin => 5 do |m|
          when_is.month = m.text
          when_is.change
        end
        list_box :items => (1970..2050).to_a, :choose => today.year, :width => 80, :margin => 5 do |y|
          when_is.year = y.text
          when_is.change
        end
      end
      subtitle strong("+"), :stroke => firebrick, :margin => [5,0,5,0]
      edit_line :width => 50, :margin => [5,7,5,0] do |days|
        when_is.add days.text.to_i
      end
      caption strong("days"), :stroke => firebrick, :margin => [0,10,5,0]
      caption strong("="), :stroke => firebrick, :margin => [0,10,5,0]
      flow(:width => 100){@after = caption strong("?"), :stroke => firebrick, :margin => [0,10,5,0], :align => 'left'}
    end
    inscription "v#{$version}", :stroke => gray, :margin_top => 90
  end
end