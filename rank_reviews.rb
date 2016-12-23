require 'typhoeus'
require 'nokogiri'

hydra = Typhoeus::Hydra.new
asins = ['B004D93QKA', 'B00X3S3FSK', 'B01H5R2NYG']
proxies = Typhoeus.get("http://www.sharedproxies.com/api.php?m=onpointadspace%40gmail.com&s=2984a2f217170d8ddbccaeefd938127266fae59e&do=getall").body.split()
requests = asins.map { |asin|
  options = { proxy: proxies.sample,
              followlocation: true,
              headers: {
                'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36'
              }
            }
  request = Typhoeus::Request.new("https://www.amazon.com/dp/"+asin, options)
  hydra.queue(request)
  request
}
hydra.run
responses = requests.map { |request|
  Nokogiri::HTML(request.response.body)
}
responses.each do |response|
  @avgCustomerReview = response.at('#reviewStarsLinkedCustomerReviews > i > span').text.split(' ')[0]
  @numReviews = response.at('#acrCustomerReviewText').text.split(' ')[0]
  @bestSellersRank = response.at('#productDetails_detailBullets_sections1 th:contains("Best Sellers Rank")').next_element.at('span span').text.split(' ')[0][1..-1]
  @category = response.at('#nav-subnav > a.nav-a.nav-b > span').text
  puts 'Avg Customer Review: ' + @avgCustomerReview
  puts 'Number of Reviews: ' + @numReviews
  puts 'Best Sellers Rank: ' + @bestSellersRank
  puts 'Category: ' + @category
end
