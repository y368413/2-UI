--## Version: 1.1.0 ## Author: Bytespire
local ItemProfConstants = {}

local COOK = 0x001
local FAID = 0x002
local ALC =  0x004
local BS =   0x008
local ENC =  0x010
local ENG =  0x020
local LW =   0x040
local TAIL = 0x080
local INS =  0x100
local JC =   0x200

local VENDOR = 0x400


--[[ Define category for each expansion?
-- Enables option: toggle tracking of expansion specific items
local VANILLA = 0x01000
local BC =      0x02000
local WRATH =   0x04000
local CATA =    0x08000
local MOP =     0x10000
local WOD =     0x20000
local LEGION =  0x40000
local BFA =     0x80000
--]]

ItemProfConstants.VENDOR_ITEM_FLAG = VENDOR
ItemProfConstants.NUM_PROF_FLAGS = 10	-- Num professions tracked

ItemProfConstants.PROF_TEXTURES = {
[ COOK ] = GetSpellTexture( 2550 ),
[ FAID ] = GetSpellTexture( 3273 ),
[ ALC ] = GetSpellTexture( 2259 ),
[ BS ] = GetSpellTexture( 2018 ),
[ ENC ] = GetSpellTexture( 7411 ),
[ ENG ] = GetSpellTexture( 4036 ),
[ LW ] = GetSpellTexture( 2108 ),
[ TAIL ] = GetSpellTexture( 3908 ),
[ INS ] = GetSpellTexture( 45357 ),
[ JC ] = GetSpellTexture( 25229 )
}

-- Mapping the item IDs to texture indices
ItemProfConstants.ITEM_PROF_FLAGS = {

[ 118 ] = ALC,
[ 159 ] = COOK + ENG + VENDOR,
[ 723 ] = COOK,
[ 765 ] = ALC,
[ 769 ] = COOK,
[ 774 ] = BS + ENG + JC,
[ 783 ] = LW,
[ 785 ] = ALC + COOK,
[ 818 ] = BS + ENG + JC,
[ 929 ] = TAIL,
[ 1015 ] = COOK,
[ 1080 ] = COOK,
[ 1179 ] = COOK + VENDOR,
[ 1206 ] = BS + ENG + LW + JC,
[ 1210 ] = BS + ENG + JC,
[ 1288 ] = ALC,
[ 1468 ] = COOK,
[ 1529 ] = BS + ENG + LW + TAIL + JC,
[ 1705 ] = BS + ENG + JC,
[ 2251 ] = COOK,
[ 2318 ] = BS + ENG + LW + TAIL,
[ 2319 ] = BS + ENG + LW + TAIL,
[ 2320 ] = LW + TAIL + VENDOR,
[ 2321 ] = BS + LW + TAIL + VENDOR,
[ 2324 ] = LW + TAIL + VENDOR,
[ 2325 ] = LW + TAIL + VENDOR,
[ 2447 ] = ALC,
[ 2449 ] = ALC,
[ 2450 ] = ALC,
[ 2452 ] = ALC + COOK,
[ 2453 ] = ALC,
[ 2457 ] = LW,
[ 2459 ] = BS + LW,
[ 2589 ] = BS + ENG + TAIL,
[ 2592 ] = BS + ENG + TAIL,
[ 2593 ] = COOK + VENDOR,
[ 2594 ] = COOK + VENDOR,
[ 2595 ] = COOK,
[ 2596 ] = COOK,
[ 2604 ] = ENG + LW + TAIL + VENDOR,
[ 2605 ] = BS + ENG + LW + TAIL + VENDOR,
[ 2672 ] = COOK,
[ 2673 ] = COOK,
[ 2674 ] = COOK,
[ 2675 ] = COOK,
[ 2677 ] = COOK,
[ 2678 ] = COOK + VENDOR,
[ 2835 ] = BS + ENG + JC,
[ 2836 ] = BS + ENG + JC,
[ 2838 ] = BS + ENG + JC,
[ 2840 ] = BS + ENG + LW + JC,
[ 2841 ] = BS + ENG + JC,
[ 2842 ] = BS + ENG + JC,
[ 2880 ] = BS + VENDOR,
[ 2886 ] = COOK,
[ 2901 ] = ENG + VENDOR,
[ 2924 ] = COOK,
[ 2934 ] = LW,
[ 2996 ] = TAIL,
[ 2997 ] = LW + TAIL,
[ 3164 ] = ALC,
[ 3173 ] = COOK,
[ 3182 ] = LW,
[ 3355 ] = ALC,
[ 3356 ] = ALC + LW,
[ 3357 ] = ALC,
[ 3358 ] = ALC,
[ 3369 ] = ALC,
[ 3371 ] = ALC + ENC + INS + VENDOR,
[ 3383 ] = LW + TAIL,
[ 3389 ] = LW,
[ 3390 ] = LW,
[ 3391 ] = BS + JC,
[ 3404 ] = COOK,
[ 3466 ] = BS + VENDOR,
[ 3470 ] = BS,
[ 3478 ] = BS,
[ 3486 ] = BS,
[ 3575 ] = ALC + BS + ENG + JC,
[ 3577 ] = BS + ENG + TAIL + JC,
[ 3667 ] = COOK,
[ 3685 ] = COOK,
[ 3712 ] = COOK,
[ 3730 ] = COOK,
[ 3731 ] = COOK,
[ 3818 ] = ALC,
[ 3819 ] = ALC + ENC,
[ 3820 ] = ALC,
[ 3821 ] = ALC + COOK,
[ 3823 ] = BS,
[ 3824 ] = ALC + BS + LW + TAIL + JC,
[ 3827 ] = TAIL + JC,
[ 3829 ] = BS + ENG + TAIL,
[ 3858 ] = ALC,
[ 3859 ] = BS + ENG,
[ 3860 ] = ALC + BS + ENG + JC,
[ 3864 ] = BS + ENG + LW + TAIL + JC,
[ 4231 ] = LW,
[ 4232 ] = LW,
[ 4233 ] = LW,
[ 4234 ] = BS + ENG + LW + TAIL,
[ 4235 ] = LW,
[ 4236 ] = LW,
[ 4243 ] = LW,
[ 4246 ] = LW,
[ 4255 ] = BS,
[ 4289 ] = LW + VENDOR,
[ 4291 ] = LW + TAIL + VENDOR,
[ 4304 ] = BS + ENG + LW + TAIL,
[ 4305 ] = LW + TAIL,
[ 4306 ] = BS + ENG + TAIL,
[ 4337 ] = ENG + LW + TAIL,
[ 4338 ] = BS + ENG + LW,
[ 4339 ] = ENG + TAIL,
[ 4340 ] = LW + TAIL + VENDOR,
[ 4341 ] = TAIL + VENDOR,
[ 4342 ] = ALC + ENG + LW + TAIL + VENDOR,
[ 4357 ] = ENG,
[ 4359 ] = ENG,
[ 4364 ] = ENG,
[ 4368 ] = ENG,
[ 4371 ] = ENG,
[ 4375 ] = ENG,
[ 4377 ] = ENG,
[ 4382 ] = ENG,
[ 4385 ] = ENG,
[ 4387 ] = ENG,
[ 4389 ] = ENG,
[ 4394 ] = ENG,
[ 4400 ] = ENG + VENDOR,
[ 4402 ] = ALC + COOK + ENG,
[ 4404 ] = ENG,
[ 4406 ] = ENG,
[ 4407 ] = ENG,
[ 4461 ] = LW,
[ 4470 ] = ENG + ENC + VENDOR,
[ 4537 ] = COOK,
[ 4603 ] = COOK,
[ 4611 ] = ENG,
[ 4625 ] = ALC + ENC + TAIL,
[ 4655 ] = COOK,
[ 5051 ] = COOK,
[ 5082 ] = LW,
[ 5373 ] = LW,
[ 5465 ] = COOK,
[ 5466 ] = COOK,
[ 5467 ] = COOK,
[ 5468 ] = COOK,
[ 5469 ] = COOK,
[ 5470 ] = COOK,
[ 5471 ] = COOK,
[ 5498 ] = BS + LW + TAIL + JC,
[ 5500 ] = BS + LW + TAIL,
[ 5503 ] = COOK,
[ 5504 ] = COOK,
[ 5633 ] = LW,
[ 5635 ] = ALC + BS,
[ 5637 ] = ALC + BS + ENC + LW + JC,
[ 5784 ] = LW,
[ 5785 ] = LW,
[ 5956 ] = ENG + VENDOR,
[ 5966 ] = BS,
[ 6037 ] = BS + ENC + ENG + TAIL + JC,
[ 6048 ] = TAIL,
[ 6149 ] = JC,
[ 6217 ] = ENC,
[ 6260 ] = ENG + TAIL + VENDOR,
[ 6261 ] = TAIL + VENDOR,
[ 6289 ] = COOK,
[ 6291 ] = COOK,
[ 6303 ] = COOK,
[ 6308 ] = COOK,
[ 6317 ] = COOK,
[ 6358 ] = ALC,
[ 6359 ] = ALC,
[ 6361 ] = COOK,
[ 6362 ] = COOK,
[ 6370 ] = ALC + ENC,
[ 6371 ] = ALC + TAIL,
[ 6470 ] = LW,
[ 6471 ] = LW,
[ 6522 ] = COOK,
[ 6530 ] = ENG + VENDOR,
[ 6889 ] = COOK,
[ 7005 ] = ENG + VENDOR,
[ 7067 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 7068 ] = ALC + BS + ENG + TAIL,
[ 7069 ] = ALC + BS + ENG + TAIL,
[ 7070 ] = ALC + BS + LW + JC,
[ 7071 ] = LW + TAIL,
[ 7072 ] = TAIL,
[ 7075 ] = BS + ENG + LW + JC,
[ 7076 ] = BS + ENC + ENG + LW + TAIL + JC,
[ 7077 ] = ALC + BS + ENG + LW + TAIL + JC,
[ 7078 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 7079 ] = ENG + LW + TAIL + JC,
[ 7080 ] = ALC + BS + ENC + ENG + LW + TAIL,
[ 7081 ] = BS + LW + JC,
[ 7082 ] = ALC + ENC + ENG + LW + TAIL + JC,
[ 7191 ] = ENG,
[ 7286 ] = LW,
[ 7387 ] = ENG,
[ 7392 ] = ENC,
[ 7909 ] = BS + ENC + ENG + JC,
[ 7910 ] = BS + ENG + JC + TAIL,
[ 7912 ] = BS + ENG + JC,
[ 7966 ] = BS,
[ 7971 ] = BS + LW + TAIL + JC,
[ 7972 ] = ALC + BS + ENG + TAIL,
[ 7974 ] = COOK,
[ 8150 ] = COOK + ENG + LW,
[ 8153 ] = ALC + BS + ENC + ENG + LW + TAIL,
[ 8154 ] = LW,
[ 8165 ] = LW,
[ 8167 ] = LW,
[ 8169 ] = LW,
[ 8170 ] = BS + ENC + ENG + LW + TAIL,
[ 8171 ] = LW,
[ 8172 ] = LW,
[ 8343 ] = LW + TAIL + VENDOR,
[ 8365 ] = COOK,
[ 8831 ] = ALC + ENC + TAIL,
[ 8838 ] = ALC + ENC,
[ 8839 ] = ALC,
[ 8845 ] = ALC,
[ 8846 ] = ALC,
[ 9060 ] = ENG,
[ 9061 ] = COOK + ENG,
[ 9149 ] = ALC,
[ 9210 ] = TAIL,
[ 9224 ] = ENC,
[ 9260 ] = ALC + COOK,
[ 9262 ] = ALC,
[ 9312 ] = ENG + VENDOR,
[ 9313 ] = ENG + VENDOR,
[ 9318 ] = ENG + VENDOR,
[ 10026 ] = ENG,
[ 10285 ] = ENG + LW + TAIL,
[ 10286 ] = ALC + ENG + TAIL + JC,
[ 10290 ] = TAIL + VENDOR,
[ 10500 ] = ENG,
[ 10502 ] = ENG,
[ 10505 ] = ENG,
[ 10507 ] = ENG,
[ 10543 ] = ENG,
[ 10546 ] = ENG,
[ 10558 ] = ENG,
[ 10559 ] = ENG,
[ 10560 ] = ENG,
[ 10561 ] = ENG,
[ 10576 ] = ENG,
[ 10577 ] = ENG,
[ 10586 ] = ENG,
[ 10592 ] = ENG,
[ 10620 ] = ALC,
[ 10647 ] = ENG + VENDOR,
[ 10938 ] = ENC,
[ 10939 ] = ENC,
[ 10940 ] = ENC,
[ 11291 ] = ENC + ENG + LW + VENDOR,
[ 11371 ] = BS + ENG + JC,
[ 11382 ] = BS + JC,
[ 11754 ] = BS + LW + JC,
[ 12037 ] = COOK,
[ 12184 ] = COOK,
[ 12202 ] = COOK,
[ 12203 ] = COOK,
[ 12204 ] = COOK,
[ 12205 ] = COOK,
[ 12206 ] = COOK,
[ 12207 ] = COOK,
[ 12208 ] = COOK,
[ 12223 ] = COOK,
[ 12359 ] = ALC + BS + ENC + ENG + JC,
[ 12360 ] = BS + ENG + TAIL + JC,
[ 12361 ] = BS + ENG + JC,
[ 12363 ] = ALC + JC,
[ 12364 ] = BS + ENG + TAIL + JC,
[ 12365 ] = BS + ENG + JC,
[ 12607 ] = LW,
[ 12644 ] = BS,
[ 12655 ] = BS + ENG,
[ 12662 ] = BS + TAIL + JC,
[ 12799 ] = BS + ENG + JC,
[ 12800 ] = BS + ENG + TAIL + JC,
[ 12803 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 12804 ] = ALC + BS + ENG + LW + TAIL + JC,
[ 12808 ] = ALC + BS + COOK + ENC + ENG + TAIL + JC,	-- northrend
[ 12809 ] = BS + LW + TAIL,
[ 12810 ] = BS + ENG + LW + TAIL,
[ 12811 ] = BS + ENC + TAIL,
[ 12938 ] = ALC + JC,
[ 13422 ] = ALC,
[ 13423 ] = ALC,
[ 13463 ] = ALC,
[ 13464 ] = ALC,
[ 13465 ] = ALC,
[ 13466 ] = ALC,
[ 13467 ] = ALC + ENC + ENG,
[ 13468 ] = ALC + TAIL,
[ 13510 ] = BS,
[ 13512 ] = BS,
[ 13754 ] = COOK,
[ 13755 ] = COOK,
[ 13756 ] = COOK,
[ 13758 ] = COOK,
[ 13759 ] = COOK,
[ 13760 ] = COOK,
[ 13888 ] = COOK,
[ 13889 ] = COOK,
[ 13893 ] = COOK,
[ 13926 ] = ENC + TAIL,

[ 14044 ] = LW,
[ 14047 ] = BS + ENG + LW + TAIL,
[ 14048 ] = LW + TAIL,
[ 14227 ] = ENG + LW + TAIL,
[ 14256 ] = LW + TAIL,
[ 14341 ] = LW + TAIL + VENDOR,
[ 14342 ] = LW + TAIL,
[ 14343 ] = ENC,
[ 14344 ] = BS + ENC + TAIL + JC,
[ 15407 ] = ENG + LW,
[ 15408 ] = LW,
[ 15410 ] = LW,
[ 15412 ] = LW,
[ 15414 ] = LW,
[ 15415 ] = LW,
[ 15416 ] = LW,
[ 15417 ] = LW,
[ 15419 ] = LW,
[ 15992 ] = ENG,
[ 15994 ] = ENG,
[ 16000 ] = ENG,
[ 16006 ] = ENG,
[ 16202 ] = ENC,
[ 16203 ] = ENC + TAIL,
[ 16204 ] = ENC + JC,
[ 17010 ] = BS + ENG + LW + TAIL,
[ 17011 ] = BS + ENG + LW + TAIL,
[ 17012 ] = BS + LW + TAIL,
[ 17056 ] = LW,
[ 17194 ] = COOK + VENDOR,
[ 17196 ] = COOK + VENDOR,
[ 17202 ] = ENG,
[ 17203 ] = BS,
[ 18232 ] = ENG,
[ 18240 ] = LW + TAIL,
[ 18255 ] = COOK,
[ 18335 ] = JC,
[ 18567 ] = BS + VENDOR,
[ 18631 ] = ENG,
[ 19767 ] = LW,
[ 19768 ] = LW,
[ 19943 ] = ALC,
[ 20381 ] = LW,
[ 20424 ] = COOK,
[ 20520 ] = BS + TAIL,
[ 20816 ] = JC,
[ 20817 ] = JC,
[ 20963 ] = JC,
[ 21024 ] = COOK,
[ 21071 ] = COOK,
[ 21153 ] = COOK,
[ 21752 ] = JC,
[ 22203 ] = BS,
[ 22577 ] = COOK,
[ 22644 ] = COOK,
[ 22682 ] = BS + LW + TAIL,
[ 23676 ] = COOK,
[ 27668 ] = COOK,
[ 27669 ] = COOK,
[ 27671 ] = COOK,

[ 30816 ] = COOK,
[ 30817 ] = COOK + VENDOR,
[ 34113 ] = ENG,
[ 34412 ] = COOK + VENDOR,
[ 35562 ] = COOK,
[ 38426 ] = LW + TAIL + VENDOR,
[ 38682 ] = ENC + VENDOR,
[ 39151 ] = INS,
[ 39334 ] = INS,
[ 39338 ] = INS,
[ 39339 ] = INS,
[ 39340 ] = INS,
[ 39341 ] = INS,
[ 39354 ] = INS + ENC + VENDOR,
[ 39469 ] = INS,
[ 39684 ] = ENG + VENDOR,
[ 39774 ] = INS,

[ 43103 ] = INS,
[ 43104 ] = INS,
[ 43105 ] = INS,
[ 43106 ] = INS,
[ 43107 ] = INS,
[ 43115 ] = INS,
[ 43116 ] = INS,
[ 43117 ] = INS,
[ 43118 ] = INS,
[ 43119 ] = INS,
[ 43120 ] = INS,
[ 43121 ] = INS,
[ 43122 ] = INS,
[ 43123 ] = INS,
[ 44834 ] = COOK,
[ 44835 ] = COOK,
[ 44853 ] = COOK,
[ 44854 ] = COOK,
[ 44855 ] = COOK,

[ 46784 ] = COOK,
[ 46793 ] = COOK,
[ 64796 ] = COOK,

[ 52188 ] = JC + VENDOR,

-- [ 113509 ] = INS,


-- ##### Outland items #####


[ 13444 ] = ENC,
[ 13446 ] = ENC,
[ 13503 ] = ALC,
[ 13757 ] = COOK,
[ 16006 ] = ENG,

[ 21840 ] = ENG + TAIL,
[ 21842 ] = TAIL,
[ 21844 ] = LW + TAIL,
[ 21845 ] = TAIL,
[ 21877 ] = BS + LW + TAIL,
[ 21881 ] = TAIL,
[ 21882 ] = TAIL,
[ 21884 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 21885 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 21886 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,
[ 21887 ] = BS + ENG + LW + TAIL,

[ 21929 ] = ALC + ENG + JC,


[ 22445 ] = BS + ENC + ENG + LW + TAIL,
[ 22446 ] = ENC + TAIL,
[ 22447 ] = ENC,
[ 22448 ] = ENC + ENG + LW,
[ 22449 ] = BS + ENC + ENG,
[ 22450 ] = BS + ENC + LW + TAIL,
[ 22451 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 22452 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 22456 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 22457 ] = ALC + BS + ENG + LW + TAIL + JC,
[ 22573 ] = ALC + BS + ENG,
[ 22574 ] = ALC + ENG,
[ 22578 ] = ALC + JC,
[ 22785 ] = ALC,
[ 22786 ] = ALC,
[ 22787 ] = ALC,
[ 22789 ] = ALC,
[ 22790 ] = ALC,
[ 22791 ] = ALC + ENC,
[ 22792 ] = ALC + ENC,
[ 22793 ] = ALC,
[ 22794 ] = ALC + ENC + TAIL,

[ 22824 ] = BS + ENC,
[ 22829 ] = ENG,
[ 22831 ] = BS,
[ 22832 ] = ENG,

[ 23077 ] = ALC + ENG + JC,
[ 23079 ] = ALC + ENG + JC,
[ 23107 ] = ALC + JC,
[ 23112 ] = ALC + ENG + JC,
[ 23117 ] = ALC + JC,

[ 23427 ] = ENC,
[ 23436 ] = ENG + JC,
[ 23437 ] = ENG + JC,
[ 23438 ] = ENG + JC,
[ 23439 ] = ENG + JC,
[ 23440 ] = ENG + JC,
[ 23441 ] = ENG + JC,
[ 23445 ] = BS + ENG + JC,
[ 23446 ] = BS + ENG + JC,
[ 23447 ] = BS + JC,
[ 23448 ] = BS + ENG + JC,
[ 23449 ] = BS + ENG + JC,


[ 23563 ] = BS,
[ 23564 ] = BS,
[ 23571 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 23572 ] = BS + ENG + LW,
[ 23573 ] = BS + ENG + JC,
[ 23781 ] = ENG,
[ 23782 ] = ALC + ENG,
[ 23783 ] = ENG,
[ 23784 ] = ENG,
[ 23785 ] = ENG,
[ 23786 ] = ENG,
[ 23787 ] = ENG,
[ 23793 ] = ENG + LW,
[ 23826 ] = ENG,

[ 24243 ] = JC,
[ 24271 ] = ENG + TAIL,
[ 24272 ] = ENG + TAIL,
[ 24477 ] = COOK,
[ 24478 ] = JC,
[ 24479 ] = JC,

[ 25649 ] = LW,
[ 25699 ] = LW,
[ 25700 ] = LW,
[ 25707 ] = LW,
[ 25708 ] = LW,
[ 25867 ] = ALC + JC,
[ 25868 ] = ALC + JC,

[ 27422 ] = COOK,
[ 27425 ] = COOK,
[ 27429 ] = COOK,
[ 27435 ] = COOK,
[ 27437 ] = COOK,
[ 27438 ] = COOK,
[ 27439 ] = COOK,
[ 27503 ] = BS,
[ 27515 ] = COOK,
[ 27516 ] = COOK,
[ 27671 ] = COOK,
[ 27674 ] = COOK,
[ 27677 ] = COOK,
[ 27678 ] = COOK,
[ 27681 ] = COOK,
[ 27682 ] = COOK,
[ 27860 ] = JC + VENDOR,

[ 28425 ] = BS,
[ 28426 ] = BS,
[ 28428 ] = BS,
[ 28429 ] = BS,
[ 28431 ] = BS,
[ 28432 ] = BS,
[ 28434 ] = BS,
[ 28435 ] = BS,
[ 28437 ] = BS,
[ 28438 ] = BS,
[ 28440 ] = BS,
[ 28441 ] = BS,
[ 28483 ] = BS,
[ 28484 ] = BS,

[ 29539 ] = LW,
[ 29547 ] = LW,
[ 29548 ] = LW,

[ 30183 ] = ALC + TAIL,

[ 31079 ] = JC,
[ 31670 ] = COOK,
[ 31671 ] = COOK,
[ 32227 ] = JC,
[ 32228 ] = JC,
[ 32229 ] = JC,
[ 32230 ] = JC,
[ 32231 ] = JC,
[ 32249 ] = JC,
[ 32423 ] = ENG,
[ 32428 ] = BS + LW + TAIL,
[ 32461 ] = ENG,
[ 32472 ] = ENG,
[ 32473 ] = ENG,
[ 32474 ] = ENG,
[ 32475 ] = ENG,
[ 32476 ] = ENG,
[ 32478 ] = ENG,
[ 32479 ] = ENG,
[ 32480 ] = ENG,
[ 32494 ] = ENG,
[ 32495 ] = ENG,
[ 33823 ] = COOK,
[ 33824 ] = COOK,

[ 34249 ] = ENG + VENDOR,
[ 34664 ] = BS + LW + TAIL + JC,
[ 35128 ] = BS + ENG + JC,

-- ##### Northrend items #####

[ 33447 ] = ALC,
[ 33448 ] = ALC,
[ 33470 ] = ENG + TAIL,
[ 33567 ] = LW,
[ 33568 ] = ENG + LW,

[ 34052 ] = TAIL + ENC + ENG + JC,
[ 34054 ] = BS + ENC + TAIL + JC,
[ 34055 ] = TAIL + ENC + LW,
[ 34056 ] = ENC,
[ 34057 ] = ENC + LW,
[ 34736 ] = COOK,

[ 35622 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 35623 ] = ALC + BS + ENC + ENG + LW + JC,
[ 35624 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 35625 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,
[ 35627 ] = ALC + BS + ENG + LW + TAIL + INS + JC,
[ 35948 ] = COOK,
[ 35949 ] = COOK,

[ 36782 ] = COOK,
[ 36783 ] = TAIL + JC,
[ 36784 ] = TAIL + JC,
[ 36860 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,

[ 36901 ] = ALC,
[ 36903 ] = ALC,
[ 36904 ] = ALC,
[ 36905 ] = ALC,
[ 36906 ] = ALC,
[ 36907 ] = ALC,
[ 36908 ] = ALC + TAIL,
[ 36913 ] = ALC + BS + ENG,
[ 36916 ] = BS + ENG,
[ 36917 ] = ALC + JC,
[ 36918 ] = ALC + ENC + ENG + JC,
[ 36919 ] = TAIL + JC,
[ 36920 ] = ENG + JC,
[ 36921 ] = ALC + ENG + JC,
[ 36922 ] = ENG + TAIL + JC,
[ 36923 ] = ALC + JC,
[ 36924 ] = ALC + ENG + JC,
[ 36925 ] = BS + TAIL,
[ 36926 ] = JC,
[ 36927 ] = ALC + ENG + JC,
[ 36928 ] = JC,
[ 36929 ] = ALC + JC,
[ 36930 ] = ALC + ENG + JC,
[ 36931 ] = JC,
[ 36932 ] = ALC + JC,
[ 36933 ] = ALC + ENG + JC,
[ 36934 ] = TAIL + JC,

[ 37663 ] = BS + ENC + ENG,
[ 37700 ] = BS + LW,
[ 37701 ] = ALC + BS + ENG + TAIL + JC,
[ 37702 ] = ALC + BS + ENG + TAIL,
[ 37703 ] = ALC + BS + LW,
[ 37704 ] = ALC + TAIL,
[ 37705 ] = ALC + BS + ENC + ENG + LW,
[ 37921 ] = ALC,

[ 38425 ] = ENG + TAIL,
[ 38557 ] = LW,
[ 38558 ] = LW,
[ 38561 ] = LW,

[ 39342 ] = INS,	-- BC
[ 39343 ] = INS,
[ 39681 ] = ENG,
[ 39682 ] = ENG,
[ 39683 ] = ENG,
[ 39690 ] = ENG,

[ 40195 ] = ALC,
[ 40199 ] = ALC,
[ 40533 ] = ENG + VENDOR,
[ 40769 ] = ENG,

[ 41163 ] = BS + ENC + ENG + JC,
[ 41146 ] = ENG,
[ 41245 ] = BS,
[ 41266 ] = JC,
[ 41334 ] = JC,
[ 41355 ] = BS,
[ 41510 ] = TAIL,
[ 41511 ] = TAIL,
[ 41593 ] = TAIL,
[ 41594 ] = TAIL,
[ 41595 ] = TAIL,

[ 41800 ] = COOK,
[ 41801 ] = COOK,
[ 41802 ] = COOK,
[ 41803 ] = COOK,
[ 41805 ] = COOK,
[ 41806 ] = COOK,
[ 41807 ] = COOK,
[ 41808 ] = COOK,
[ 41809 ] = COOK,
[ 41810 ] = COOK,
[ 41812 ] = COOK,
[ 41813 ] = COOK,
[ 41814 ] = ALC,

[ 42225 ] = JC,
[ 42253 ] = TAIL,

[ 43007 ] = COOK + VENDOR,
[ 43009 ] = COOK,
[ 43010 ] = COOK,
[ 43011 ] = COOK,
[ 43012 ] = COOK,
[ 43013 ] = COOK,

[ 43102 ] = BS + ENG + LW + TAIL + INS + JC,
[ 43108 ] = INS,	-- BC
[ 43109 ] = INS,
[ 43124 ] = INS,	-- BC
[ 43125 ] = INS,	-- BC
[ 43126 ] = INS,
[ 43127 ] = INS,

[ 43501 ] = COOK,

[ 44128 ] = ENG + LW,
[ 44499 ] = ENG + VENDOR,
[ 44500 ] = ENG + VENDOR,
[ 44501 ] = ENG + VENDOR,
[ 44958 ] = ENC,

[ 45087 ] = BS + LW + TAIL,

[ 47556 ] = BS + LW + TAIL,

[ 49908 ] = BS + LW + TAIL,

-- ##### Cata items #####

[ 51950 ] = ALC + BS,

[ 52078 ] = BS + ENG + LW + TAIL,

[ 52177 ] = ALC + JC,
[ 52178 ] = ALC + BS + JC,
[ 52179 ] = ALC + ENG + JC,
[ 52180 ] = ALC + JC,
[ 52181 ] = ALC + ENG + JC,
[ 52182 ] = ALC + BS + ENG + JC,
[ 52186 ] = ALC + BS + ENG + JC,
[ 52190 ] = BS + ENG + JC,
[ 52191 ] = BS + ENG + JC,
[ 52192 ] = BS + ENG + JC,
[ 52193 ] = JC,
[ 52194 ] = JC,
[ 52195 ] = JC,
[ 52196 ] = JC,

[ 52303 ] = JC,
[ 52325 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,
[ 52326 ] = ALC + BS + ENC + LW + TAIL + INS + JC,
[ 52327 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,
[ 52328 ] = ALC + ENC + LW + TAIL + INS + JC,
[ 52329 ] = ALC + BS + ENC + LW + TAIL + INS + JC,

[ 52555 ] = ENC + TAIL + JC,

[ 52718 ] = ENC,
[ 52719 ] = ENC,
[ 52721 ] = ENC,
[ 52722 ] = ENC,

[ 52976 ] = LW,
[ 52977 ] = LW,
[ 52979 ] = LW,
[ 52980 ] = LW,
[ 52982 ] = LW,
[ 52983 ] = ALC,
[ 52984 ] = ALC,
[ 52985 ] = ALC,
[ 52986 ] = ALC,
[ 52987 ] = ALC,
[ 52988 ] = ALC,

[ 53010 ] = ENG + TAIL,
[ 53039 ] = BS + ENG,
[ 53062 ] = COOK,
[ 53063 ] = COOK,
[ 53064 ] = COOK,
[ 53065 ] = ALC,
[ 53066 ] = COOK,
[ 53067 ] = COOK,
[ 53068 ] = COOK,
[ 53069 ] = COOK,
[ 53070 ] = COOK,
[ 53071 ] = COOK,
[ 53072 ] = COOK,

[ 53643 ] = TAIL,

[ 54440 ] = TAIL,
[ 54849 ] = BS + ENG,

[ 56516 ] = BS + LW,

[ 56850 ] = ALC,

[ 58085 ] = ALC,
[ 58086 ] = ALC,
[ 58087 ] = ALC,
[ 58088 ] = ALC,
[ 58094 ] = ENC,

[ 58142 ] = ALC,

[ 58278 ] = COOK + VENDOR,

[ 58480 ] = ALC + BS + ENG + JC,

[ 52976 ] = ENG,

[ 60224 ] = ENG,
[ 60838 ] = COOK,

[ 61978 ] = INS,
[ 61979 ] = INS,
[ 61980 ] = INS,
[ 61981 ] = LW + INS,

[ 62323 ] = INS,
[ 62654 ] = ENG,
[ 62778 ] = COOK + ENG,
[ 62779 ] = COOK,
[ 62780 ] = COOK,
[ 62781 ] = COOK,
[ 62782 ] = COOK,
[ 62783 ] = COOK,
[ 62784 ] = COOK,
[ 62785 ] = COOK,
[ 62786 ] = COOK,
[ 62791 ] = COOK,

[ 65365 ] = BS,
[ 65892 ] = ALC + VENDOR,
[ 65893 ] = ALC + VENDOR,

[ 67229 ] = COOK,
[ 67319 ] = INS + VENDOR,
[ 67335 ] = INS + VENDOR,
[ 67749 ] = ENG,

[ 69237 ] = BS + LW + TAIL,

[ 71805 ] = JC,
[ 71806 ] = JC,
[ 71807 ] = JC,
[ 71808 ] = JC,
[ 71809 ] = JC,
[ 71810 ] = JC,
[ 71998 ] = BS + LW + TAIL,

-- ##### Pandaria items #####

[ 72093 ] = BS + ENG,
[ 72095 ] = ALC + BS + ENG,
[ 72096 ] = ALC + BS + ENG + INS,

[ 72104 ] = BS + ENG + JC,
[ 72120 ] = LW,
[ 72162 ] = LW,
[ 72163 ] = LW,

[ 72234 ] = ALC,
[ 72235 ] = ALC,
[ 72237 ] = ALC + INS,
[ 72238 ] = ALC,
[ 72988 ] = ENG,

[ 74247 ] = ENC,
[ 74248 ] = ENC,
[ 74249 ] = ENC,
[ 74250 ] = ENC,

[ 74642 ] = COOK,
[ 74643 ] = COOK,
[ 74644 ] = COOK,
[ 74645 ] = COOK,
[ 74646 ] = COOK,
[ 74647 ] = COOK,
[ 74648 ] = COOK,
[ 74649 ] = COOK,
[ 74650 ] = COOK,
[ 74651 ] = COOK,
[ 74652 ] = COOK,
[ 74653 ] = COOK,
[ 74654 ] = COOK,
[ 74655 ] = COOK,
[ 74656 ] = COOK,
[ 74659 ] = COOK,
[ 74660 ] = COOK,
[ 74661 ] = COOK + VENDOR,
[ 74662 ] = COOK + VENDOR,

[ 74832 ] = COOK,
[ 74833 ] = COOK,
[ 74834 ] = COOK,
[ 74837 ] = COOK,
[ 74838 ] = COOK,
[ 74839 ] = COOK,
[ 74840 ] = COOK,
[ 74841 ] = COOK,
[ 74842 ] = COOK,
[ 74843 ] = COOK,
[ 74844 ] = COOK,
[ 74845 ] = COOK,
[ 74846 ] = COOK,
[ 74847 ] = COOK,
[ 74848 ] = COOK,
[ 74849 ] = COOK,
[ 74850 ] = COOK,
[ 74851 ] = COOK,
[ 74852 ] = COOK,
[ 74853 ] = COOK + VENDOR,
[ 74854 ] = COOK,
[ 74856 ] = COOK,
[ 74857 ] = COOK,
[ 74859 ] = COOK,
[ 74860 ] = COOK,
[ 74861 ] = COOK,
[ 74863 ] = COOK,
[ 74864 ] = COOK,
[ 74865 ] = COOK,
[ 74866 ] = COOK,

[ 75014 ] = COOK,
[ 75026 ] = COOK,
[ 75037 ] = COOK,
[ 75038 ] = COOK,

[ 76061 ] = ALC + BS + ENG + LW + TAIL + INS + JC,

[ 76130 ] = ALC + JC,
[ 76131 ] = ENC + ENG + JC,
[ 76132 ] = ENG + JC,
[ 76133 ] = ALC + ENG + JC,
[ 76134 ] = ALC + JC,
[ 76135 ] = ALC + JC,
[ 76136 ] = ALC + JC,
[ 76137 ] = ALC + JC,
[ 76138 ] = ENC + ENG + JC,
[ 76139 ] = ALC + ENC + ENG + JC,
[ 76140 ] = ALC + ENC + ENG + JC,
[ 76141 ] = ALC + ENC + JC,
[ 76142 ] = ENC + ENG + JC,
[ 76734 ] = JC + VENDOR,

[ 77467 ] = BS + ENG,
[ 77468 ] = BS + ENG,
[ 77529 ] = ENG,
[ 77531 ] = ENG,

[ 79010 ] = ALC,
[ 79011 ] = ALC,
[ 79101 ] = LW,

[ 79246 ] = COOK,
[ 79250 ] = COOK,
[ 79251 ] = INS,
[ 79253 ] = INS,
[ 79254 ] = INS,
[ 79255 ] = INS,
[ 79333 ] = INS,
[ 79339 ] = INS,
[ 79342 ] = INS,

[ 79731 ] = INS,
[ 79740 ] = INS + VENDOR,

[ 80433 ] = BS + LW + TAIL,

[ 82441 ] = TAIL,
[ 82447 ] = TAIL,

[ 83064 ] = ALC,
[ 83087 ] = JC,
[ 83088 ] = JC,
[ 83089 ] = JC,
[ 83090 ] = JC,
[ 83092 ] = ENG + JC,

[ 85583 ] = COOK,
[ 85584 ] = COOK,
[ 85585 ] = COOK,

[ 87812 ] = INS,
[ 87815 ] = INS,
[ 87872 ] = ALC,

[ 88807 ] = INS,
[ 88808 ] = INS,

[ 90146 ] = ENG + VENDOR,

[ 94111 ] = BS,
[ 94113 ] = ENG,
[ 94289 ] = BS + LW + TAIL,
[ 94575 ] = BS,
[ 94576 ] = BS,
[ 94577 ] = BS,
[ 94578 ] = BS,
[ 94581 ] = BS,
[ 94582 ] = BS,
[ 94583 ] = BS,
[ 94584 ] = BS,
[ 94587 ] = BS,
[ 94588 ] = BS,
[ 94589 ] = BS,
[ 94590 ] = BS,

[ 98617 ] = LW,
[ 98619 ] = TAIL,
[ 98717 ] = BS,

[ 102218 ] = BS + LW + TAIL,

[ 102536 ] = COOK,
[ 102537 ] = COOK,
[ 102538 ] = COOK,
[ 102539 ] = COOK,
[ 102540 ] = COOK,
[ 102541 ] = COOK,
[ 102542 ] = COOK,
[ 102543 ] = COOK,

[ 112157 ] = LW,
[ 112158 ] = LW,	-- northrend
[ 112177 ] = LW,
[ 112178 ] = LW,


-- ##### WoD items #####

[ 108257 ] = BS,
[ 108996 ] = ALC,

[ 109118 ] = ALC + BS + ENG + INS + JC,
[ 109119 ] = ALC + BS + ENG + LW + TAIL + JC,
[ 109123 ] = ALC,
[ 109124 ] = ALC + COOK + INS + JC,
[ 109125 ] = ALC + COOK + INS + JC,
[ 109126 ] = ALC + COOK + LW + TAIL + INS + JC,
[ 109127 ] = ALC + COOK + INS + JC,
[ 109128 ] = ALC + COOK + ENG + INS,
[ 109129 ] = ALC + COOK + INS + JC,
[ 109131 ] = COOK,
[ 109132 ] = COOK,
[ 109133 ] = COOK,
[ 109134 ] = COOK,
[ 109135 ] = COOK,
[ 109136 ] = COOK,
[ 109137 ] = ALC + COOK,
[ 109138 ] = ALC + COOK,
[ 109139 ] = ALC + COOK,
[ 109140 ] = ALC + COOK,
[ 109141 ] = ALC + COOK,
[ 109142 ] = COOK,
[ 109143 ] = ALC + COOK,
[ 109144 ] = ALC + COOK,
[ 109145 ] = ALC,
[ 109147 ] = ALC,
[ 109148 ] = ALC,
[ 109152 ] = ALC,
[ 109217 ] = LW + TAIL,
[ 109218 ] = LW + TAIL,
[ 109219 ] = LW + TAIL,
[ 109222 ] = ALC,
[ 109223 ] = ALC,
[ 109693 ] = ENC,

[ 110609 ] = BS + LW + TAIL,
[ 110611 ] = LW,

[ 111245 ] = ENC,
[ 111366 ] = ENG,
[ 111431 ] = COOK,
[ 111433 ] = COOK,
[ 111434 ] = COOK,
[ 111436 ] = COOK,
[ 111437 ] = COOK,
[ 111438 ] = COOK,
[ 111439 ] = COOK,
[ 111441 ] = COOK,
[ 111442 ] = COOK,
[ 111444 ] = COOK,
[ 111445 ] = COOK,
[ 111446 ] = COOK,
[ 111556 ] = TAIL,
[ 111557 ] = BS + ENG + LW + TAIL,

[ 112155 ] = LW,	-- cata
[ 112156 ] = LW,	-- cata
[ 112179 ] = LW,	-- BC
[ 112180 ] = LW,	-- BC
[ 112181 ] = LW,	-- BC
[ 112182 ] = LW,	-- BC
[ 112183 ] = LW,	-- BC
[ 112184 ] = LW,	-- BC
[ 112185 ] = LW,	-- BC

[ 112377 ] = INS,

[ 113111 ] = INS,
[ 113261 ] = ALC + BS + ENC + ENG + INS + JC,
[ 113262 ] = ALC + ENC + ENG + LW + TAIL + INS + JC,
[ 113263 ] = ALC + BS + ENC + ENG + LW + TAIL + JC,
[ 113264 ] = ALC + BS + ENC + LW + TAIL + INS + JC,
[ 113588 ] = ENC + ENG,

[ 114931 ] = INS,

[ 115524 ] = JC,
[ 115803 ] = JC,
[ 115804 ] = JC,
[ 115805 ] = JC,
[ 115807 ] = JC,
[ 115808 ] = JC,
[ 115809 ] = JC,
[ 115811 ] = JC,
[ 115812 ] = JC,
[ 115814 ] = JC,
[ 115815 ] = JC,

[ 118472 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,

[ 120945 ] = ALC + BS + ENG + LW + TAIL + INS + JC,

[ 122601 ] = ALC,
[ 122602 ] = ALC,
[ 122603 ] = ALC,

[ 124669 ] = COOK,

[ 127759 ] = ALC + BS + ENG + LW + TAIL + INS + JC,

[ 128499 ] = COOK,
[ 128500 ] = COOK,




-- ##### Legion items #####

[ 123918 ] = BS + ENG + LW + TAIL + JC,
[ 123919 ] = BS + ENG + JC,

[ 124101 ] = ALC + COOK + INS,
[ 124102 ] = ALC + COOK + INS,
[ 124103 ] = ALC + COOK + INS,
[ 124104 ] = ALC + COOK + INS,
[ 124105 ] = ALC + COOK + INS,
[ 124106 ] = ALC + ENC + ENG + TAIL + INS + JC,
[ 124107 ] = COOK,
[ 124108 ] = COOK,
[ 124109 ] = COOK + ENG,
[ 124110 ] = COOK,
[ 124111 ] = COOK,
[ 124112 ] = COOK + ENG,
[ 124113 ] = BS + ENG + LW + TAIL,
[ 124115 ] = BS + ENG + LW + TAIL,
[ 124116 ] = BS + ENC + ENG + LW,
[ 124117 ] = COOK,
[ 124118 ] = COOK,
[ 124119 ] = COOK + ENG,
[ 124120 ] = COOK,
[ 124121 ] = COOK + ENG,
[ 124124 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,		-- Blood of Sargeras
[ 124436 ] = BS + VENDOR,
[ 124437 ] = BS + ENG + LW + TAIL,
[ 124438 ] = BS + LW + TAIL,
[ 124439 ] = BS + LW + TAIL,
[ 124440 ] = BS + ENC + LW + TAIL,
[ 124441 ] = ENC,
[ 124442 ] = ENC,
[ 124444 ] = ALC + BS + ENC + ENG + JC,		-- Infernal Brimstone
[ 124461 ] = BS + ENG,

[ 127004 ] = ENG + TAIL,
[ 127037 ] = TAIL + VENDOR,
[ 127681 ] = TAIL + VENDOR,
[ 127834 ] = ALC,
[ 127835 ] = ALC,
[ 127836 ] = ALC,
[ 127842 ] = ALC,
[ 127847 ] = ALC,
[ 127848 ] = ALC,
[ 127849 ] = ALC,
[ 127850 ] = ALC,

	-- Legion alc transmutes missing

[ 128304 ] = ALC + COOK + INS,

[ 129032 ] = INS,
[ 129034 ] = INS,
[ 129100 ] = COOK + JC,

[ 130172 ] = JC,
[ 130173 ] = JC,
[ 130174 ] = JC,
[ 130175 ] = JC,
[ 130176 ] = JC,
[ 130177 ] = JC,
[ 130178 ] = ENG + JC,
[ 130179 ] = BS + JC,
[ 130180 ] = LW + JC,
[ 130181 ] = JC,
[ 130182 ] = LW + JC,
[ 130183 ] = TAIL + JC,
[ 130245 ] = JC,

[ 132514 ] = ENG,
[ 132515 ] = ENG,
[ 132518 ] = ENG,
[ 132523 ] = ENG,

[ 133557 ] = COOK,
[ 133561 ] = COOK,
[ 133562 ] = COOK,
[ 133563 ] = COOK,
[ 133564 ] = COOK,
[ 133565 ] = COOK,
[ 133566 ] = COOK,
[ 133567 ] = COOK,
[ 133568 ] = COOK,
[ 133569 ] = COOK,
[ 133588 ] = COOK + VENDOR,
[ 133589 ] = COOK + VENDOR,
[ 133590 ] = COOK + VENDOR,
[ 133591 ] = COOK + VENDOR,
[ 133592 ] = COOK + VENDOR,
[ 133593 ] = COOK + VENDOR,
[ 133607 ] = COOK,
[ 133680 ] = COOK,

[ 136629 ] = ENG + VENDOR,
[ 136630 ] = ENG + VENDOR,
[ 136631 ] = ENG + VENDOR,
[ 136632 ] = ENG + VENDOR,
[ 136633 ] = ENG + VENDOR,
[ 136636 ] = ENG + VENDOR,
[ 136637 ] = ENG + VENDOR,
[ 136638 ] = ENG + VENDOR,

[ 140781 ] = ENG,
[ 140782 ] = ENG,
[ 140783 ] = ENG,
[ 140784 ] = ENG,
[ 140785 ] = ENG,

[ 142336 ] = COOK,

[ 144329 ] = ENG,

[ 146659 ] = BS + LW + TAIL + VENDOR,	-- Nethershard Essence
[ 146710 ] = TAIL,
[ 146711 ] = TAIL,
[ 146712 ] = LW,
[ 146713 ] = LW,
[ 146714 ] = BS,
[ 146757 ] = COOK,

[ 151564 ] = BS + ENG + JC,
[ 151565 ] = ALC + INS,
[ 151566 ] = LW,
[ 151567 ] = LW + TAIL,
[ 151568 ] = ALC + BS + ENG + LW + TAIL + JC,
[ 151579 ] = JC,
[ 151718 ] = JC,
[ 151719 ] = JC,
[ 151720 ] = JC,
[ 151721 ] = JC,
[ 151722 ] = JC,
[ 151931 ] = JC,
[ 151932 ] = JC,
[ 151933 ] = JC,



-- ##### BFA items #####
[ 152494 ] = ALC,
[ 152495 ] = ALC,
[ 152505 ] = ALC + INS,
[ 152506 ] = ALC + INS,
[ 152507 ] = ALC + INS,
[ 152508 ] = ALC + INS,
[ 152509 ] = ALC + INS,
[ 152510 ] = ALC + INS,
[ 152511 ] = ALC + INS,
[ 152512 ] = ALC + BS + ENG + JC,
[ 152513 ] = BS + ENG + JC,
[ 152541 ] = LW,
[ 152542 ] = LW,
[ 152543 ] = ALC + COOK,
[ 152544 ] = COOK,
[ 152545 ] = COOK,
[ 152546 ] = COOK,
[ 152547 ] = ALC + COOK,
[ 152548 ] = COOK,
[ 152549 ] = COOK,
[ 152576 ] = ALC + TAIL,
[ 152577 ] = ALC + TAIL,
[ 152579 ] = ALC + BS + ENG + JC,
[ 152631 ] = COOK,
[ 152638 ] = ALC,
[ 152639 ] = ALC,
[ 152640 ] = ALC,
[ 152641 ] = ALC,
[ 152668 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,		-- expulsom
[ 152812 ] = BS + ENC,
[ 152875 ] = ENC,
[ 152876 ] = ENC,
[ 152877 ] = ENC,

[ 153050 ] = LW,
[ 153051 ] = LW,
[ 153635 ] = INS,
[ 153636 ] = INS,
[ 153669 ] = INS,
[ 153700 ] = JC,
[ 153701 ] = JC,
[ 153702 ] = JC,
[ 153703 ] = JC,
[ 153704 ] = JC,
[ 153705 ] = JC,
[ 153706 ] = JC,

[ 154120 ] = JC,
[ 154121 ] = JC,
[ 154122 ] = JC,
[ 154123 ] = ENG + JC,
[ 154124 ] = ENG + JC,
[ 154125 ] = JC,
[ 154164 ] = ALC + LW,
[ 154165 ] = LW,
[ 154166 ] = LW,
[ 154722 ] = LW,
[ 154881 ] = COOK,
[ 154885 ] = COOK,
[ 154897 ] = ALC + COOK,
[ 154898 ] = ALC + COOK,
[ 154899 ] = COOK,

[ 156930 ] = ALC + ENC + TAIL,

[ 158186 ] = ALC + INS + VENDOR,
[ 158187 ] = INS,
[ 158188 ] = INS,
[ 158189 ] = INS,
[ 158205 ] = INS + VENDOR,
[ 158378 ] = TAIL,

[ 159959 ] = LW + TAIL + VENDOR,

[ 160059 ] = LW + VENDOR,
[ 160298 ] = BS + VENDOR,
[ 160398 ] = COOK + INS + VENDOR,
[ 160399 ] = COOK + VENDOR,
[ 160400 ] = COOK + VENDOR,
[ 160502 ] = ENG + VENDOR,
[ 160705 ] = COOK + VENDOR,
[ 160709 ] = COOK + VENDOR,
[ 160710 ] = COOK + VENDOR,
[ 160711 ] = COOK,
[ 160712 ] = COOK + INS + VENDOR,

[ 161129 ] = ENG,
[ 161131 ] = ENG + VENDOR,
[ 161132 ] = ENG,
[ 161136 ] = ENG,
[ 161137 ] = ENG,

[ 162460 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,		-- hydrocore
[ 162461 ] = ALC + BS + COOK + ENC + ENG + LW + TAIL + JC,	-- sanguicell
[ 162515 ] = COOK,
[ 162519 ] = ALC,

[ 163203 ] = ENG + VENDOR,
[ 163569 ] = ENG + VENDOR,
[ 163782 ] = COOK,

[ 165703 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,		-- breath of bwonsamdi
[ 165948 ] = ALC + BS + ENC + ENG + LW + TAIL + INS + JC,		-- tidalcore


[ 166846 ] = COOK,

[ 167562 ] = COOK,
[ 167738 ] = TAIL,

[ 168125 ] = ENC,
[ 168126 ] = ENC,
[ 168127 ] = ENC,
[ 168128 ] = TAIL,
[ 168129 ] = TAIL,
[ 168130 ] = TAIL,
[ 168131 ] = TAIL,
[ 168132 ] = JC,
[ 168133 ] = JC,
[ 168134 ] = JC,
[ 168135 ] = BS,
[ 168136 ] = BS,
[ 168137 ] = BS,
[ 168138 ] = LW,
[ 168139 ] = LW,
[ 168140 ] = INS,
[ 168142 ] = INS,
[ 168143 ] = ALC,
[ 168144 ] = ALC,
[ 168145 ] = ALC,
[ 168146 ] = ALC,
[ 168152 ] = ENG,
[ 168153 ] = ENG,
[ 168154 ] = ENG,
[ 168168 ] = INS,
[ 168185 ] = BS + JC,
[ 168188 ] = JC,
[ 168189 ] = JC,
[ 168190 ] = JC,
[ 168191 ] = JC,
[ 168192 ] = JC,
[ 168193 ] = JC,
[ 168302 ] = COOK,
[ 168303 ] = COOK,
[ 168487 ] = ALC + INS,
[ 168635 ] = JC,
[ 168645 ] = COOK,
[ 168646 ] = COOK,
[ 168649 ] = LW + TAIL,
[ 168650 ] = LW,
[ 168651 ] = ALC,
[ 168652 ] = ALC,
[ 168653 ] = ALC,
[ 168654 ] = ALC,
[ 168662 ] = INS,

[ 169610 ] = COOK,
[ 169445 ] = BS,
[ 169456 ] = LW,

[ 170553 ] = ALC + BS + ENG + LW + TAIL + JC,

[ 174327 ] = COOK,
[ 174328 ] = COOK,
[ 174353 ] = COOK,

-- Shadowlands:
[ 168583 ] = ALC + INS + LW,
[ 168586 ] = ALC + INS + LW,
[ 168589 ] = ALC + INS + LW,

[ 169701 ] = ALC + INS,

[ 170554 ] = ALC + INS + LW,

[ 171276 ] = ALC,
[ 171285 ] = ALC,
[ 171286 ] = ALC,
[ 171287 ] = ALC,
[ 171288 ] = ALC,
[ 171289 ] = ALC,
[ 171290 ] = ALC,
[ 171291 ] = ALC,
[ 171292 ] = ALC,
[ 171315 ] = ALC + INS,
[ 171428 ] = BS + JC,
[ 171828 ] = BS + ENG + JC,
[ 171829 ] = BS + ENG + JC,
[ 171830 ] = BS + ENG + JC,
[ 171831 ] = BS + ENG + JC,
[ 171832 ] = BS + ENG + JC,
[ 171833 ] = BS + ENC + ENG + JC,
[ 171840 ] = BS + ENG,
[ 171841 ] = BS + ENG,

[ 172052 ] = COOK,
[ 172053 ] = COOK,
[ 172054 ] = COOK,
[ 172055 ] = COOK,
[ 172056 ] = COOK + VENDOR,
[ 172057 ] = COOK + VENDOR,
[ 172058 ] = COOK + VENDOR,
[ 172059 ] = COOK + VENDOR,
[ 172089 ] = ENG + LW,
[ 172092 ] = ENG + LW,
[ 172093 ] = LW,
[ 172094 ] = LW,
[ 172095 ] = LW,
[ 172096 ] = LW,
[ 172097 ] = ENC + LW,
[ 172230 ] = ENC + ENG,
[ 172231 ] = ENC + ENG,
[ 172232 ] = ENC, 
[ 172437 ] = BS,
[ 172438 ] = LW,
[ 172439 ] = TAIL,
[ 172930 ] = ENG,
[ 172934 ] = ENG,
[ 172935 ] = ENG,
[ 172936 ] = ENG,
[ 172937 ] = ENG,

[ 173032 ] = COOK,
[ 173033 ] = COOK,
[ 173034 ] = COOK,
[ 173035 ] = COOK,
[ 173036 ] = COOK,
[ 173037 ] = COOK,
[ 173056 ] = INS,
[ 173057 ] = INS,
[ 173058 ] = INS,
[ 173059 ] = INS,
[ 173060 ] = INS + VENDOR,
[ 173108 ] = ENG + JC,
[ 173109 ] = ENG + JC,
[ 173110 ] = ENG + JC,
[ 173121 ] = JC,
[ 173122 ] = JC,
[ 173123 ] = JC,
[ 173124 ] = JC,
[ 173127 ] = JC,
[ 173128 ] = JC,
[ 173129 ] = JC,
[ 173130 ] = JC,
[ 173168 ] = JC + VENDOR,
[ 173170 ] = JC,
[ 173171 ] = JC,
[ 173172 ] = JC,
[ 173173 ] = JC,
[ 173202 ] = ALC + BS + ENG + TAIL,
[ 173204 ] = BS + ENC + LW + TAIL,

[ 175788 ] = INS,
[ 175970 ] = INS,

[ 177061 ] = ENC + ENG + INS + LW,
[ 177062 ] = ENG + LW + TAIL + VENDOR,
[ 177840 ] = INS,
[ 177841 ] = INS,
[ 177842 ] = INS,
[ 177843 ] = INS,

[ 178786 ] = COOK + VENDOR,
[ 178787 ] = BS + JC + LW + TAIL + VENDOR,

[ 179314 ] = COOK,
[ 179315 ] = COOK,

[ 180457 ] = ALC,
[ 180732 ] = ALC + INS + VENDOR,
[ 180733 ] = BS + ENG + VENDOR,

[ 183950 ] = ALC + VENDOR,
[ 183951 ] = ENC + ENG + VENDOR,
[ 183952 ] = ENG + VENDOR,
[ 183953 ] = INS + VENDOR,
[ 183954 ] = JC + VENDOR,
[ 183955 ] = LW + VENDOR
}

local frame = CreateFrame( "Frame" )

local previousItemID = -1
local itemIcons = ""
local iconSize

local ITEM_VENDOR_FLAG = ItemProfConstants.VENDOR_ITEM_FLAG
local ITEM_PROF_FLAGS = ItemProfConstants.ITEM_PROF_FLAGS
local NUM_PROFS_TRACKED = ItemProfConstants.NUM_PROF_FLAGS
local PROF_TEXTURES = ItemProfConstants.PROF_TEXTURES

local showProfs
local profFilter
local includeVendor

ItemProfConstants.configTooltipIconsRealm = GetRealmName()
ItemProfConstants.configTooltipIconsChar = UnitName( "player" )



local function CreateItemIcons( itemFlags )

	if not includeVendor then
		-- Return if the item has the vendor flag
		local isVendor = bit.band( itemFlags, ITEM_VENDOR_FLAG )
		if isVendor ~= 0 then
			return nil
		end
	end
	
	
	local t = {}
	
	if showProfs then
	
		local enabledFlags = bit.band( itemFlags, profFilter )
		for i=0, NUM_PROFS_TRACKED-1 do
			local bitMask = bit.lshift( 1, i )
			local isSet = bit.band( enabledFlags, bitMask )
			if isSet ~= 0 then
				t[ #t+1 ] = "|T"
				t[ #t+1 ] = PROF_TEXTURES[ bitMask ]
				t[ #t+1 ] = ":"
				t[ #t+1 ] = iconSize
				t[ #t+1 ] = "|t "
			end
		end
	end
	

	return table.concat( t )
end


local function ModifyItemTooltip( tt ) 
	
	local itemName, itemLink = tt:GetItem() 
	if not itemName then return end
	local itemID = select( 1, GetItemInfoInstant( itemName ) )
	
	if itemID == nil then
		-- Extract ID from link: GetItemInfoInstant unreliable with AH items (uncached on client?)
		itemID = tonumber( string.match( itemLink, "item:?(%d+):" ) )
		if itemID == nil then
			-- The item link doesn't contain the item ID field
			return
		end
	end
	
	-- Reuse the texture state if the item hasn't changed
	if previousItemID == itemID then
		tt:AddLine( itemIcons )
		return
	end
	
	-- Check if the item is a profession reagent
	local itemFlags = ITEM_PROF_FLAGS[ itemID ]
	if itemFlags == nil then
		-- Don't modify the tooltip
		return
	end
	
	-- Convert the flags into texture icons
	previousItemID = itemID
	itemIcons = CreateItemIcons( itemFlags )
	
	tt:AddLine( itemIcons )
end


function ItemProfConstants:ConfigChanged()

	showProfs = ShiGuangDB[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].showProfs
	profFilter = ShiGuangDB[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].profFlags
	includeVendor = ShiGuangDB[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].includeVendor
	iconSize = ShiGuangDB[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].iconSize
	
	previousItemID = -1		-- Reset line
end


local function InitFrame()

	GameTooltip:HookScript( "OnTooltipSetItem", ModifyItemTooltip )
	--ItemRefTooltip:HookScript( "OnTooltipSetItem", ModifyItemTooltip )
end


InitFrame()

local frame = CreateFrame( "Frame" )
frame.name = ITEMTOOLTIPPROFESSION_TITLE

local profsCheck
local vendorCheck
local iconSizeSlider
local iconSizeLabel
local iconDemoTexture

local PROF_CHECK = {}

local configDefaultShowProfs = true
local configDefaultProfFlags = 0x3FF
local configDefaultIncludeVendor = true
local configDefaultIconSize = 14

local userVariables

local NUM_PROFS_TRACKED = ItemProfConstants.NUM_PROF_FLAGS




local function SaveAndQuit() 

	local profFlags = 0
	-- Ignore the profession flags if master profession checkbox is unchecked
	for i=0, NUM_PROFS_TRACKED-1 do
		local bitMask = bit.lshift( 1, i )
		local isChecked = PROF_CHECK[ bitMask ]:GetChecked()
		if isChecked then
			profFlags = profFlags + bitMask
		end
	end

	
	userVariables.showProfs = profsCheck:GetChecked()
	userVariables.profFlags = profFlags
	userVariables.includeVendor = vendorCheck:GetChecked()
	userVariables.iconSize = iconSizeSlider:GetValue()

	ItemProfConstants:ConfigChanged()
end



local function ToggleProfCheckbox() 

	local isChecked = profsCheck:GetChecked()
	for k,v in pairs( PROF_CHECK ) do
		if isChecked then
			v:Enable()
		else
			v:Disable()
		end
	end
	
end


local function RefreshWidgets()

	-- Sync the widgets state with the config variables
	profsCheck:SetChecked( userVariables.showProfs )
	vendorCheck:SetChecked( userVariables.includeVendor )
	local profFlags = userVariables.profFlags
	iconSizeSlider:SetValue( userVariables.iconSize )
	
	-- Update the profession checkboxes
	for i=0, NUM_PROFS_TRACKED-1 do
		local bitMask = bit.lshift( 1, i )
		local isSet = bit.band( profFlags, bitMask )
		PROF_CHECK[ bitMask ]:SetChecked( isSet ~= 0 )
	end

	-- Set checkboxes enabled/disabled
	ToggleProfCheckbox()
end


local function IconSizeChanged( self, value ) 

	-- Called when the icon slider widget changes value
	iconDemoTexture:SetSize( value, value )
	iconSizeLabel:SetText( value )
end


local function InitVariables()
	
	local configRealm = ItemProfConstants.configTooltipIconsRealm
	local configChar = ItemProfConstants.configTooltipIconsChar

	if not ShiGuangDB[ configRealm ] then
		ShiGuangDB[ configRealm ] = {}
	end
	
	if not ShiGuangDB[ configRealm ][ configChar ] then
		ShiGuangDB[ configRealm ][ configChar ] = {}
	end
	
	userVariables = ShiGuangDB[ configRealm ][ configChar ]
	
	if userVariables.showProfs == nil then
		userVariables.showProfs = configDefaultShowProfs
	end
	
	if userVariables.profFlags == nil then
		userVariables.profFlags = configDefaultProfFlags
	end
	
	if userVariables.includeVendor == nil then
		userVariables.includeVendor = configDefaultIncludeVendor
	end
	
	if userVariables.iconSize == nil then
		userVariables.iconSize = configDefaultIconSize
	end
	
	
	RefreshWidgets()
	ItemProfConstants:ConfigChanged()
end


local function CreateCheckbox( name, x, y, label, tooltip )

	local check = CreateFrame( "CheckButton", name, frame, "ChatConfigCheckButtonTemplate" ) --"OptionsCheckButtonTemplate" )
	_G[ name .. "Text" ]:SetText( label )
	check.tooltip = tooltip
	check:SetPoint( "TOPLEFT", x, y )

	return check
end


local function CreateProfessionWidgets() 

	profsCheck = CreateCheckbox( "ItemTooltipIconsConfigCheck0", 20, -50, " Enable Profession Icons", "If enabled profession icons will be displayed on items that are crafting materials" )
	profsCheck:SetScript( "OnClick", ToggleProfCheckbox )

	-- Checkbox alignment offsets
	local x0 = 45
	local x1 = 245
	local y0 = -70
	local dy = -20

	-- undefined indices are error-prone:
	PROF_CHECK[ 1 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0a", x0, y0+dy, " Cooking", nil )
	PROF_CHECK[ 2 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0b", x1, y0+(2*dy), " First Aid", nil )
	PROF_CHECK[ 4 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0c", x0, y0, " Alchemy", nil )
	PROF_CHECK[ 8 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0d", x1, y0, " Blacksmithing", nil )
	PROF_CHECK[ 16 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0e", x1, y0+dy, " Enchanting", nil )
	PROF_CHECK[ 32 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0f", x0, y0+(2*dy), " Engineering", nil )
	PROF_CHECK[ 64 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0g", x0, y0+(4*dy), " Leatherworking", nil )
	PROF_CHECK[ 128 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0h", x1, y0+(4*dy), " Tailoring", nil )
	PROF_CHECK[ 256 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0i", x0, y0+(3*dy), " Inscription", nil )
	PROF_CHECK[ 512 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0j", x1, y0+(3*dy), " Jewelcrafting", nil )
	
	vendorCheck = CreateCheckbox( "ItemTooltipIconsConfigCheck2", 20, -200, " Vendor Items", "Display icons on items sold by vendors" )
end


local function CreateIconResizeWidgets()

	iconSizeSlider = CreateFrame( "Slider", "ItemTooltipIconsConfigSlider0", frame, "OptionsSliderTemplate" )
	iconSizeSlider:SetPoint( "TOPLEFT", 20, -300 )
	iconSizeSlider:SetMinMaxValues( 8, 32 )
	iconSizeSlider:SetValueStep( 1 )
	iconSizeSlider:SetStepsPerPage( 1 )
	iconSizeSlider:SetWidth( 200 )
	iconSizeSlider:SetObeyStepOnDrag( true )
	iconSizeSlider:SetScript( "OnValueChanged", IconSizeChanged )
	_G[ "ItemTooltipIconsConfigSlider0Text" ]:SetText( "Icon Size" )
	_G[ "ItemTooltipIconsConfigSlider0Low" ]:SetText( nil )
	_G[ "ItemTooltipIconsConfigSlider0High" ]:SetText( nil )

	iconSizeLabel = frame:CreateFontString( nil, "OVERLAY", "GameTooltipText" )
	iconSizeLabel:SetFont( "Fonts\\FRIZQT__.TTF", 12, "THINOUTLINE" )
	iconSizeLabel:SetPoint( "TOPLEFT", 225, -302 )

	iconDemoTexture = frame:CreateTexture( nil, "OVERLAY" )
	iconDemoTexture:SetPoint( "TOPLEFT", 300, -300 )
	iconDemoTexture:SetTexture( GetSpellTexture( 4036 ) )
end


local dialogHeader = frame:CreateFontString( nil, "OVERLAY", "GameTooltipText" )
dialogHeader:SetFont( "Fonts\\FRIZQT__.TTF", 10, "THINOUTLINE" )
dialogHeader:SetPoint( "TOPLEFT", 20, -20 )
dialogHeader:SetText( "These options allow you control which icons are displayed on the item tooltips." )


CreateProfessionWidgets()
CreateIconResizeWidgets()




frame.okay = SaveAndQuit
frame:SetScript( "OnShow", RefreshWidgets )
frame:SetScript( "OnEvent", InitVariables )
frame:RegisterEvent( "VARIABLES_LOADED" )


InterfaceOptions_AddCategory( frame )