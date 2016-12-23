require 'typhoeus'
require 'nokogiri'
require 'json'
require 'oj'

if __FILE__==$0
  begin
    asin="B004D93QKA"

    puts "START program ["+__FILE__+"]...\n\n"
    Typhoeus::Config.user_agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0"
    link="https://sellercentral.amazon.com/fba/profitabilitycalculator/productmatches"
    main="https://sellercentral.amazon.com/hz/fba/profitabilitycalculator/index?lang=en_US"
    options1={proxy:"https://108.177.254.136:8800",cookiefile:"/home/hx/MyApp/cookie.txt",cookiejar:"/home/hx/MyApp/cookie.txt"}
    request=Typhoeus::Request.new(main,options1)
    request.run
    puts request.url
    doc=Nokogiri::HTML(request.response.body)
    profitcalcToken=doc.xpath("//input[contains(@name,'profitcalcToken')]/@value")
    puts profitcalcToken
    parameters={
      "searchKey":"B004D93QKA",
      "language":"en_US",
      "profitcalcToken":profitcalcToken.to_s
    }
    options={proxy:"https://108.177.254.136:8800",params:parameters,headers:{ContentType: "application/json"},method: :get,cookiefile:"/home/hx/MyApp/cookie.txt",cookiejar:"/home/hx/MyApp/cookie.txt"}
    request=Typhoeus::Request.new(link,options)
    request.run
    puts request.url
    body_data=request.response.body
    puts body_data
    data=JSON.parse(body_data)
    @asin=data['data'][0]['asin']
    @category=data['data'][0]['binding']
    @image=data['data'][0]['imageUrl']
    @title=data['data'][0]['title']
    @weight=data['data'][0]['weight']
    @length=data['data'][0]['length']
    @width=data['data'][0]['width']
    @height=data['data'][0]['height']
    @dimensionunit=data['data'][0]['dimensionUnit']
    @weightunit=data['data'][0]['weightUnit']
    puts @asin
    puts @category
    puts @title
    puts @weight
    puts @weightunit
    puts @length,@width,@height,@dimensionunit
    # block="https://sellercentral.amazon.com/fba/profitabilitycalculator/softblock"
    # parameters={
    #   "productAsin":"B004D93QKA",
    #   "language":"en_US",
    #   "profitcalcToken":profitcalcToken.to_s
    # }
    # options={proxy:"https://108.177.254.136:8800",params:parameters,headers:{ContentType: "application/json"},method: :get,cookiefile:"/home/hx/MyApp/cookie.txt",cookiejar:"/home/hx/MyApp/cookie.txt"}
    # request=Typhoeus::Request.new(block,options)
    # request.run
    # puts request.url
    # puts request.response.body
    parameters={
      "profitcalcToken":profitcalcToken.to_s
    }
    puts parameters
    fees="https://sellercentral.amazon.com/fba/profitabilitycalculator/getafnfee"
    copyied=
    {
      "productInfoMapping":{
        "asin":"B004D93QKA",
        "binding":"toy",
        "dimensionUnit":"inches",
        "dimensionUnitString":"inches",
        "encryptedMarketplaceId":"",
        "gl":"gl_toy",
        "height":8,
        "imageUrl":"https://images-na.ssl-images-amazon.com/images/I/51wc+ivzDnL._SCLZZZZZZZ__SL120_.jpg",
        "isAsinLimits":true,
        "isWhiteGloveRequired":false,
        "length":14.1,
        "link":"http://www.amazon.com/gp/product/B004D93QKA/ref=silver_xx_cont_revecalc",
        "originalUrl":"",
        "productGroup":"",
        "subCategory":"",
        "thumbStringUrl":"https://images-na.ssl-images-amazon.com/images/I/51wc+ivzDnL._SCLZZZZZZZ__SL80_.jpg",
        "title":"True Heroes Ultimate Military Playset- 100 piece set with storage container",
        "weight":2.7,
        "weightUnit":"pounds",
        "weightUnitString":"pounds",
        "width":9.5
      },
      "afnPriceStr":0,
      "mfnPriceStr":0,
      "mfnShippingPriceStr":0,
      "currency":"USD",
      "marketPlaceId":"ATVPDKIKX0DER",
      "hasFutureFee":true,
      "futureFeeDate":"2017-02-22 00:00:00",
      "hasTaxPage":true
    }
    # data['data'][0]
    bodys={
      "productInfoMapping":Oj.dump(copyied,mode: :compat),
      "afnPriceStr":0,
      "mfnPriceStr":0,
      "mfnShippingPriceStr":0,
      "currency":"USD",
      "marketPlaceId":"ATVPDKIKX0DER",
      "hasFutureFee":true,
      "futureFeeDate":"2017-02-22 00:00:00",
      "hasTaxPage":true
    }
    puts copyied
    options={
      proxy:"https://108.177.254.136:8800",
      params:parameters,
      # headers:{
      #   "content-type"=>"application/json;charset=UTF-8",
      #   Accept:"application/json, text/javascript, */*; q=0.01"
      # },
      method: :post,
      cookiefile:"/home/hx/MyApp/cookie.txt",
      cookiejar:"/home/hx/MyApp/cookie.txt",
      body:copyied
    }
    request=Typhoeus::Request.new(fees,options)
    request.run
    puts request.url

    puts request.response.code
    puts request.response.body

  rescue =>exception
    puts exception.class
    puts exception.backtrace
    puts "\nERROR"
  else
    puts "\nNO ERROR"
  ensure
    puts "\nEND program ["+__FILE__+"]"
  end
end
