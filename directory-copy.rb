@students = []

def input_students
  puts "Please enter the name and cohort of the students"
  puts "To finish, just hit return twice"

  name = STDIN.gets.chomp.split(" ")
    
  while !name.empty? do
    @students << {name: name[0], cohort: name[1]}
    if @students.count == 1
      puts "Now we have #{@students.count} student".center(20)
    else
      puts "Now we have #{@students.count} students".center(20)
    end
    name = gets.chomp.split(" ")
  end
  @students
end

# and then print them
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  if !@students.empty?
    cohorts = []
    for name in @students
      cohorts << name[:cohort]
    end
    cohorts.uniq!
    for cohort in cohorts
      @students.each { |name, index| puts "#{name[:name]} (#{name[:cohort]} cohort)" if name[:cohort] == cohort}
    end
  else
    puts "No students recorded"
  end
end
# finally, we print the total
def print_footer()
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  file = File.open("students.csv", "w")

  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first 
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def process(selection)
  case selection
    when "1"
      students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students()
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu