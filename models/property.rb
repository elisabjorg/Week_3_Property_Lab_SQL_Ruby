require('pg')

class Property

  attr_reader :id
  attr_accessor :address, :value, :number_of_bedrooms, :year_built

  def initialize (details)
    @id = details['id'].to_i if details['id']
    @address = details['address']
    @value = details['value'].to_i
    @number_of_bedrooms = details['number_of_bedrooms'].to_i
    @year_built = details['year_built'].to_i
  end


  def save
    db = PG.connect ( {dbname: 'estate_agency', host: 'localhost'})
    sql = "INSERT INTO estate_agency (
      address,
      value,
      number_of_bedrooms,
      year_built
    ) VALUES (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@address, @value, @number_of_bedrooms, @year_built]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end


  def update
    db = PG.connect ( {dbname: 'estate_agency', host: 'localhost'})
    sql = "UPDATE estate_agency SET
    ( address,
      value,
      number_of_bedrooms,
      year_built
    ) = (
      $1, $2, $3, $4
    )
    WHERE id = $5
    "
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect ( {dbname: 'estate_agency', host: 'localhost'})
    sql = "DELETE FROM estate_agency"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  def delete()
    db = PG.connect ( {dbname: 'estate_agency', host: 'localhost'})
    sql = "DELETE FROM estate_agency WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def Property.find(id)
    db = PG.connect ( {dbname: 'estate_agency', host: 'localhost'})
    sql = "SELECT * FROM estate_agency WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    results_array = db.exec_prepared("find", values)
    db.close()
    property_hash = results_array[0]
    found_property = Property.new(property_hash)
    return found_property
  end












end
