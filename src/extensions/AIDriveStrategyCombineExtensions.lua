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

function AIDriveStrategyCombineExtensions:getDriveData(superFunc, dt, vX, vY, vZ)
    self.vehicle.forbidSetBeaconLightsVisibility = true;
    local v1, v2, v3, v4, v5 = superFunc(self, dt, vX, vY, vZ);
    self.vehicle.forbidSetBeaconLightsVisibility = false;
    return v1, v2, v3, v4, v5;
end
