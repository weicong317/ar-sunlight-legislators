require 'csv'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      Legislator.create(title: row[0], firstname: row[1], middlename: row[2], lastname: row[3], name_suffix: row[4], nickname: row[5], party: row[6], state: row[7], district: row[8], in_office: row[9], gender: row[10], phone: row[11], fax: row[12], website: row[13], webform: row[14], congress_office: row[15], bioguide_id: row[16], votesmart_id: row[17], fec_id: row[18], govtrack_id: row[19], crp_id: row[20], twitter_id: row[21], congresspedia_url: row[22], youtube_url: row[23], facebook_id: row[24], official_rss: row[25], senate_class: row[26], birthdate: row[27])
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
