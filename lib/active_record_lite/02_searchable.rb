require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    params.each do |attr, value|
      DBConnection.execute(<<-SQL, attr, value)
      SELECT
        *
      FROM
        "#{self.table_name}"
      WHERE
        name = ? AND color = ?
      SQL
    end
  end
end

class SQLObject
  # Mixin Searchable here...
end
