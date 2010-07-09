require 'rubygems'
require 'sinatra'
require 'mongo_mapper'

MongoMapper.database = "openhouse"

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
  people = Person.all
  number = rand(people.length)
  person = people[number]
  return person
end


### SETUP ###
class Person
  include MongoMapper::Document
  
  key :firstname, String
  key :lastname,  String
  key :phone,     String
  key :email,     String
  key :address,   String
  key :city,      String
  key :state,     String
  key :zip,       String
  timestamps!
end
