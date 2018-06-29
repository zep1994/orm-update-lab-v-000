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
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL
      
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
      
    end
  end
  
  def self.create(name, grade)
      student = Student.new(name, grade)
      student.save
      student
  end
  
  def self.new_from_db(row)
   id = row[0]
   name = row[1]
   grade = row[2]
   student= self.new(id, name, grade)
   student
  end
  
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    Student.new(result[0], result[1], result[2])
  end
  
end
    
    def update
     sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
     DB[:conn].execute(sql, self.name, self.grade, self.id)
    end
