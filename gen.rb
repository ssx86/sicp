chapter = ARGV[0]
id = ARGV[1]

dir_name = "chapter#{chapter}"
unless File.exist? dir_name
  Dir.mkdir dir_name
end

file_name = "#{dir_name}/#{chapter}.#{id}.rkt"
outfile=File.new(file_name,"w")
outfile.puts "#lang racket\n"
outfile.close
