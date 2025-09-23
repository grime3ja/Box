class Token
  def initialize(type, text, start_index, end_index)
    @type = type
    @text = text
    @start_index = start_index
    @end_index = end_index
  end
end