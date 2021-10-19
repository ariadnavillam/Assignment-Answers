class SeedStock
    #initialize properties for seedstock object based on the fields of the tsv file
    attr_accessor :Seed_Stock
    attr_accessor :Mutant_Gene_ID
    attr_accessor :Last_Planted
    attr_accessor :Storage
    attr_accessor :Grams_Remaining


    def initialize (params = {})
        @Seed_Stock = params.fetch(:Seed_Stock, "AX000000") 
        @Mutant_Gene_ID = params.fetch(:Mutant_Gene_ID, "X000")
        @Last_Planted = params.fetch(:Last_Planted, "DD/MM/YYYY")
        @Storage = params.fetch(:Storage, "camaX")
        @Grams_Remaining = params.fetch(:Grams_Remaining, "X").to_i
    end

    def plant(grams=7)
        #function to plant 7 grams of each seed 
        new_grams = @Grams_Remaining - grams
        if new_grams > 0
            @Grams_Remaining = new_grams
        
        else
            #if the grams remaining is less than the grams we want to plant, the seeds left are set to 0 and a warning message is printed
            @Grams_Remaining = 0
            puts "WARNING! We have run out of Seed Stock #{@Seed_Stock}."
         end
    end

    def get_gene
        return @Mutant_Gene_ID 
    end
    
    def get_seed
        return @Seed_Stock
    end

    def get_all #this methos puts each of the properties of each object 
        all = Array.new
        instance_variables.map do |ivar| 
            all.push(instance_variable_get ivar)
        end
        line = all.join("\t")
        return line
    end
        

end
