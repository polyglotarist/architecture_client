class Building 
  attr_reader :name, :address, :height, :construction_date, :architect, :id

  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @address = input_options["address"]
    @height = input_options["height"]
    @construction_date = input_options["construction_date"]
    @architect = input_options["architect"]
  end
  
  def self.find(input_id)
    @input_id = input_id
    response = HTTP.get("http://localhost:3000/api/buildings/#{ input_id }") 
   
    building_data = response.parse
    Building.new(building_data)
  end

  def self.all
    response = HTTP.get("http://localhost:3000/api/buildings")
    all_building_data = response.parse

    all_building_data.each do |building_data|
      Building.new(building_data)
    end 
  end

  def self.create(new_building)
    response = HTTP.post(
                         "http://localhost:3000/api/buildings", 
                         form: new_building
                        )
    new_building_data = response.parse
    Building.new(new_building_data)
  end

  def update(updated_info)
    response = HTTP.patch(
                          "http://localhost:3000/api/buildings/#{ self.id }",
                          form: updated_info
                           )    
  end

  def destroy
    HTTP.delete("http://localhost:3000/api/buildings/#{ self.id }")
  end
end