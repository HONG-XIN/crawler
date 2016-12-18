require 'typhoeus'
def log(*msg)
  puts msg[0]
  for i in 2..msg.length
    puts "  ->"+msg[i-1].to_s
  end
end
if __FILE__==$0
  begin
    puts "START program ["+__FILE__+"]...\n\n"
    ipify="https://api.ipify.org/?format=json"
    options={proxy:"https://108.177.254.136:8800"}
    log(ipify)
    request=Typhoeus::Request.new(ipify,options)
    request.run
    puts request.response.body



  rescue =>exception
    puts exception.class
    puts "ERROR"
  else
    puts "NO ERROR"
  ensure
    puts "\nEND program ["+__FILE__+"]"
  end
end
