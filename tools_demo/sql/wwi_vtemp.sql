SELECT 
    TOP 2000
    ChillerSensorNumber,
    RecordedWhen,
    Temperature
FROM Website.VehicleTemperatures
ORDER BY RecordedWhen ASC