class GdalJob < ActiveJob::Base
  queue_as :default

  def perform(*args)

    dataType = getData()

    if dataType

      system("cd ~/.gdal/#{dataType} && gdal_grid -zfield \"Data\" -a invdist:power=8:smoothing=0.3:nodata=-5000:radius1=0.1:radius2=0.1 -txe 24.40 25.40 -tye 60.700 59.700 -outsize 2000 2000 -of GTiff -ot Float64 -l dem dem.vrt dem.tiff --config GDAL_NUM_THREADS ALL_CPUS && gdaldem color-relief -alpha  dem.tiff colors.txt dem.tiff && gdal_translate -of PNG dem.tiff #{Rails.root.join('app','assets', 'images', 'data.png')} ")

    end

  end

  def getData()
    fbc = FirebaseClient.new

    layer = Layer.find_by name: 'Temperature temp1'

    if layer

    #hard coded, going to be replaced with database query to sensortype table
      dataType = "temperature"


      system("mkdir ~/.gdal/#{dataType}")
      system("cp ~/.gdal/dem.vrt ~/.gdal/#{dataType}")

      response = fbc.get('data', :orderBy => "sensor_type", :equalTo => dataType)
      FirebaseClient.shutdown

      #Empty old values from csv file
      system("echo 'Easting,Northing,Data' > ~/.gdal/#{dataType}/dem.csv")

      #Add values to csv file
      response.each { |value|
        #Check if datapoint is inside the specified boundaries
        if value[1]["l"][0] >  59.5 && value[1]["l"][0] < 60.5 && value[1]["l"][1] > 24.4 && value[1]["l"][1] < 25.4
         system("echo '#{value[1]["l"][1]}','#{value[1]["l"][0]}','#{value[1]["value"]}' >> ~/.gdal/#{dataType}/dem.csv")
        end
      }

      #Find the right color drops for layer to render
      drops = ColorDrop.where layer_id:layer.id

      #Empty old version of colors file
      system("echo '-5000 0,0,0,0' > ~/.gdal/#{dataType}/colors.txt")

      #Add new color drops to colors file
      drops.each { |value|
        system("echo '#{value.value} #{value.color}' >> ~/.gdal/#{dataType}/colors.txt")
      }
    end

    return dataType

  end


end