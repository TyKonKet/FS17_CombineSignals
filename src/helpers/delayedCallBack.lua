--
-- Combine Signals
--
-- @author TyKonKet
-- @date  08/03/17
DelayedCallBack = {};
local DelayedCallBack_mt = Class(DelayedCallBack);

function DelayedCallBack:new(callBack, callBackSelf)
    if DelayedCallBack_mt == nil then
        DelayedCallBack_mt = Class(DelayedCallBack);
    end
    local self = {};
    setmetatable(self, DelayedCallBack_mt);
    self.callBack = callBack;
    self.callBackSelf = callBackSelf;
    self.callBackCalled = true;
    self.delay = 0;
    self.delayCounter = 0;
    return self;
end

function DelayedCallBack:update(dt)
    if not self.callBackCalled then
        self.delayCounter = self.delayCounter + dt;
        if self.delayCounter >= self.delay then
            self:callCallBack();
        end
    end
end

function DelayedCallBack:call(delay)
    self.callBackCalled = false;
    if delay == nil or delay == 0 then
        self:callCallBack();
    else
        self.delay = delay;
        self.delayCounter = 0;
    end
end

function DelayedCallBack:callCallBack()
    if self.callBackSelf ~= nil then
        self.callBack(self.callBackSelf);
    else
        self.callBack();
    end
    self.callBackCalled = true;
end
