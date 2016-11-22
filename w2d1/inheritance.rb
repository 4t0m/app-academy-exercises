class Employee
  attr_reader :salary

  def initialize(salary)
    @salary = salary
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :subordinates

  def initialize(salary)
    super
    @subordinates = []
  end

  def bonus(multiplier)
    total = all_subordinates.inject(0) { |acc, emp| acc + emp.salary }
    total * multiplier
  end

  def all_subordinates
    all_subs = []
    @subordinates.each do |employee|
      all_subs += employee.all_subordinates if employee.is_a? Manager

      all_subs << employee
    end
    all_subs
  end
end

ned = Manager.new(1_000_000)
darren = Manager.new(78000)
shawna = Employee.new(12000)
david = Employee.new(10000)
darren.subordinates << shawna
darren.subordinates << david
ned.subordinates << darren

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
