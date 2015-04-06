# encoding: utf-8
class ActionCancelled < StandardError; end

module InputUtils

  # optional fields
  #   :without_cancel
  def table_from_array(array, title=nil, attrs={})
    rows = []
    array.each_with_index do |item, i|
      rows << [i+1, item.to_s]
    end

    if !attrs[:without_cancel]
      rows << :separator
      rows << [array.size+1, 'Отмена']
    end

    puts Terminal::Table.new(rows: rows, title: title)
  end

  # outputs hash.values and returns selected key
  # optional field :message
  # Example:
  #   choose_from_hash({a: 'A!!!', b: 'B!!!'})
  #   # if user selects 'A!!!', methods returns :a
  # def choose_from_hash(hash, attrs={})
  #   choice = choose_from_table(hash.values, attrs.merge(return_index: true))
  #   hash.keys[choice]
  # end

  def choose_from_table(collection, attrs={})
    without_cancel = attrs[:without_cancel] || false
    welcome_message = attrs[:message] || 'Выберите элемент из списка: '

    if block_given?
      values = collection.map {|t| yield(t)}
    elsif collection.is_a?(Hash)
      values = collection.values
    else
      values = collection
    end

    table_from_array(values, attrs[:title], without_cancel: without_cancel)
    print welcome_message

    choice = nil
    loop do
      choice = gets.to_i
      raise ActionCancelled if choice == values.size + 1
      break if (1..values.size).cover?(choice)

      puts 'Неверный номер элемента, попробуйте еще раз'
      print welcome_message
    end

    if collection.is_a?(Hash)
      collection.keys[choice-1]
    else
      collection[choice-1]
    end
  end

  # not used at the moment
  # def choose_index_from_array(array, attrs={})
  #   if array.empty?
  #     puts 'нет элементов'
  #     return nil
  #   end
  #   array.each_with_index do |item, i|
  #     puts "#{i+1}. #{item}"
  #   end

  #   print attrs[:message] || 'Выберите элемент из списка: '
  #   choice = nil
  #   loop do
  #     choice = gets.to_i
  #     if (1..array.size).cover?(choice)
  #       break
  #     else
  #       puts 'Неверный номер элемента, попробуйте еще раз'
  #     end
  #   end

  #   choice-1
  # end

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

