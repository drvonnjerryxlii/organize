def build_contraints_regex(array)
  regexp_string = ''
  last_index = array.length - 1

  array.each_with_index do |constraint, index|
    regexp_string += "(#{ constraint })"
    regexp_string += '|' unless index == last_index
  end

  return /#{ regexp_string }/
end
