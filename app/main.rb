require_relative "../db/config"
require "byebug"

input = ARGV

command = input[0]
value = input[1]

def state(value)
	puts "Senators:"
	x = Legislator.select(:firstname, :middlename, :lastname, :party).order(:lastname).order(:lastname).where("title = 'Sen' AND state = ?", value)
	x.each do |row|
		if row.middlename === ""
			puts "    #{row.firstname} #{row.lastname} (#{row.party})"
		else
			puts "    #{row.firstname} #{row.middlename} #{row.lastname} (#{row.party})"
		end
	end

	puts "Representatives:"
	x = Legislator.select(:firstname, :middlename, :lastname, :party).order(:lastname).order(:lastname).where("title = 'Rep' AND state = ?", value)
	x.each do |row|
		if row.middlename === ""
			puts "    #{row.firstname} #{row.lastname} (#{row.party})"
		else
			puts "    #{row.firstname} #{row.middlename} #{row.lastname} (#{row.party})"
		end
	end
end

def gender(value)
	total_value_sen = Legislator.all.where("title = ? AND gender = ?", "Sen", value).count
	total_value_rep = Legislator.all.where("title = ? AND gender = ?", "Rep", value).count
	total_sen = Legislator.all.where(title: "Sen").count
	total_rep = Legislator.all.where(title: "Rep").count
	if value === "M"
		puts "Male Senators: #{total_value_sen} (#{(total_value_sen.to_f/total_sen.to_f).round(4)*100}%)"
		puts "Male Representatives: #{total_value_rep} (#{(total_value_rep.to_f/total_rep.to_f).round(4)*100}%)"
	else
		puts "Female Senators: #{total_value_sen} (#{(total_value_sen.to_f/total_sen.to_f).round(4)*100}%)"
		puts "Female Representatives: #{total_value_rep} (#{(total_value_rep.to_f/total_rep.to_f).round(4)*100}%)"
	end
end

def list_state
	x = Legislator.select(:title).group(:state).count
	x = x.sort_by {|_key, value| value}.reverse.to_h
	total_sen = Legislator.all.where(title: "Sen").group(:state).count
	total_rep = Legislator.all.where(title: "Rep").group(:state).count
	x.each do |x|
		if total_sen[x[0]].to_i != 0
			puts "#{x[0]}: #{total_sen[x[0]]} Senators, #{total_rep[x[0]]} Representative(s)"
		end
	end
end

def total
	total_sen = Legislator.all.where(title: "Sen").count
	total_rep = Legislator.all.where(title: "Rep").count
	puts "Senators: #{total_sen}"
	puts "Representatives: #{total_rep}"
end

x = Legislator.where(in_office: 0)
x.delete_all

case command
when "state"
	state(value)
when "gender"
	gender(value)
when "list"
	list_state
when "total"
	total
else
	p "Wrong command"
end