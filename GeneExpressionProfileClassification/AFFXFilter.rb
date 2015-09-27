require 'pry'

# Given a directory of .txt samples, should filters out AFFX control genes from all samples

input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt'
output_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-affx-cleaned'

def filter(input, output)
  line_num = 1
  File.open(output, 'w') do |output| # 'w' for a new file, 'a' append to existing
    File.open(input, 'r').each do |line|
      if line_num > 4
        is_control_gene = line.start_with?('AFFX')
        if !is_control_gene
          output.write(line)
        end
      end
      line_num += 1
    end
  end
end

def enumerate(input_dir, output_dir)
  Dir.foreach(input_dir) do |item|
    next unless item.end_with? '.TXT'
    input = "#{input_dir}/#{item}"
    output = "#{output_dir}/#{item}"
    filter(input, output)
  end
end

enumerate(input_dir, output_dir)
p 'Done!'