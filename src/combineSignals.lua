--
-- Combine Signals
--
-- @author  TyKonKet
-- @date 07/03/17
CombineSignals = {};
CombineSignals.name = "CombineSignals";
CombineSignals.debug = false;
CombineSignals.dir = g_currentModDirectory;

function CombineSignals:print(txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9)
    if self.debug then
        local args = {txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9};
        for i, v in ipairs(args) do
            if v then
                print("[" .. self.name .. "] -> " .. tostring(v));
            end
        end
    end
end

function CombineSignals:initialize(missionInfo, missionDynamicInfo, loadingScreen)
    self = CombineSignals;
    self:print("initialize()");
    Combine.update = Utils.appendedFunction(Combine.update, CombineExtensions.update);
    Combine.postLoad = Utils.appendedFunction(Combine.postLoad, CombineExtensions.postLoad);
    Combine.delete = Utils.appendedFunction(Combine.delete, CombineExtensions.delete);
    --AIDriveStrategyCombine.getDriveData = Utils.appendedFunction(AIDriveStrategyCombine.getDriveData, AIDriveStrategyCombineExtensions.postGetDriveData);
    --AIDriveStrategyCombine.getDriveData = Utils.prependedFunction(AIDriveStrategyCombine.getDriveData, AIDriveStrategyCombineExtensions.preGetDriveData);
    AIDriveStrategyCombine.getDriveData = Utils.overwrittenFunction(AIDriveStrategyCombine.getDriveData, AIDriveStrategyCombineExtensions.getDriveData);
    Lights.setBeaconLightsVisibility = LightsExtensions.setBeaconLightsVisibility;
end
g_mpLoadingScreen.loadFunction = Utils.prependedFunction(g_mpLoadingScreen.loadFunction, CombineSignals.initialize);

function CombineSignals:load(missionInfo, missionDynamicInfo, loadingScreen)
    self = CombineSignals;
    self:print("load()");
    g_currentMission.loadMapFinished = Utils.appendedFunction(g_currentMission.loadMapFinished, self.loadMapFinished);
    g_currentMission.onStartMission = Utils.appendedFunction(g_currentMission.onStartMission, self.afterLoad);
    g_currentMission.missionInfo.saveToXML = Utils.appendedFunction(g_currentMission.missionInfo.saveToXML, self.saveSavegame);
end
g_mpLoadingScreen.loadFunction = Utils.appendedFunction(g_mpLoadingScreen.loadFunction, CombineSignals.load);

function CombineSignals:loadMap(name)
    self:print(("loadMap(name:%s)"):format(name));
    if self.debug then
        addConsoleCommand("AAACombineSignalseTestCommand", "", "TestCommand", self);
    end
    self:loadSavegame();
end

function CombineSignals:loadMapFinished()
    self = CombineSignals;
    self:print("loadMapFinished()");
end

function CombineSignals:afterLoad()
    self = CombineSignals;
    self:print("afterLoad");
end

function CombineSignals:loadSavegame()
    self:print("loadSavegame()");
end

function CombineSignals:saveSavegame()
    self = CombineSignals;
    self:print("saveSavegame()");
end

function CombineSignals:deleteMap()
    self:print("deleteMap()");
end

function CombineSignals:TestCommand()
    return "This is a test command";
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
