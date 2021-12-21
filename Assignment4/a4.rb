#filtering by evalue as in https://academic.oup.com/bioinformatics/article/24/3/319/252715

require 'bio'

#function definition
def perform_blast(db, seq, filter)
    if db.nil? || seq.nil?
        return nil
    end
    result = db.query(seq)  
    unless result.hits[0].nil? 
        if result.hits[0].evalue <= filter
            best = result.hits[0].definition.match(/^([^|]+)|/)
            return "#{best}"
        end
    else
        return nil
     end
end

def detect_type(fasta_file)
    i = 0
    fasta_file.each_entry do |entry|
        break if i > 0
        i =i + 1
        s_class = Bio::Sequence.auto(entry.seq).seq.class
        if s_class == Bio::Sequence::AA
            return "prot"
        elsif s_class == Bio::Sequence::NA
            return "nucl"
        else
            puts "Error. Sequence type could not be found. Please check input fasta files."
            exit(1)

        end
    end
end


#arguments handling

if ARGV.length >= 3 && ARGV.length <5 
    if File.size(ARGV[0]) < File.size(ARGV[1])
        in_file1 = ARGV[0]
        in_file2 = ARGV[1]
    else
        in_file1 = ARGV[1]
        in_file2 = ARGV[0]
    end
    score_filter = 1e-6
elsif ARGV.length == 4
    score_filter = ARGV[3]
    begin 
        score_filter = score_filter.to_f
    rescue
        puts "Please enter a valid filtering value."
        puts "main.rb file_species1.fa file_species2.fa outputfile.txt ([evalue filter])"
        exit(1)
    end
else
    puts "Enter valid number of arguments."
    puts "main.rb file_species1.fa file_species2.fa outputfile.txt ([evalue filter])"
    exit(1)
end

output_path = ARGV[2]

#check fasta files
file1 = Bio::FlatFile.auto(in_file1)
file2 = Bio::FlatFile.auto(in_file2)

if file1.autodetect == Bio::FastaFormat && file2.autodetect == Bio::FastaFormat
    "Corrent arguments. Searching  for orthologes..."
else
    puts "Please enter files in fasta format."
    puts "main.rb file_species1.fa file_species2.fa outputfile.txt ([evalue filter])"
    exit(1)
end

#fasta files entry class (prot or nucl)

#make databases
type1 = detect_type(file1)
type2 = detect_type(file2)

system("makeblastdb -in #{in_file1} -dbtype #{type1} -out ./dbs/#{in_file1[0..-4]+"DB"}")
system("makeblastdb -in #{in_file2} -dbtype #{type2} -out ./dbs/#{in_file2[0..-4]+"DB"}")
#select type of blast to perform


if type1 == "nucl" && type2 == "nucl"
    blast_type = ["blastn", "blastn"]
elsif type1 == "prot" && type2 == "prot"
    blast_type = ["blastp", "blastp"]
elsif type1 == "prot" && type2 == "nucl"
    blast_type = ["blastx", "tblastn"]
else
    blast_type = ["tblastn", "blastx"]
end

blast_db1 = Bio::Blast.local(blast_type[0], "./dbs/#{in_file1[0..-4]+"DB"}")
blast_db2 = Bio::Blast.local(blast_type[1], "./dbs/#{in_file2[0..-4]+"DB"}")

total = 0 
file1.each_entry do |entry|
    total = total + 1
end
file1.rewind()

file2_seq = Hash.new
file2.each_entry do |entry|
    file2_seq[entry.entry_id] = entry.seq
end
file2.rewind()

out_file = File.open(output_path, "w")
out_file.puts "#{in_file1[0..-4]}\t#{in_file2[0..-4]}"
out_file.close()
c = 0
i = 0
file1.each_entry do |entry|
    i = i + 1
    
    puts "Searching for gene #{entry.entry_id} (#{i}/#{total})..."
    best_1 = perform_blast(blast_db2, entry.seq, score_filter)
    next if best_1.nil?
   
    best_2 = perform_blast(blast_db1, file2_seq[best_1.strip], score_filter)
    next if best_2.nil?
    
    print entry.entry_id + best_2 + best_1 + "\n"
    if entry.entry_id == best_2.strip
        out_file = File.open(output_path, "a")
        out_file.puts "#{entry.entry_id}\t#{best_1}"
        out_file.close()
        puts "Found ortholog: #{entry.entry_id}, #{best_1}"
        
        c = c + 1
    end

end

puts "Finished. Found #{c} orthologes."