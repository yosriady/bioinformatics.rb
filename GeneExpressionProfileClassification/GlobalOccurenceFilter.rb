require 'pry'
require 'csv'

# Given a global directory of .txt samples, should output genes that occur in ALL samples (occur_all_genes)
# Then, remove any genes not in occur_all_genes from all the samples

input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/testing/testset-txt-AMabscall-cleaned'
output_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/testing/testset-txt-fully-cleaned'

# First, collect counts of all genes across all samples
def count(dir)
  counts = {}
  num_samples = 0
  Dir.foreach(dir) do |file|
    next unless file.end_with? '.TXT'
    File.open("#{dir}/#{file}", 'r').each do |line|
      gene = line.split("\t")[0]
      if counts[gene].nil?
        counts[gene] = 1
      else
        counts[gene] += 1
      end
    end
    num_samples +=1
  end
  {counts: counts, num_samples: num_samples}
end

count_result = count(input_dir)
occur_all_genes = (count_result[:counts].select {|k,v| v == count_result[:num_samples]}).keys()

# Filter out genes not in occur_all_genes
def filter(input, output, occur_all_genes)
  line_num = 1
  File.open(output, 'w') do |output| # 'w' for a new file, 'a' append to existing
    File.open(input, 'r').each do |line|
      gene = line.split("\t")[0]
      is_occur_all_gene = occur_all_genes.include? gene
      if is_occur_all_gene
        output.write(line)
      end
      line_num += 1
    end
  end
end

def enumerate(input_dir, output_dir, occur_all_genes)
  Dir.foreach(input_dir) do |item|
    next unless item.end_with? '.TXT'
    input = "#{input_dir}/#{item}"
    output = "#{output_dir}/#{item}"
    filter(input, output, occur_all_genes)
  end
end

enumerate(input_dir, output_dir, occur_all_genes)

p 'Done!'