require "bunny"

conn = Bunny.new(:automatically_recover => false, hostname: "192.168.33.33")
conn.start

ch   = conn.create_channel
q    = ch.queue("hello")
begin 
  loop do
    ch.default_exchange.publish("Hello World! #{rand(0..10)}", :routing_key => q.name)
    puts " [x] Sent 'Hello World!'"
    sleep 10
  end
rescue Interrupt => exc
 # No-op
ensure
  conn.close
end