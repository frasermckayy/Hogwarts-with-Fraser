require_relative('../db/sql_runner')

class Student

    attr_reader :id, :first_name, :last_name, :house, :age

    def initialize(options)
        @id = options["id"].to_i
        @first_name = options["first_name"]
        @last_name = options["last_name"]
        @house = options["house"]
        @age = options["age"].to_i
    end

    def full_name()
        return "#{@first_name} #{@last_name}"
    end

    def save()
        sql = "INSERT INTO students
         (first_name, last_name, house, age)
          VALUES
           ($1, $2, $3, $4) 
            RETURNING *"
        values = [@first_name, @last_name, @house, @age]
        student_info = SqlRunner.run(sql, values)
        @id = student_info.first()["id"].to_i
    end
end