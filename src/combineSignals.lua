--
-- Combine Signals
--
-- @author  TyKonKet
-- @date 07/03/17
CombineSignals = {};
CombineSignals.name = "CombineSignals";
CombineSignals.debug = false;
CombineSignals.dir = g_currentModDirectory;

function CombineSignals:initialize(missionInfo, missionDynamicInfo, loadingScreen)
    Combine.update = Utils.appendedFunction(Combine.update, CombineExtensions.update);
    Combine.postLoad = Utils.appendedFunction(Combine.postLoad, CombineExtensions.postLoad);
    Combine.delete = Utils.appendedFunction(Combine.delete, CombineExtensions.delete);
    AIDriveStrategyCombine.getDriveData = Utils.overwrittenFunction(AIDriveStrategyCombine.getDriveData, AIDriveStrategyCombineExtensions.getDriveData);
    Lights.setBeaconLightsVisibility = LightsExtensions.setBeaconLightsVisibility;
end
g_mpLoadingScreen.loadFunction = Utils.prependedFunction(g_mpLoadingScreen.loadFunction, CombineSignals.initialize);

function CombineSignals:loadMap(name)
end

function CombineSignals:deleteMap()
end

function CombineSignals:keyEvent(unicode, sym, modifier, isDown)
end

function CombineSignals:mouseEvent(posX, posY, isDown, isUp, button)
end

function CombineSignals:update(dt)
end

function CombineSignals:draw()
end

addModEventListener(CombineSignals)
