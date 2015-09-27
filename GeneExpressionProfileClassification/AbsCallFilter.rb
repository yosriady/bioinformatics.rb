require 'pry'
require 'csv'

# Given a directory of .txt samples, should filter out samples with A and M Abs Call

input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-affx-cleaned'
output_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-AMabscall-cleaned'

def filter(input, output)
  line_num = 1
  File.open(output, 'w') do |output| # 'w' for a new file, 'a' append to existing
    File.open(input, 'r').each do |line|
      row = CSV.parse_line(line, col_sep: "\t")
      abscall = row[5]
      is_absent_or_marginal = (abscall == 'A' || abscall == 'M')
      if !is_absent_or_marginal
        output.write(line)
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