require 'typhoeus'
require 'nokogiri'
def log(*msg)
  puts msg[0]
  for i in 2..msg.length
    puts "  ->"+msg[i-1].to_s
  end
end
if __FILE__==$0
  begin
    puts "START program ["+__FILE__+"]...\n\n"
    sessionId="159-2084305-1464326"
    sessionId="111-1111111-1111111"
    for i in 0..10
      sessionId = rand.to_s[2..4] + '-' + rand.to_s[4..10] + '-' + rand.to_s[10..16]
      puts sessionId
      parameters={
        "OfferListingId.1":"kI%2BCWTuDbju6loQB7O0cPaLm4pL6p5CzkkciQKjP0sNPDA%2BPJdVufCkKwOOw3bfIbKDPxVrPBuMORdlKlcgINvPPmoMccrGbhcsYFKx7k4uN3Qz5L02YZtIEMa2X6EFJBbBNn%2F%2FPIlAtJmju2EUw%2FQ%3D%3D",
        "Quantity.1":"999",
        "SessionId":sessionId,
        "confirmPage":"confirm",
        "add.x":"55",
        "add.y":"9"
      }

      ipify="https://api.ipify.org/?format=json"
      options={proxy:"https://108.177.254.136:8800",params:parameters}
      Typhoeus::Config.user_agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0"
      # log(ipify)
      # request=Typhoeus::Request.new(ipify,options)
      # request.run
      # puts request.response.body

      works="https://www.amazon.com/gp/aws/cart/add.html"
      request=Typhoeus::Request.new(works,options)
      request.run
      # puts request.response.body
      puts request.url
      doc=Nokogiri::HTML(request.response.body)
      puts "Get result..."
      puts doc.xpath('//input[@name="quantityBox"]/@value')
      puts "Finish Get"
    end
  rescue =>exception
    puts exception.class
    puts exception.backtrace
    puts "ERROR"
  else
    puts "NO ERROR"
  ensure
    puts "\nEND program ["+__FILE__+"]"
  end
end
