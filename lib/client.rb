class Client
  attr_reader(:id, :name, :stylist_id)
  define_method(:initialize)do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      id = client.fetch("id").to_i()
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i()
      clients.push(Client.new({:id=>id, :name=>name, :stylist_id=>stylist_id}))
  end
  clients
end

define_method(:==) do |another_client|
  self.id().==(another_client.id()) &&
  self.name().==(another_client.name()) &&
  self.stylist_id().==(another_client.stylist_id)
end

define_method(:save) do
  result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}',#{@stylist_id}) RETURNING id;")
  @id = result.first().fetch("id").to_i()
end

define_singleton_method(:find) do |id|
  found_client = nil
  Client.all().each() do |client|
    if client.id().==(id)
      found_client = client
    end
  end
  found_client
end

define_method(:update) do |attributes|
  @name = attributes.fetch(:name, @name)
  @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
  @id = self.id()
  DB.exec("UPDATE clients SET name='#{@name}', stylist_id=#{@stylist_id} WHERE id=#{@id};")
end

define_method(:delete) do
  DB.exec("DELETE FROM clients where id=#{self.id};")
end

end