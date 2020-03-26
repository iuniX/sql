local AREA = {
  {0, 1, 1, 1, 0},
  {1, 1, 1, 1, 1},
  {1, 1, 3, 1, 1},
  {1, 1, 1, 1, 1},
  {0, 1, 1, 1, 0},
}

function callback_formula(cid, level, skill, attack, factor)
  skill = getPlayerSkill(cid, SKILL_SWORD)
  local skill_total = skill + attack / 2.0
  local level_total = level / 5

  local _min          = (skill_total * 4.79 + level_total)
  local _max          = (skill_total * 6.76 + level_total)

  return -(_min), -(_max)
end

local AirSlash = ClassSpell:new()
:setType(COMBAT_HOLYDAMAGE)
:setArea(AREA)
:setCallbackSkill('callback_formula')

local function air_slash(cid, var, fase)
  local pos = getPlayerPosition(cid)
  if fase == 1 then
    doSendMagicEffect({x = pos.x + 1, y = pos.y - 1, z = pos.z}, 158)
    doSendMagicEffect({x = pos.x + 2, y = pos.y + 1, z = pos.z}, 161)
    doSendMagicEffect({x = pos.x + 1, y = pos.y + 2, z = pos.z}, 159)
    doSendMagicEffect({x = pos.x - 1, y = pos.y + 1, z = pos.z}, 160)
  elseif fase == 2 then
    doSendMagicEffect({x = pos.x + 2, y = pos.y - 2, z = pos.z}, 154)
    doSendMagicEffect({x = pos.x + 2, y = pos.y + 1, z = pos.z}, 155)
    doSendMagicEffect({x = pos.x + 1, y = pos.y + 2, z = pos.z}, 157)
    doSendMagicEffect({x = pos.x - 1, y = pos.y + 0, z = pos.z}, 156)
  end
  if fase < 3 then
    --addEvent(air_slash, 600, cid, var, fase + 1)
  end
end

function onCastSpell(cid, var)
  if not Spells:canExecute(cid, "Air Slash") then
    return false
  end
  air_slash(cid, var, 1)
  return AirSlash:cast(cid, var)
end
