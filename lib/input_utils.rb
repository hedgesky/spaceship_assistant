module InputUtils

  # optional field :message
  def choose_from_array(array, attrs={})
    array[choose_index_from_array(array, attrs)]
  end

  # outputs hash.values and returns selected key
  # optional field :message
  # Example:
  #   choose_from_hash({a: 'A!!!', b: 'B!!!'})
  #   # if user selects 'A!!!', methods returns :a
  def choose_from_hash(hash, attrs={})
    choice = choose_index_from_array(hash.values, attrs)
    hash.keys[choice]
  end

  def choose_index_from_array(array, attrs={})
    array.each_with_index do |item, i|
      puts "#{i+1}. #{item}"
    end

    puts attrs[:message] || 'Выберите элемент из списка'
    choice = nil
    loop do
      choice = gets.to_i
      if (1..array.size).cover?(choice)
        break
      else
        puts 'Неверный номер элемента, попробуйте еще раз'
      end
    end

    choice-1
  end

  # optional fields
  #   :message
  #   :quite
  def get_parameter(attrs={})
    puts attrs[:message] || 'Введите параметр' unless attrs[:quite]
    gets.strip
  end

  def get_integer(attrs={})
    puts attrs[:message] || 'Введите число' unless attrs[:quite]

    int = nil
    until int do
      begin
        int = Integer(get_parameter(quite: true))
      rescue ArgumentError
        puts 'Введите число'
      end
    end
    int
  end

end

