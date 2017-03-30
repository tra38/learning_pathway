require "csv"
require_relative "heuristic"

domain_order_csv = ARGV[0]
student_tests_csv = ARGV[1]

def validate_csv(csv)
  csv && csv.match(/.csv\z/)
end

if validate_csv(domain_order_csv) && validate_csv(student_tests_csv)
  domain_order = {}
  CSV.foreach(File.path(domain_order_csv)) do |row|
    grade = row[0]
    order = row[1..-1]
    domain_order[grade] = order
  end

  heuristics = Heuristic.new(domain_order)

  output_array = []

  CSV.foreach(File.path(student_tests_csv), headers: true) do |row|
    student_profile = heuristics.calculate(row)
    generated_row = [ student_profile[:name] ] + student_profile[:curriculum]
    output_array << generated_row
  end

  binding.pry
else
  puts "Usage: learning_pathways.rb DOMAIN_ORDER_CSV_PATH STUDENT_TEST_CSV_PATH"
end