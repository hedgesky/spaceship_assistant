# encoding: utf-8
require 'terminal-table'

module Universe::Presenters
  module MapAsTable

    # marks is hash where key is a star system and value is its mark in the table
    # For example, '*' for current system

    def self.show(map, marks={})
      coord_table = build_coord_table(map, marks)
      rows = build_separated_rows(coord_table)

      puts Terminal::Table.new(rows: rows, title: 'Карта вселенной')
    end


    # it should be private, but I'm too lazy to do it so

    def self.build_coord_table(map, marks)
      coord_table = []
      max_x = map.star_systems.max_by(&:x).x

      map.star_systems.each do |system|
        caption = system.name
        caption += marks[system].to_s

        coord_table[system.y] ||= Array.new(max_x + 1)
        coord_table[system.y][system.x] = caption
      end
      coord_table.reverse
    end

    def self.build_separated_rows(coord_table)
      rows = []
      coord_table.each_with_index do |row, i|
        rows << row
        rows << :separator
      end

      rows.pop # delete last separator
      rows
    end

  end
end