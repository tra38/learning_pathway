class Heuristic
  attr_reader :domain_order, :all_subjects, :all_grades
  def initialize(domain_order)
    @domain_order = domain_order

    grades_array = domain_order.keys
    @all_grades = generate_ordered_hash(grades_array)
    @all_subjects  = generate_subjects_array(grades_array)
  end

  def calculate(student_row)

    student_name = student_row["Student Name"]

    curriculum_array = find_valid_classes(student_row)

    if curriculum_array.length > 5
      { name: student_name, curriculum: curriculum_array[0..4] }
    else
      { name: student_name, curriculum: curriculum_array }
    end
  end

  private

  def generate_subjects_array(grades_array)
    grades_array.map do |grade|
      subjects = domain_order[grade]
      subjects.map do |subject|
        { course_name: "#{grade}.#{subject}", grade: grade, subject_name: subject }
      end
    end.flatten
  end

  def find_valid_classes(student_row)
    reject_all_invalid_classes(student_row).map do |subject_hash|
      subject_hash[:course_name]
    end
  end

  def reject_all_invalid_classes(student_row)
    all_subjects.reject do |subject|
      subject_name = subject[:subject_name]
      subject_grade = subject[:grade]
      class_completed?(student_grade: student_row[subject_name], subject_grade: subject_grade)
    end
  end

  def generate_ordered_hash(keys)
    hash = Hash.new(0)
    keys.each_with_index do |key, value|
      hash[key] = value
    end
    hash
  end

  def class_completed?(student_grade:, subject_grade:)
    all_grades[student_grade] > all_grades[subject_grade]
  end

end