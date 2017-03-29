require 'smarter_csv'

domain_order_csv = ARGV[0]
student_tests_csv = ARGV[1]

def validate_csv(csv)
  csv && csv.match(/.csv\z/)
end

if validate_csv(domain_order_csv) && validate_csv(student_tests_csv)
  file = SmarterCSV.process(domain_order_csv)
  p file
else
  puts "Usage: learning_pathways.rb DOMAIN_ORDER_CSV_PATH STUDENT_TEST_CSV_PATH"
end