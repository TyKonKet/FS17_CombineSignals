--
-- Combine Signals
--
-- @author TyKonKet
-- @date  15/03/17
AIDriveStrategyCombineExtensions = {}

function AIDriveStrategyCombineExtensions:preGetDriveData(dt, vX, vY, vZ)
    self.vehicle.forbidSetBeaconLightsVisibility = true;
end

function AIDriveStrategyCombineExtensions:postGetDriveData(dt, vX, vY, vZ)
    self.vehicle.forbidSetBeaconLightsVisibility = false;
end
