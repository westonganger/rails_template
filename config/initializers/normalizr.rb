Normalizr.configure do
  # add :titleize do |value|
  #   String === value ? value.titleize : value
  # end

  # add :truncate do |value, options|
  #   if String === value
  #     options.reverse_merge!(length: 30, omission: '...')
  #     l = options[:length] - options[:omission].mb_chars.length
  #     chars = value.mb_chars
  #     (chars.length > options[:length] ? chars[0...l] + options[:omission] : value).to_s
  #   else
  #     value
  #   end
  # end

  # add :indent do |value, amount = 2|
  #   if String === value
  #     value.indent(amount)
  #   else
  #     value
  #   end
  # end

  default :strip, :blank
end
