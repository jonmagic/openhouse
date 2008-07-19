$:.unshift File.dirname(__FILE__) + '/sinatra/lib'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/openhouse.sqlite3")

get '/' do
  haml :index
end

post '/create' do
  @person = Person.new(:firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone], :email => params[:email], :address => params[:address], :city => params[:city], :state => params[:state], :zip => params[:zip])
  if @person.save
    redirect '/thankyou'
  else
    redirect '/'
  end
end

get "/thankyou" do
  haml :thankyou
end

get "/random" do
  @person = random_person
  haml :random
end

get "/all" do
  @people = Person.all
  haml :all
end

### HELPERS ###
def random_person
  count = Person.all.length
  number = rand(count) + 1
  person = Person[number]
  return person
end


### SETUP ###
class Person
  include DataMapper::Resource
  property :id,         Integer, :serial => true    # primary serial key
  property :firstname,  String
  property :lastname,  String
  property :phone,  String
  property :email,  String
  property :address,  String
  property :city,  String
  property :state,  String
  property :zip,  String
  property :created_at, DateTime
end

DataMapper.auto_upgrade!