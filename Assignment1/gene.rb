class Gene
    #initialize properties for gene object based on the fields of the tsv file
    attr_accessor :Gene_ID
    attr_accessor :Gene_name
    attr_accessor :mutant_phenotype
    attr_accessor :linked_genes

    def initialize (params = {})
        #test if the gene id is correct
        gene_id = params.fetch(:Gene_ID, "AT00000000")
            unless gene_id.match(/A[Tt]\d[Gg]\d\d\d\d\d/)
                puts "Error. Wrong gene ID #{gene_id}."
                puts 'Gene ID for Arabidopsis Thaliana have the format: AT1G69120.'
                exit(1)
            else 
                #initialize the variables
                @Gene_ID = params.fetch(:Gene_ID, "AT00000000")
                @Gene_name = params.fetch(:Gene_name, "nameX")
                @mutant_phenotype = params.fetch(:mutant_phenotype, "phenotype")
                @linked_genes = Array.new
            end
        
    end

    def get_name
        return @Gene_name
    end

    def is_linked(linked_gene)
        #method to save a linked gene if it exists as a Gene
        if linked_gene.is_a?(Gene)
            @linked_genes.push(linked_gene)
        else 
            puts "Error. Enter a correct Gene ID."
        end
    end

    def check_linked_genes
        #print all linked genes if there is any.
        unless @linked_genes.length == 0
            @linked_genes.each do |gene|
                puts "#{@Gene_name} is linked to #{gene.get_name}."
            end
        end

    end


end

