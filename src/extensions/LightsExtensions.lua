--
-- Combine Signals
--
-- @author TyKonKet
-- @date  15/03/17
LightsExtensions = {};

function LightsExtensions:setBeaconLightsVisibility(superFunc, visibility, force, noEventSend)
    if superFunc ~= nil then
        if not superFunc(self, visibility, noEventSend) then
            return false;
        end
    end
    if self.forbidSetBeaconLightsVisibility then
        return false;
    end
    if visibility ~= self.beaconLightsActive or force then
        if noEventSend == nil or noEventSend == false then
            if g_server ~= nil then
                g_server:broadcastEvent(VehicleSetBeaconLightEvent:new(self, visibility), nil, nil, self);
            else
                g_client:getServerConnection():sendEvent(VehicleSetBeaconLightEvent:new(self, visibility));
            end
        end
        self.beaconLightsActive = visibility;
        local realBeaconLights = g_gameSettings:getValue("realBeaconLights");
        for _, beaconLight in pairs(self.beaconLights) do
            if realBeaconLights and beaconLight.realLight ~= nil then
                setVisibility(beaconLight.realLight, visibility);
            end
            if beaconLight.decoration ~= nil then
                setVisibility(beaconLight.decoration, visibility);
            end
        end
        for _, v in pairs(self.attachedImplements) do
            if v.object ~= nil then
                v.object:setBeaconLightsVisibility(visibility, true, true);
            end
        end
        self:onBeaconLightsVisibilityChanged(visibility);
    end
    return true;
end
