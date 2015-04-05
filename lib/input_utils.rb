# encoding: utf-8
class ActionCancelled < StandardError; end

module InputUtils

  # optional fields
  #   :with_cancel
  def table_from_array(array, title=nil, attrs={})
    rows = []
    array.each_with_index do |item, i|
      rows << [i+1, item.to_s]
    end

    if attrs[:with_cancel]
      rows << :separator
      rows << [array.size+1, 'Отмена']
    end

    puts Terminal::Table.new(rows: rows, title: title)
  end

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

  def choose_index_from_table(array, attrs={})
    table_from_array(array, attrs[:title], with_cancel: true)
    welcome_message = attrs[:message] || 'Выберите элемент из списка: '

    print welcome_message

    choice = nil
    loop do
      choice = gets.to_i
      raise ActionCancelled if choice == array.size + 1
      return array[choice-1] if (1..array.size).cover?(choice)

      puts 'Неверный номер элемента, попробуйте еще раз'
      print welcome_message
    end
  end

  def choose_index_from_array(array, attrs={})
    if array.empty?
      puts 'нет элементов'
      return nil
    end
    array.each_with_index do |item, i|
      puts "#{i+1}. #{item}"
    end

    print attrs[:message] || 'Выберите элемент из списка: '
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
    print attrs[:message] || 'Введите параметр: ' unless attrs[:quite]
    gets.strip
  end

  def get_integer(attrs={})
    print attrs[:message] || 'Введите число: ' unless attrs[:quite]

    int = nil
    until int do
      begin
        int = Integer(get_parameter(quite: true))
      rescue ArgumentError
        print 'Введите число: '
      end
    end
    int
  end

end

