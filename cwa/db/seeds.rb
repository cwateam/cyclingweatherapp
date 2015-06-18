# HOX: before seeding you should have at least one user in your database!

#To start from a fresh database (on the command line):
#rake db:drop db:create db:migrate
#rails c
# > User.create name: "[name]", password:"[password]", password_confirmation:"[password]"
# > quit
#rake:db seed

# Create profile for Thingsee One beta
dp = DeviceProfile.create sw_version:"2015.05.21.8_Thingsee_Retail", hw_version:"0402", device_type:"Thingsee", profile_name:"Thingsee One beta version"

# Create device
dp.devices.create device_id:"XNG51760148", user_id:User.first.id

# Create sensor_types and add sensors to profile (from device.jsn on the device and TS Engine API 00.20)
# Commented out sensors have no specification in the API
st1=SensorType.create name:"Temperature"
st1.sensors.create device_profile_id:dp.id, name:"ThingseeOne temperature sensor", address:"0x00060100"

st2=SensorType.create name:"Humidity"
st2.sensors.create device_profile_id:dp.id, name:"ThingseeOne humidity sensor", address:"0x00060200"

st3=SensorType.create name:"Air pressure"
st3.sensors.create device_profile_id:dp.id, name:"ThingseeOne air pressure sensor", address:"0x00060400"

#st4=SensorType.create name:"xxx"
#st4.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00060101"

st5=SensorType.create name:"Power button pressed"
st5.sensors.create device_profile_id:dp.id, name:"ThingseeOne power button pressed sensor", address:"0x00070100"

st6=SensorType.create name:"Longitudinal acceleration"
st6.sensors.create device_profile_id:dp.id, name:"ThingseeOne longitudinal acceleratio sensor", address:"0x00050100"

st7=SensorType.create name:"Lateral acceleration"
st7.sensors.create device_profile_id:dp.id, name:"ThingseeOne lateral acceleration sensor", address:"0x00050200"

st8=SensorType.create name:"Vertical acceleration"
st8.sensors.create device_profile_id:dp.id, name:"ThingseeOne vertical acceleration sensor", address:"0x00050300"

st9=SensorType.create name:"Impact"
st9.sensors.create device_profile_id:dp.id, name:"ThingseeOne impact sensor", address:"0x00050400"

#st10=SensorType.create name:"xxx"
#st10.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00090800"

st11=SensorType.create name:"Heading, degrees"
st11.sensors.create device_profile_id:dp.id, name:"ThingseeOne heading sensor", address:"0x00040100"

st12=SensorType.create name:"Yaw"
st12.sensors.create device_profile_id:dp.id, name:"ThingseeOne yaw sensor", address:"0x00040200"

st13=SensorType.create name:"Pitch"
st13.sensors.create device_profile_id:dp.id, name:"ThingseeOne pitch sensor", address:"0x00040300"

st14=SensorType.create name:"Roll"
st14.sensors.create device_profile_id:dp.id, name:"ThingseeOne roll sensor", address:"0x00040400"

#st15=SensorType.create name:"xxx"
#st15.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00050101"

#st16=SensorType.create name:"xxx"
#st16.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00050201"

#st17=SensorType.create name:"xxx"
#st17.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00050301"

st18=SensorType.create name:"Magnetic field, longitudinal"
st18.sensors.create device_profile_id:dp.id, name:"ThingseeOne longitudinal magnetic field sensor", address:"0x00060500"

st19=SensorType.create name:"Magnetic field, lateral"
st19.sensors.create device_profile_id:dp.id, name:"ThingseeOne lateral magnetic field sensor", address:"0x00060600"

st20=SensorType.create name:"Magnetic field, vertical"
st20.sensors.create device_profile_id:dp.id, name:"ThingseeOne vertical magnetic field sensor", address:"0x00060700"

#st21=SensorType.create name:"xxx"
#st21.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00040500"

#st22=SensorType.create name:"xxx"
#st22.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00040600"

#st23=SensorType.create name:"xxx"
#st23.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00040700"

#st24=SensorType.create name:"xxx"
#st24.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00090801"

st25=SensorType.create name:"Geofence"
st25.sensors.create device_profile_id:dp.id, name:"ThingseeOne geofence sensor", address:"0x00010500"

st26=SensorType.create name:"Latitude"
st26.sensors.create device_profile_id:dp.id, name:"ThingseeOne latitude sensor", address:"0x00010100"

st27=SensorType.create name:"Longitude"
st27.sensors.create device_profile_id:dp.id, name:"ThingseeOne longitude sensor", address:"0x00010200"

st28=SensorType.create name:"Altitude"
st28.sensors.create device_profile_id:dp.id, name:"ThingseeOne altitude sensor", address:"0x00010300"

st29=SensorType.create name:"Location accuracy"
st29.sensors.create device_profile_id:dp.id, name:"ThingseeOne location accuracy sensor", address:"0x00010400"

#st30=SensorType.create name:"xxx"
#st30.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00010600"

st31=SensorType.create name:"GPS speed"
st31.sensors.create device_profile_id:dp.id, name:"ThingseeOne GPS speed sensor", address:"0x00020100"

#st32=SensorType.create name:"xxx"
#st32.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00040101"

st33=SensorType.create name:"Battery capacity"
st33.sensors.create device_profile_id:dp.id, name:"ThingseeOne battery capacity sensor", address:"0x00030100"

st34=SensorType.create name:"Battery level"
st34.sensors.create device_profile_id:dp.id, name:"ThingseeOne battery level sensor", address:"0x00030200"

st35=SensorType.create name:"Battery voltage"
st35.sensors.create device_profile_id:dp.id, name:"ThingseeOne battery capacity sensor", address:"0x00030300"

st36=SensorType.create name:"Connected to charger"
st36.sensors.create device_profile_id:dp.id, name:"ThingseeOne connected to charger sensor", address:"0x00030400"

#st37=SensorType.create name:"xxx"
#st37.sensors.create device_profile_id:dp.id, name:"ThingseeOne xxx sensor", address:"0x00090100"

st38=SensorType.create name:"Ambient light"
st38.sensors.create device_profile_id:dp.id, name:"ThingseeOne ambient light sensor", address:"0x00060300"

#Create a layer for temperature visualization
layer=Layer.create sensor_type_id:st1.id, name:st1.name+" reds"
#Create color drops for layer
layer.color_drops.create value:0, color:"255,255,255,0"
layer.color_drops.create value:5, color:"255,204,204,0"
layer.color_drops.create value:10, color:"255,153,153,0"
layer.color_drops.create value:15, color:"255,102,102,0"
layer.color_drops.create value:20, color:"255,51,51,0"
layer.color_drops.create value:25, color:"255,0,0,0"
layer.color_drops.create value:30, color:"204,0,0,0"

