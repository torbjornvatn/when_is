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
    @app.after((@date + @after_offset).strftime("%d.%m.%Y")) unless @after_offset == nil
    @app.before((@date - @before_offset).strftime("%d.%m.%Y")) unless @before_offset == nil
  end
  
  def subtract(days)
    @before_offset = days
    change
  end
  
  def add(days)
    @after_offset = days
    change
  end
end

$version = 0.2
Shoes.app :title => "when_is", :width => 800, :height => 300, :resizable => false do
  when_is = When_is.new self
  today = when_is.today
  background gainsboro
  
  def before(date)
    @before.replace date
  end
  
  def after(date)
    @after.replace date
  end
  
  stack do
    title '_when is'
    
    flow :margin_top => 60, :margin_left => 30 do
      flow(:width => 100){@before = caption strong("?"), :stroke => firebrick, :align => 'right'}
      caption strong("= days "), :stroke => firebrick
      edit_line :width => 50 do |days|
        when_is.subtract days.text.to_i
      end
      caption strong(" –   "), :stroke => firebrick
      flow :width => 220 do
        flow do
          fill gainsboro
          stroke firebrick
          strokewidth 3
          rect -5, -5, 225, 40, 10
        end
        list_box :items => (1..31).to_a, :choose => today.day, :width => 67 do |d|
          when_is.day = d.text
          when_is.change
        end
        month_names = Date::ABBR_MONTHNAMES
        list_box :items => month_names, :choose => month_names[today.month], :width => 70 do |m|
          when_is.month = m.text
          when_is.change
        end
        list_box :items => (1970..2050).to_a, :choose => today.year, :width => 80 do |y|
          when_is.year = y.text
          when_is.change
        end
      end
      caption strong(" + "), :stroke => firebrick
      edit_line :width => 50 do |days|
        when_is.add days.text.to_i
      end
      caption strong("days ="), :stroke => firebrick
      flow(:width => 100){@after = caption strong("?"), :stroke => firebrick, :align => 'left'}
    end
    inscription "v#{$version}", :stroke => gray, :margin_top => 90
  end
end