require_relative "../config/environment.rb"

class Student 
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
     def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grades TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    
end

def save
    if self.id 
      self.update
    else
      sql = <<-SQL
      
end
end
