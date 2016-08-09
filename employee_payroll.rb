class Employee
	attr_reader :name, :email
	def initizlize name, email
		@name = name
		@email = email
	end
end

class HourlyEmployee < Employee
    def initialize(name, email, hourly_rate, hours_worked)
        @name = name
        @email = email
        @hourly_rate = hourly_rate
        @hours_worked = hours_worked
    end

    def calculate_salary
    	hourly_payment = (@hourly_rate * @hours_worked).round(2)
    end
end

class SalaryEmployee < Employee
    def initialize(name, email, salary)
        @name = name
        @email = email
        @salary = salary
    end

    def calculate_salary
   		daily_payment = (@salary / 52.0).round(2)  	
    end
end

class MultiPaymentEmployee < SalaryEmployee
    def initialize(name, email, salary, hourly_rate, hours_worked)
        @name = name
        @email = email
        @salary = salary 
        @hourly_rate = hourly_rate 
        @hours_worked = hours_worked 
    end

    def calculate_salary
    	weekly_hours_extra = 0
    	base_hours = 40
    	weekly_base_payment = @salary / 52.0 

    	weekly_hours_extra = @hours_worked - base_hours 

    	if  weekly_hours_extra > 0
    		weekly_hours_extra_payment = weekly_hours_extra * @hourly_rate
    	end

    	weekly_payment = (weekly_base_payment + weekly_hours_extra_payment).round(2)
    end
end	

class Payroll
    def initialize employees
        @employees = employees
    end

  def pay_employees
      # Should output how much we're paying each employee for this week and the total amount spent on payroll this week.
      @employees.reduce(0) do |total_weekly_salary, employee|
      	weekly_salary = employee.calculate_salary
      	puts weekly_salary
      	total_weekly_salary += weekly_salary + (weekly_salary * 0.18)
      	total_weekly_salary.round(2)
      end
  end
end

josh = HourlyEmployee.new 'Josh', 'nachoemail@example.com', 35, 50
#puts josh.calculate_salary

nizar = SalaryEmployee.new 'Nizar', 'starcraftrulez@gmail.com', 1000000
#puts nizar.calculate_salary

ted = MultiPaymentEmployee.new 'Ted', 'fortranr0x@gmail.com', 60000, 275, 55
#puts ted.calculate_salary

employees = [josh, nizar, ted]

pay = Payroll.new employees
puts pay.pay_employees