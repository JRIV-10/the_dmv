class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end
 
  def register_vehicle(vehicle)
    if services.include?('Vehicle Registration')
      create_plate(vehicle)
      register_fee(vehicle)
      vehicle.registration_date = Date.today
      @registered_vehicles << vehicle 
    else 
      nil 
    end  
  end 

  def register_fee(vehicle)
    if vehicle.plate_type == :antique 
      @collected_fees += 25
    elsif vehicle.plate_type == :ev 
      @collected_fees += 200 
    else 
      @collected_fees += 100
    end 
  end

  def create_plate(vehicle)
      if vehicle.antique? 
        vehicle.plate_type = :antique
      elsif vehicle.electric_vehicle?
        vehicle.plate_type = :ev
      else 
        vehicle.plate_type = :regular
      end 
      vehicle.plate_type
  end 

  def administer_written_test(registrant) 
    services.include?("Written Test") &&
    registrant.age >= 16 && 
    registrant.permit? &&
    (registrant.license_data[:written] = true) 
  end 

  def administer_road_test(registrant)
    services.include?("Road Test") && 
    registrant.license_data[:written] &&
    (registrant.license_data[:license] = true)
  end 

  def renew_drivers_license(registrant) 
    services.include?("Renew License") && 
    registrant.license_data[:license] &&
    (registrant.license_data[:license] = true)
  end 
end
