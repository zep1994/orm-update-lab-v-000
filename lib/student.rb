require_relative "../config/environment.rb"

class Student 
  attr_accessor :id, :name, :grade
  
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
    DB[:conn].execute(sql)
end

def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end
end
