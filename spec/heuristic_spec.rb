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
      expect(@heuristic.all_grades).to eq({"K"=>0, "1"=>1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6})
    end

    it "generates a curriculum for Albin Stanton, a normal student with varying grade levels" do
      albin_stats = HeuristicHelper.profile(name: "Albin Stanton", rf: "2", rl: "3", ri: "K", l: "3")
      expect(@heuristic.calculate(albin_stats)).to eq({ name: "Albin Stanton", curriculum: ["K.RI","1.RI","2.RF","2.RI","3.RF"] })
    end

    it "generates a curriculum less than 5 classes for Makena Gray, a student who is currently at the 6th grade level" do
      makena_stats = HeuristicHelper.profile(name: "Makena Gray", rf: "6", rl: "6", ri: "6", l: "6")
      expect(@heuristic.calculate(makena_stats)).to eq({ name: "Makena Gray", curriculum: ["6.RI", "6.RL"] })
    end

    it "generates a generic curriculum for Noga Michi, a person who does not have any test scores" do
      noga_stats = HeuristicHelper.profile(name: "Noga Michi", rf: nil, rl: nil, ri: nil, l: nil)
      expect(@heuristic.calculate(noga_stats)).to eq({ name: "Noga Michi", curriculum: ["K.RF", "K.RL", "K.RI", "1.RF", "1.RL"] })
    end

    it "generates a curriculum for Alex Ainsley, a 3rd grade student who hasn't taken the L test" do
      alex_stats = HeuristicHelper.profile(name: "Alex Ainsley", rf: "3", rl: "3", ri: "3", l: nil)
      expect(@heuristic.calculate(alex_stats)).to eq({ name: "Alex Ainsley", curriculum: ["2.L", "3.RF", "3.RL", "3.RI", "3.L"] })
    end
  end
end