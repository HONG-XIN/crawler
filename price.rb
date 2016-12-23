require 'typhoeus'
require 'nokogiri'

if __FILE__==$0
  begin
    puts "START program ["+__FILE__+"]...\n\n"
    Typhoeus::Config.user_agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0"
    page=1
    count=10
    asin="B004D93QKA"
    seller="Kingtoys"
    while count==10 do
      parameters={
        "o":"New",
        "op":page.to_s
      }
      options={proxy:"https://108.177.254.136:8800",params:parameters}
      listing="https://www.amazon.com/gp/aw/ol/"+asin
      # puts listing
      request=Typhoeus::Request.new(listing,options)
      request.run
      puts request.url
      # puts request.response.body
      doc=Nokogiri::HTML(request.response.body)
      prices=doc.xpath("//a[contains(@href,'eid')]/text()")
      puts prices
      count=prices.length
      price=doc.xpath("//b[contains(text(),'"+seller+"')]/following-sibling::a[contains(@href,'eid')]/text()")[0]
      puts "////////////"+price.to_s
      puts price.to_s==""
      page+=1
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
