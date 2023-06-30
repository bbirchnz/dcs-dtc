dofile(lfs.writedir()..'Scripts/DCSDTC/commonFunctions.lua')

--Displays
-- 0 - ??
-- 1 - HUD
-- 2 - Left MPD
-- 3 - ??
-- 4 - MPCD
-- 5 - ??
-- 6 - Right MPD
-- 7 - ??
-- 8 - UFC

function DTC_F15E_GetFrontLeftMPD()
	return DTC_ParseDisplay(2)
end

function DTC_F15E_GetFrontRightMPD()
	return DTC_ParseDisplay(6)
end

function DTC_F15E_GetFrontMPCD()
	return DTC_ParseDisplay(4)
end

function DTC_F15E_GetUFC()
	return DTC_ParseDisplay(8)
end

function DTC_F15E_GetDisplay(disp)
	local table;
	if disp == "FLMPD" then
		table = DTC_F15E_GetFrontLeftMPD();
	elseif disp == "FRMPD" then
		table = DTC_F15E_GetFrontRightMPD();
	elseif disp	== "FMPCD" then
		table = DTC_F15E_GetFrontMPCD();
	end
	return table
end

--[[
function DTC_ClickCockpit(device, cmd)
	device:performClickableAction(cmd, 1)
	device:performClickableAction(cmd, 0)
end

function DTC_F15E_GetDisplayDevice(disp)
	if disp == "FLMPD" then
		return 34;
	elseif disp == "FRMPD" then
		return 36;
	elseif disp	== "FMPCD" then
		return 35;
	end
end

function DTC_F15E_CheckCondition_HasProgrammedDisplays(disp)
	local table = DTC_F15E_GetDisplay(disp);
	local p1 = table["PRG_Label_1"] or ""
	local p2 = table["PRG_Label_2"] or ""
	local p3 = table["PRG_Label_3"] or ""

	if p1 ~= "" then DTC_F15E_ClearProgrammedDisplay(disp, p1) end
	if p2 ~= "" then DTC_F15E_ClearProgrammedDisplay(disp, p2) end
	if p3 ~= "" then DTC_F15E_ClearProgrammedDisplay(disp, p3) end

	return true
end

function DTC_F15E_ClearProgrammedDisplay(disp, page)
	local d = GetDevice(DTC_F15E_GetDisplayDevice(disp))
	if page == "ADI" then
		DTC_ClickCockpit(d, 3061)
	elseif page == "ARMT" then
		DTC_ClickCockpit(d, 3062)
	elseif page == "HSI" then
		DTC_ClickCockpit(d, 3063)
	elseif page == "TSD" then
		DTC_ClickCockpit(d, 3065)
	elseif page == "TPOD" then
		DTC_ClickCockpit(d, 3072)
	elseif page == "TEWS" then
		DTC_ClickCockpit(d, 3073)
	elseif page == "A/G RDR" then
		DTC_ClickCockpit(d, 3074)
	elseif page == "A/A RDR" then
		DTC_ClickCockpit(d, 3075)
	elseif page == "HUD" then
		DTC_ClickCockpit(d, 3077)
	elseif page == "ENG" then
		DTC_ClickCockpit(d, 3078)
	elseif page == "A/G DLVRY" then
		DTC_ClickCockpit(d, 3071)
		DTC_ClickCockpit(d, 3062)
		DTC_ClickCockpit(d, 3071)
		DTC_ClickCockpit(d, 3071)
	end
end
--]]

function DTC_F15E_CheckCondition_IsTACANBand(band)
	local table = DTC_F15E_GetUFC(disp);
	local str = table["UFC_SC_01"] or "";
	if str ~= "" and str.sub(str, -1) == band then
		return true
	end
	return false
end

function DTC_F15E_CheckCondition_IsStrDifferent(expected)
	local table = DTC_F15E_GetUFC(disp);
	local str = table["UFC_SC_01"] or "";
	if str ~= expected then
		return true
	end
	return false
end

function DTC_F15E_CheckCondition_NoDisplaysProgrammed(disp)
	local table = DTC_F15E_GetDisplay(disp);
	local str = table["PRG_Label_1"] or table["PRG_Label_2"] or table["PRG_Label_3"] or ""
	if str == "" then
		return true
	end
	return false
end

function DTC_F15E_CheckCondition_IsProgBoxed(disp)
	local table = DTC_F15E_GetDisplay(disp);
	local pb06 = table["PRG_PB06_T"] or "";
	if pb06 == "PROG" then
		return true
	end
	return false
end

function DTC_F15E_CheckCondition_DisplayNotInMainMenu(disp)
	local table = DTC_F15E_GetDisplay(disp);
	local pb06 = table["PB06"] or "";
	local pb11 = table["PB11"] or "";
	if pb06 == "PROG" and pb11 == "M2" then
		return false
	end
	return true
end

function DTC_F15E_AfterNextFrame(params)
	local mainPanel = GetDevice(0);
	local ipButton = mainPanel:get_argument_value(297);
	local emButton = mainPanel:get_argument_value(287);

	if ipButton == 1 then params["uploadCommand"] = "1" end
	if emButton == 1 then params["toggleDTCCommand"] = "1" end
end