class Crud
  #--create--
  def initialize attributes
    attributes.each do |key, value|
      self.instance_variable_set('@'+key.to_s, value)
    end
  end

  def save
    columns = self.instance_variables
    DB.exec("ALTER TABLE #{self.class.to_s.downcase + 's'} ADD crap varchar;")
    current_stuff = DB.exec("INSERT INTO #{self.class.to_s.downcase + 's'} (crap) VALUES ('whatever') RETURNING id;")
    DB.exec("ALTER TABLE #{self.class.to_s.downcase + 's'} DROP crap;")
    current_id = @id = current_stuff.first['id'].to_i
    columns.each do |column|
      DB.exec("UPDATE #{self.class.to_s.downcase + 's'}
               SET (#{column.to_s.gsub(/['@']/, '')}) = ('#{instance_variable_get(column)}')
               WHERE id = #{current_id};")
    end
  end

  #--read--
  def read(column, search_term)
    query_result = []
    results = DB.exec("SELECT * FROM #{self.class.to_s.downcase + 's'} WHERE #{column} = '#{search_term}'")
    results.each do |result|
      query_result << self.class.new(result)
    end
    query_result
  end

  #--update--
  def update column, new_data
    DB.exec("UPDATE #{self.class.to_s.downcase + 's'} SET #{column} = '#{new_data}' WHERE id = '#{@id}';")
    self.instance_variable_set('@'+column, new_data)
  end

  #--destroy--
  def delete
    DB.exec("DELETE FROM #{self.class.to_s.downcase + 's'} WHERE id = '#{@id}';")
  end


end

