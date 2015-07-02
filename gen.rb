def create_file(file_name)
  outfile=File.new(file_name,"w")
  outfile.puts "#lang racket\n"
  outfile.close
end

def make_dir(chapter, id)
  dir_name = "chapter#{chapter}"
  unless File.exist? dir_name
    Dir.mkdir dir_name
  end

  file_name = "#{dir_name}/#{chapter}.#{id}.rkt"

  create_file file_name unless File.exist? file_name
end

@chapter_info = [
  {chapter: 1, max_id: 40},
  {chapter: 2, max_id: 97},
  {chapter: 3, max_id: 82},
  {chapter: 4, max_id: 79},
  {chapter: 5, max_id: 52}
]

@chapter_info.each do |info|
  chapter = info[:chapter]
  max_id = info[:max_id]
  (1..max_id).each do |id|
    make_dir chapter, id
  end
end
