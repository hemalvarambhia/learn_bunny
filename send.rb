require "bunny"

conn = Bunny.new(
  automatically_recover: false, 
  hostname: "192.168.33.33", 
  user: 'a_publisher',
  password: 'publisher'
)
conn.start

ch   = conn.create_channel
q    = ch.queue("hello")
exchange = ch.default_exchange
begin 
  loop do
    message = "Hello World! #{rand(0..10)}"
    exchange.publish(message, :routing_key => q.name)
    puts "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}] Sent #{message}"
    sleep 4
  end
rescue Interrupt => exc
  # No op
ensure
  conn.close
end