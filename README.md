# learning_pathway.rb

```learning_pathway.rb``` is a program that will create customized learning pathways for students.

## Install
```git clone``` the repo onto your local machine. Then ```bundle install```.

## Usage

```ruby path/to/learning_pathway.rb path/to/domain_order.csv path/to/student_tests.csv```

The file ```pathways.csv``` will be generated in the same folder and ```learning_pathway.rb```. ```pathways.csv``` will decide students' future curriculum, based on their test scores and the current "domain order".

## Automated Tests
Go into the directory of ```learning_pathway.rb``` and then type ```rspec```.