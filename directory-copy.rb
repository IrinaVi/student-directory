def input_students
  puts "Please enter the name and cohort of the students"
  puts "To finish, just hit return twice"

  students = []
  name = gets.chomp.split(" ")
    
  while !name.empty? do
    students << {name: name[0], cohort: name[1]}
    if students.count == 1
      puts "Now we have #{students.count} student".center(20)
    else
      puts "Now we have #{students.count} students".center(20)
    end
    name = gets.chomp.split(" ")
  end
  students
end

# and then print them
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(names)
  if !names.empty?
    count = 0
    cohorts = []
    for name in names
      cohorts << name[:cohort]
    end
    cohorts.uniq!
    for cohort in cohorts
      names.each { |name, index| puts "#{name[:name]} (#{name[:cohort]} cohort)" if name[:cohort] == cohort}
    end
  else
    puts "No students recorded"
  end
end
# finally, we print the total
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)