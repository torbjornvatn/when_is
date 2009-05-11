require 'date'
class When_is
  attr_accessor :day, :month, :year
  def initialize
    today = Date.today
    @day = today.day
    @month = today.month
    @year = today.year
    @offset = 0
  end
  
  def after
    date = Date.parse("#{@year}-#{@month}-#{@day}") 
     (date - @offset).to_s
  end
  
  def before
    date = Date.parse("#{@year}-#{@month}-#{@day}") 
     (date + @offset).to_s
  end
  
  def subtract(days)
    @offset = -days
  end
  
  def add(days)
    @offset = days
  end
  
end

before_date = nil
after_date = nil
when_is = When_is.new
Shoes.app :title => "when_is", :width => 800, :resizable => false do
  stack do
    background lavender
    title '_when is'
    
    flow :margin_left => 35 do
      
      t = caption strong(after_date), :stroke => firebrick, :margin => [0,10,5,0]
      caption strong("="), :stroke => firebrick, :margin => [5,10,5,0]
      caption strong("days"), :stroke => firebrick, :margin => [5,10,5,0]
      edit_line :width => 50, :margin => [5,7,5,0] do |before|
        when_is.add before.text.to_i
        before_date.replace when_is.before
        after_date.replace when_is.afterer
      end
      subtitle strong("-"), :stroke => firebrick, :margin => [0,0,10,0]
      flow :width => 220, :height => 40 do
        border firebrick, :strokewidth => 2
        list_box :items => (1..31).to_a, :choose => 1, :width => 50, :margin => 5 do |d|
          when_is.day = d.text
          before_date.replace when_is.before
          after_date.replace when_is.after
        end
        list_box :items => Date::ABBR_MONTHNAMES, :choose => 'Jan', :width => 70, :margin => 5 do |m|
          when_is.month = m.text
          before_date.replace when_is.before
          after_date.replace when_is.after
        end
        list_box :items => (2009..2050).to_a, :choose => Date.today.year, :width => 100, :margin => 5 do |y|
          when_is.year = y.text
          before_date.replace when_is.before
          after_date.replace when_is.after
        end
      end
      subtitle strong("+"), :stroke => firebrick, :margin => [5,0,5,0]
      edit_line :width => 50, :margin => [5,7,5,0] do |after|
        when_is.subtract after.text.to_i
        before_date.replace when_is.before
        after_date.replace when_is.after
      end
      caption strong("days"), :stroke => firebrick, :margin => [0,10,5,0]
      caption strong("="), :stroke => firebrick, :margin => [0,10,5,0]
      s = caption strong(before_date), :stroke => firebrick, :margin => [0,10,5,0]
    end
  end
end