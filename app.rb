require('sinatra')
  require('sinatra/reloader')
  require('./lib/client')
  require('./lib/stylist')
  also_reload('lib/**/*.rb')
  require("pg")

  DB = PG.connect({:dbname => "hair_salon_2"})


  get("/") do
    @stylists = Stylist.all()
    
    erb(:index)
  end

  get("/stylists/new") do
    erb(:stylist_form)
  end

  post("/") do
    name = params.fetch("name")
    stylist = Stylist.new({:name => name, :id => nil})
    stylist.save()
    @stylists = Stylist.all()
    erb(:index)
   end

  get("/stylists/:id") do
    @stylist = Stylist.find(params.fetch("id").to_i())
    erb(:stylist)
  end

  post("/stylist") do
    name = params.fetch("name")
    stylist_id = params.fetch("stylist_id").to_i()
    @stylist = Stylist.find(stylist_id)
    @client = Client.new({:name => name, :stylist_id => stylist_id})
    @client.save()
    erb(:stylist)
  end

  get("/stylists/:id/edit") do
    @stylist = Stylist.find(params.fetch("id").to_i())
    erb(:stylist_edit)
  end

  patch("/stylist/:id") do
    name = params.fetch("name")
    @stylist = Stylist.find(params.fetch("id").to_i())
    @stylist.update({:name => name})
    erb(:stylist)
  end
