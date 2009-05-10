Shoes.app(:title => "when_is", :resizable => false) do
  background lavender
  banner 'when is'
  @days = 0
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    @before = edit_line :text => "days", :width => 50
    @before.change do |b|
      @days = b.text
    end
  end
  flow(:width => 120, :margin => [3, 30, 0, 0]) do
    @after = edit_line :text => "days", :width => 50
    @after.change do |b|
      @days = b.text
    end
  end
  para @days
end