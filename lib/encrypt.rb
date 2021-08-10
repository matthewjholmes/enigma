require_relative 'enigma'

enigma = Enigma.new

first_file = File.open(ARGV[0], "r")

message = first_file.read.chomp

encrypted_message = enigma.encrypt(message)

second_file = File.open(ARGV[1], "w")

output_text = second_file.write(encrypted_message[:encryption])

puts "Created #{ARGV[1]} with the key #{encrypted_message[:key]} and value #{encrypted_message[:date]}"
