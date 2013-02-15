# encoding: UTF-8
require 'fileutils'

SERIES_NAMES = ["Paypal", "Os bastidores do Rails 3", "A linguagem Python", "Entrevista com Cauê Guerra",
 "Introdução ao Arduíno", "Django", "Singularidade e Biologia Sintética", "Rework", "Node.js",
 "Sistemas de controle de versão", "Carreira na área de TI", "Tecnologia Microsoft",
 "Desenvolvimento de Games e Android", "Conquistando o Vale do Silício", "Erlang",
 "Desenvolvimento para iOS", "Repensando os bancos de dados", "Mobile Payments",
 "PHP: Hypertext Preprocessor", "Steve Jobs", "Arquitetura e Design de Software",
 "Agile na prática", "Conhecendo o Mono", "A linguagem Lua", "Computação Soberana",
 "RubyConf", "Front-end e Design", "A linguagem Scala", "Rails Core Team"]

files = Dir.glob("*.md")

files.each do |file_path|
  file = File.open(file_path)

  p "Opened #{file}"

  lines = file.readlines

  p lines[2]

  SERIES_NAMES.each do |serie_name|
    lines.insert(2, "serie: '#{serie_name}'\n") if lines[2].match(serie_name)
  end

  File.open(file_path, 'wb') { |f| f << lines.join }

  p "Writed file #{file_path}"
end