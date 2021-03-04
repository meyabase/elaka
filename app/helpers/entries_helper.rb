module EntriesHelper

  # For likes and dislikes counts. Only display number for > 0
  def trim_zero(number)
    return '' if number <= 0
    number
  end

  #number_to_human(number, :format => '%n%u',
  #                :precision => 2,
  #                :units => { :thousand => 'K', :million => 'M', :billion => 'B' })
end
