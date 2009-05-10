Shoes.app(:title => "when_is") do
  flow do
    background lavender
    banner 'when is'
    @before = edit_line
    @before.text="Before"
    @before.width=50

    @text = para ""
    @before.change do |b|
      @text.text = b.text
    end
    caption "days"
  end
end