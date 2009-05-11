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
  
  def to_s
    display_date = Date.parse("#{@year}-#{@month}-#{@day}") 
    (display_date - @offset).to_s
  end
  
  def subtract(days)
    @offset = -days
  end
  
  def add(days)
    @offset = days
  end
  
end

new_date = nil
when_is = When_is.new

Shoes.app(:title => "when_is") do
  background lavender
  banner 'when is'
  
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    edit_line :text => "days", :width => 50 do |before|
      when_is.add before.text.to_i
      new_date.replace when_is
    end
  end
  
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    list_box :items => (1..31).to_a, :choose => 1, :width => 50 do |d|
      when_is.day = d.text
      new_date.replace when_is
    end
    list_box :items => Date::ABBR_MONTHNAMES, :choose => 'Jan', :width => 50 do |m|
      when_is.month = m.text
      new_date.replace when_is
    end
    list_box :items => (2009..2050).to_a, :choose => Date.today.year, :width => 50 do |y|
      when_is.year = y.text
      new_date.replace when_is
    end
  end
  
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    edit_line :text => "days", :width => 50 do |after|
      when_is.subtract after.text.to_i
      new_date.replace when_is
    end
  end
  
  new_date = para strong(when_is)
end