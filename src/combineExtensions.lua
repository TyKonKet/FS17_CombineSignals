--
-- Combine Signals
--
-- @author TyKonKet
-- @date  07/03/17
CombineExtensions = {};

function CombineExtensions:update(dt)
    self.beaconLightsOffDCB:update(dt);
    if self:getIsActive() then
        local fillLevel = self:getUnitFillLevel(self.overloading.fillUnitIndex);
        local capacity = self:getUnitCapacity(self.overloading.fillUnitIndex);
        if fillLevel >= (0.75 * capacity) and not self.beaconLightsFL75 then
            self.beaconLightsFL75 = true;
            self:setBeaconLightsVisibility(true, false);
            CombineExtensions.playSample(self);
        elseif fillLevel <= (0.75 * capacity) and self.beaconLightsFL75 then
            self:setBeaconLightsVisibility(false, false);
            self.beaconLightsFL75 = false;
        end
        if fillLevel >= (0.50 * capacity) and not self.beaconLightsFL50 then
            self.beaconLightsFL50 = true;
            self:setBeaconLightsVisibility(true, false);
            self.beaconLightsOffDCB:call(2000);
            CombineExtensions.playSample(self);
        elseif fillLevel <= (0.50 * capacity) and self.beaconLightsFL50 then
            self.beaconLightsFL50 = false;
        end
        if fillLevel >= (0.25 * capacity) and not self.beaconLightsFL25 then
            self.beaconLightsFL25 = true;
            self:setBeaconLightsVisibility(true, false);
            self.beaconLightsOffDCB:call(1000);
            CombineExtensions.playSample(self);
        elseif fillLevel <= (0.25 * capacity) and self.beaconLightsFL25 then
            self.beaconLightsFL25 = false;
        end
    end
end

function CombineExtensions:postLoad(savegame)
    CombineExtensions.loadSample();
    self.beaconLightsOffDCB = DelayedCallBack:new(function(self)self:setBeaconLightsVisibility(false, false); end, self);
    for k, _ in pairs(self.beaconLights) do
        self.beaconLights[k].speed = self.beaconLights[k].speed * (math.random(70, 75) / 100);
    end
    local fillLevel = self:getUnitFillLevel(self.overloading.fillUnitIndex);
    local capacity = self:getUnitCapacity(self.overloading.fillUnitIndex);
    if fillLevel >= (0.25 * capacity) and not self.beaconLightsFL25 then
        self.beaconLightsFL25 = true;
    end
    if fillLevel >= (0.50 * capacity) and not self.beaconLightsFL50 then
        self.beaconLightsFL50 = true;
    end
end

function CombineExtensions:delete()
    if CombineExtensions.signalSample ~= nil then
        delete(CombineExtensions.signalSample);
    end
end

function CombineExtensions:playSample()
    if self.isEntered then
        local v = 0.8;
        if self:getIsIndoorCameraActive() then
            v = 1.4;
        end
        playSample(CombineExtensions.signalSample, 1, v, 0);
    end
end

function CombineExtensions.loadSample()
    if CombineExtensions.signalSample == nil then
        local fileName = Utils.getFilename("sounds/warningSound.wav", CombineSignals.dir);
        CombineExtensions.signalSample = createSample(fileName);
        loadSample(CombineExtensions.signalSample, fileName, false);
    end
end
