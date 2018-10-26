-- Copyright(c) Cragon. All rights reserved.
-- 主界面左上角本人信息
-- 主界面当前好友信息

---------------------------------------
UiMainPlayerInfo = {}

---------------------------------------
function UiMainPlayerInfo:new(com, show_invite, action_click)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.ComPlayerInfo = com
    o.ComPlayerInfo.onClick:Add(action_click)
    local com_headicon = o.ComPlayerInfo:GetChild("CoHeadIcon").asCom
    o.UiHeadIcon = ViewHeadIcon:new(nil, com_headicon, nil,
            function()
                o:_loadHeadIconDown()
            end)
    o.GTextName = o.ComPlayerInfo:GetChild("TextName").asTextField
    o.GTextChips = o.ComPlayerInfo:GetChild("TextChips").asTextField
    o.GTextGolds = o.ComPlayerInfo:GetChild("TextGolds").asTextField
    local image_invite = o.ComPlayerInfo:GetChild("ImageInvite")
    if (image_invite ~= nil) then
        o.GImageInvite = image_invite.asImage
        o.GImageInvite.visible = show_invite
    end
    if (show_invite == true) then
        o.UiHeadIcon:hideIcon()
    end

    local image_iconGold = o.ComPlayerInfo:GetChild("IconGold" .. ChipIconSolustion)
    if (image_iconGold ~= nil) then
        o.GImageIconGold = image_iconGold.asImage
    end
    local image_iconDiamond = o.ComPlayerInfo:GetChild("IconDiamond" .. ChipIconSolustion)
    if (image_iconDiamond ~= nil) then
        o.GImageIconDiamond = image_iconDiamond.asImage
    end

    return o
end

---------------------------------------
function UiMainPlayerInfo:setPlayerInfo(name, chips, golds, icon_name, acount_id, vip_level, is_online)
    if (self.GImageIconGold ~= nil) then
        self.GImageIconGold.visible = true
    end
    if (self.GImageIconDiamond ~= nil) then
        self.GImageIconDiamond.visible = true
    end
    self.UiHeadIcon:setPlayerInfo(icon_name, acount_id, vip_level, is_online)
    self.GTextName.text = CS.Casinos.UiHelper.addEllipsisToStr(name, 18, 5)
    self.GTextChips.text = chips
    self.GTextGolds.text = golds
end

---------------------------------------
function UiMainPlayerInfo:setPlayerInfo1(name, chips, golds, is_online)
    if (self.GImageIconGold ~= nil) then
        self.GImageIconGold.visible = true
    end
    if (self.GImageIconDiamond ~= nil) then
        self.GImageIconDiamond.visible = true
    end
    self.GTextName.text = CS.Casinos.UiHelper.addEllipsisToStr(name, 18, 5)
    self.GTextChips.text = chips
    self.GTextGolds.text = golds
    local show_shade = false
    if (is_online == false) then
        show_shade = true
    end
    self.UiHeadIcon:showShade(show_shade)
end

---------------------------------------
function UiMainPlayerInfo:updatePlayerGold(gold)
    self.GTextChips.text = gold
end

---------------------------------------
function UiMainPlayerInfo:updatePlayerDiamond(diamond)
    self.GTextGolds.text = diamond
end

---------------------------------------
function UiMainPlayerInfo:refreshHeadIcon(icon_name, acount_id)
    self.UiHeadIcon:setIcon(icon_name, acount_id)
end

---------------------------------------
function UiMainPlayerInfo:hidePlayerInfo(show_invite)
    if (self.GImageIconGold ~= nil) then
        self.GImageIconGold.visible = false
    end
    if (self.GImageIconDiamond ~= nil) then
        self.GImageIconDiamond.visible = false
    end
    self.UiHeadIcon:setIcon1("")
    self.UiHeadIcon:hideIcon()
    self.GTextName.text = ""
    self.GTextChips.text = ""
    self.GTextGolds.text = ""
    if (self.GImageInvite ~= nil) then
        CS.Casinos.UiHelper.SetGObjectVisible(show_invite, self.GImageInvite)
    end
end

---------------------------------------
function UiMainPlayerInfo:_loadHeadIconDown(is_success)
    if (self.GImageInvite ~= nil) then
        CS.Casinos.UiHelper.SetGObjectVisible(false, self.GImageInvite)
    end
end