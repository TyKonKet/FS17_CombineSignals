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
            if self.isEntered then
                playSample(self.signalSample, 1, 1.2, 0);
            end
        elseif fillLevel <= (0.75 * capacity) and self.beaconLightsFL75 then
            self:setBeaconLightsVisibility(false, false);
            self.beaconLightsFL75 = false;
        end
        if fillLevel >= (0.50 * capacity) and not self.beaconLightsFL50 then
            self.beaconLightsFL50 = true;
            self:setBeaconLightsVisibility(true, false);
            self.beaconLightsOffDCB:call(2000);
            if self.isEntered then
                playSample(self.signalSample, 1, 1.2, 0);
            end
        elseif fillLevel <= (0.50 * capacity) and self.beaconLightsFL50 then
            self.beaconLightsFL50 = false;
        end
        if fillLevel >= (0.25 * capacity) and not self.beaconLightsFL25 then
            self.beaconLightsFL25 = true;
            self:setBeaconLightsVisibility(true, false);
            self.beaconLightsOffDCB:call(1000);
            if self.isEntered then
                playSample(self.signalSample, 1, 1.2, 0);
            end
        elseif fillLevel <= (0.25 * capacity) and self.beaconLightsFL25 then
            self.beaconLightsFL25 = false;
        end
    end
end

function CombineExtensions:postLoad(savegame)
    local fileName = Utils.getFilename("sounds/warningSound.wav", CombineSignals.dir);
    self.signalSample = createSample(fileName);
    loadSample(self.signalSample, fileName, false);
    local c = 0;
    local s = 0;
    for k, _ in pairs(self.beaconLights) do
        self.beaconLights[k].speed = self.beaconLights[k].speed * (math.random(70, 75) / 100);
        c = c + 1;
        s = s + self.beaconLights[k].speed;
    end
    self.beaconLightsSpeed = s / c;
    local fillLevel = self:getUnitFillLevel(self.overloading.fillUnitIndex);
    local capacity = self:getUnitCapacity(self.overloading.fillUnitIndex);
    if fillLevel >= (0.25 * capacity) and not self.beaconLightsFL25 then
        self.beaconLightsFL25 = true;
    end
    if fillLevel >= (0.50 * capacity) and not self.beaconLightsFL50 then
        self.beaconLightsFL50 = true;
    end
    self.beaconLightsOffDCB = DelayedCallBack:new(function(self)self:setBeaconLightsVisibility(false, false); end, self);
end

function CombineExtensions:delete()
    if self.signalSample ~= nil then
        delete(self.signalSample);
    end
end
