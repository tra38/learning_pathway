require "./heuristic"
require 'heuristic_helper'

RSpec.describe Heuristic do
  context "creates a heuristic based on domain order" do
    before(:all) do
      domain_order = {"K"=>["RF", "RL", "RI"], "1"=>["RF", "RL", "RI"], "2"=>["RF", "RI", "RL", "L"], "3"=>["RF", "RL", "RI", "L"], "4"=>["RI", "RL", "L"], "5"=>["RI", "RL", "L"], "6"=>["RI", "RL"]}
      @heuristic = Heuristic.new(domain_order)
    end

    it "determines the list of subjects that a person can take" do
      expect(@heuristic.all_subjects).to eq(
        [{:course_name=>"K.RF", :grade=>"K", :subject_name=>"RF"},
         {:course_name=>"K.RL", :grade=>"K", :subject_name=>"RL"},
         {:course_name=>"K.RI", :grade=>"K", :subject_name=>"RI"},
         {:course_name=>"1.RF", :grade=>"1", :subject_name=>"RF"},
         {:course_name=>"1.RL", :grade=>"1", :subject_name=>"RL"},
         {:course_name=>"1.RI", :grade=>"1", :subject_name=>"RI"},
         {:course_name=>"2.RF", :grade=>"2", :subject_name=>"RF"},
         {:course_name=>"2.RI", :grade=>"2", :subject_name=>"RI"},
         {:course_name=>"2.RL", :grade=>"2", :subject_name=>"RL"},
         {:course_name=>"2.L", :grade=>"2", :subject_name=>"L"},
         {:course_name=>"3.RF", :grade=>"3", :subject_name=>"RF"},
         {:course_name=>"3.RL", :grade=>"3", :subject_name=>"RL"},
         {:course_name=>"3.RI", :grade=>"3", :subject_name=>"RI"},
         {:course_name=>"3.L", :grade=>"3", :subject_name=>"L"},
         {:course_name=>"4.RI", :grade=>"4", :subject_name=>"RI"},
         {:course_name=>"4.RL", :grade=>"4", :subject_name=>"RL"},
         {:course_name=>"4.L", :grade=>"4", :subject_name=>"L"},
         {:course_name=>"5.RI", :grade=>"5", :subject_name=>"RI"},
         {:course_name=>"5.RL", :grade=>"5", :subject_name=>"RL"},
         {:course_name=>"5.L", :grade=>"5", :subject_name=>"L"},
         {:course_name=>"6.RI", :grade=>"6", :subject_name=>"RI"},
         {:course_name=>"6.RL", :grade=>"6", :subject_name=>"RL"}]
         )
    end

    it "determines the grade order of this school" do
      expect(@heuristic.all_grades).to eq(["K", "1", "2", "3", "4", "5", "6"])
    end

    it "generates correct ordering for Albin Stanton" do
      albin_stats = HeuristicHelper.profile(name: "Albin Stanton", rf: "2", rl: "3", ri: "K", l: "3")
      expect(@heuristic.calculate(albin_stats)).to eq({ name: "Albin Stanton", curriculum: ["K.RI","1.RI","2.RF","2.RI","3.RF"] })
    end
  end
end

# 1) Read domain_order.csv to generate a heuristic
# 2) Use the heuristic to order students' curriculums
# 3) Output this curriculum into a CSV.