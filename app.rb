require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: 'pizzashop.db' }

class Product < ActiveRecord::Base
end

class Client < ActiveRecord::Base
end


get '/' do
	@products = Product.all
	erb :index			
end

# =============================================
# обработчик кнопки заказа и перехода к подтверждению
# =============================================
post '/cart' do
  @c = Client.new

  # "product_1=4,product_2=7,product_3=0," Ноль приходдит изза кнопки уменьшения на главной, видимо нужно исправить в функции уменьшения на локалсторедж. Покачто исправляем только в выводе(select{|k, v| v > 0})

	@order_code = params[:orders] # "product_1=4,product_2=7,product_3=4,"
	#"product_1=4,product_2=7,product_3=4," => [["1", "4"], ["2", "7"], ["3", "4"]]
	order_list = params[:orders].split(',').map{|prod| prod.split('=')}.map{|a| [a[0][-1], a[1]]}
	# => {obj1 => 4, ...} тоесть хэш где ключ сущность а значение число заказов на нее
	@order_list = order_list.map{|k, v| [Product.find(k.to_i), v.to_i]}.to_h.select{|k, v| v > 0}
	erb :cart
end

# =============================================
# обработчик подтверждения заказа и занесения в бд
# =============================================
post '/order' do
	@c = Client.new params[:client]

	# Добавить валидацию

	@c.save
	erb "<p>Thank you!</p>"
end



# =============================================
# временные конструкции(отображение страницы /cart по ссылке)
# =============================================
class Some
	attr_reader :title, :path_to_image, :size, :price
	def initialize
		@title = 'pizza'
		@path_to_image = '/images/Peperroni.jpg'
		@size, @price = 20, 200
	end
end
get '/cart' do
  @c = Client.new
	@order_code = 'aaaa'
	@order_list = {Some.new => 1, Some.new => 2}
	erb :cart
end