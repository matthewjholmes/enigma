require_relative 'enigma'

enigma = Enigma.new

first_file = File.open(ARGV[0], "r")

message = first_file.read.chomp

decrypted_message = enigma.decrypt(message)

second_file = File.open(ARGV[1], "w")

output_text = second_file.write(decrypted_message[:decryption])

puts "Created #{ARGV[1]} with the key #{decrypted_message[:key]} and value #{decrypted_message[:date]}"
