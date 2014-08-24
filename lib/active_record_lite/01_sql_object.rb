require_relative 'db_connection'
require 'active_support/inflector'
#NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
#    of this project. It was only a warm up.

class SQLObject
  
  def self.columns
    results = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
      "#{self.table_name}"
    SQL
    results.first.map{|x| x.to_sym}
  end

  def self.finalize!
    self.columns.each do |column|
      define_method column do
        self.attributes[column]
      end

      define_method "#{column}=" do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = "#{self.name}".tableize if @table_name.nil?
    @table_name
  end

  def self.all
  result = DBConnection.execute(<<-SQL )
          SELECT
            *
          FROM
          "#{self.table_name}"
        SQL
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id )
            SELECT
              *
            FROM
            "#{self.table_name}"
            WHERE
            "#{self.table_name}".id = ?
          SQL
  end

  def attributes
    @attributes ||= {}

  end

  def insert
    col_names = self.columns.join(",")
    question_marks = ["?"] * (col_names.count)
    DBConnection.execute(<<-SQL)
    INSERT INTO
      "#{self.table_name}"()
    VALUES

    SQL
  end

  def initialize(params)
    params.map{|x, y| x.to_sym}.each do |attr_name, value|
      if self.class.columns.include?(attr_name)
         raise "unknown attribute '#{attr_name}'"
      end
      @attr_name = value
    end
    # # attributes.each do |attr_name, value|
   #  if self.class.columns.include?(attr_name)
   #     raise "unknown attribute '#{attr_name}'"
   #  end
   #  params.each do |attr_name, value|
   #    @attr_name = value
   #  end
    
  
  end

  def save
    unless id.nil?
      insert
      update
    end
  end

  def update
    DBConnection.execute(<<-SQL)
    UPDATE
      "#{self.table_name}"()
    VALUES
    
    WHERE
    
    SQL
  end

  def attribute_values
    # ...
  end
end
