require 'date'
class When_is
  attr_accessor :day, :month, :year
  def initialize(app)
    @app = app
    today = Date.today
    @day = today.day
    @month = today.month
    @year = today.year
  end
  
  def change
    @date = Date.parse("#{@year}-#{@month}-#{@day}")
    @app.after((@date + @after_offset).to_s)
    @app.before((@date - @before_offset).to_s)
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

Shoes.app :title => "when_is", :width => 800, :resizable => false do
  when_is = When_is.new self
  
  def before(date)
    @before.replace date
  end
  
  def after(date)
    @after.replace date
  end
  
  stack do
    background lavender
    title '_when is'
    
    flow :margin_left => 35 do
      
      @before = caption strong("when_is"), :stroke => firebrick, :margin => [0,10,5,0]
      caption strong("="), :stroke => firebrick, :margin => [5,10,5,0]
      caption strong("days"), :stroke => firebrick, :margin => [5,10,5,0]
      edit_line :width => 50, :margin => [5,7,5,0] do |days|
        when_is.subtract days.text.to_i
      end
      subtitle strong("-"), :stroke => firebrick, :margin => [0,0,10,0]
      flow :width => 220, :height => 40 do
        border firebrick, :strokewidth => 2
        list_box :items => (1..31).to_a, :choose => 1, :width => 50, :margin => 5 do |d|
          when_is.day = d.text; when_is.change
        end
        list_box :items => Date::ABBR_MONTHNAMES, :choose => 'Jan', :width => 70, :margin => 5 do |m|
          when_is.month = m.text; when_is.change
        end
        list_box :items => (2009..2050).to_a, :choose => Date.today.year, :width => 100, :margin => 5 do |y|
          when_is.year = y.text; when_is.change
        end
      end
      subtitle strong("+"), :stroke => firebrick, :margin => [5,0,5,0]
      edit_line :width => 50, :margin => [5,7,5,0] do |days|
        when_is.add days.text.to_i
      end
      caption strong("days"), :stroke => firebrick, :margin => [0,10,5,0]
      caption strong("="), :stroke => firebrick, :margin => [0,10,5,0]
      @after = caption strong("when_is"), :stroke => firebrick, :margin => [0,10,5,0]
    end
  end
end