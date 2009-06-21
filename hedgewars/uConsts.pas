(*
 * Hedgewars, a free turn based strategy game
 * Copyright (c) 2004-2008 Andrey Korotaev <unC0Rr@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 *)

unit uConsts;
interface

uses 
	SDLh,
{$IFDEF GLES11}
	gles11,
{$ELSE}
	GL,
{$ENDIF}
	uLocale;

{$INCLUDE options.inc}
{$INCLUDE proto.inc}
type

	TGameState = (gsLandGen, gsStart, gsGame, gsChat, gsConfirm, gsExit);

	TGameType = (gmtLocal, gmtDemo, gmtNet, gmtSave, gmtLandPreview);

	TPathType = (ptNone, ptData, ptGraphics, ptThemes, ptCurrTheme, ptTeams, ptMaps,
			ptMapCurrent, ptDemos, ptSounds, ptGraves, ptFonts, ptForts,
			ptLocale, ptAmmoMenu, ptHedgehog, ptVoices, ptHats);

	TSprite = (sprWater, sprCloud, sprBomb, sprBigDigit, sprFrame,
			sprLag, sprArrow, sprGrenade, sprTargetP, sprUFO,
			sprSmokeTrace, sprRopeHook, sprExplosion50, sprMineOff,
			sprMineOn, sprCase, sprFAid, sprDynamite, sprPower,
			sprClusterBomb, sprClusterParticle, sprFlame, sprHorizont,
			sprSky, sprAMBorders, sprAMSlot, sprAMSlotName, sprAMAmmos,
			sprAMSlotKeys, sprAMSelection, sprFinger, sprAirBomb,
			sprAirplane, sprAmAirplane, sprAmGirder, sprHHTelepMask,
			sprSwitch, sprParachute, sprTarget, sprRopeNode,
			sprQuestion, sprPowerBar, sprWindBar, sprWindL, sprWindR,
			sprFlake, sprHandRope, sprHandBazooka, sprHandShotgun,
			sprHandDEagle, sprHandAirAttack, sprHandBaseball, sprPHammer,
			sprHandBlowTorch, sprBlowTorch, sprTeleport, sprHHDeath,
			sprShotgun, sprDEagle, sprHHIdle, sprMortar, sprTurnsLeft,
			sprKamikaze, sprWhip, sprKowtow, sprSad, sprWave,
			sprHurrah, sprLemonade, sprShrug, sprJuggle, sprExplPart, sprExplPart2,
			sprCakeWalk, sprCakeDown, sprAMAmmosBW, sprWatermelon,
			sprEvilTrace, sprHellishBomb, sprSeduction, sprDress,
			sprCensored, sprDrill, sprHandDrill, sprHandBallgun, sprBalls,
			sprPlane, sprHandPlane, sprUtility, sprInvulnerable, sprVampiric, sprGirder, 
            sprSpeechCorner, sprSpeechEdge, sprSpeechTail, 
            sprThoughtCorner, sprThoughtEdge, sprThoughtTail, 
            sprShoutCorner, sprShoutEdge, sprShoutTail,
            sprSniperRifle, sprBubbles);

	TGearType = (gtAmmo_Bomb, gtHedgehog, gtAmmo_Grenade, gtHealthTag, // 3
			gtGrave, gtUFO, gtShotgunShot, gtPickHammer, gtRope, // 8
			gtSmokeTrace, gtExplosion, gtMine, gtCase, gtDEagleShot, gtDynamite, // 14
			gtClusterBomb, gtCluster, gtShover, gtFlame, // 18
			gtFirePunch, gtATStartGame, gtATSmoothWindCh, gtATFinishGame, // 24
			gtParachute, gtAirAttack, gtAirBomb, gtBlowTorch, gtGirder, // 27
			gtTeleport, gtSwitcher, gtTarget, gtMortar, // 31
			gtWhip, gtKamikaze, gtCake, gtSeduction, gtWatermelon, gtMelonPiece, // 37
			gtHellishBomb, gtEvilTrace, gtWaterUp, gtDrill, gtBallGun, gtBall,gtRCPlane,
			gtSniperRifleShot, gtJetpack);

	TVisualGearType = (vgtFlake, vgtCloud, vgtExplPart, vgtExplPart2, vgtFire,
			vgtSmallDamageTag, vgtTeamHealthSorter, vgtSpeechBubble, vgtBubble,
			vgtSteam);

	TGearsType = set of TGearType;

	TSound = (sndGrenadeImpact, sndExplosion, sndThrowPowerUp, sndThrowRelease,
			sndSplash, sndShotgunReload, sndShotgunFire, sndGraveImpact,
			sndMineTick, sndPickhammer, sndGun, sndUFO, sndJump1, sndJump2,
			sndJump3, sndYesSir, sndLaugh, sndIllGetYou, sndIncoming,
			sndMissed, sndStupid, sndFirstBlood, sndBoring, sndByeBye,
			sndSameTeam, sndNutter, sndReinforce, sndTraitor, sndRegret,
			sndEnemyDown, sndCoward, sndHurry, sndWatchIt, sndKamikaze,
			sndCake, sndOw1, sndOw4, sndFirePunch1, sndFirePunch2,
			sndFirePunch3, sndFirePunch4, sndFirePunch5, sndFirePunch6,
			sndMelon, sndHellish, sndYoohoo, sndRCPlane, sndWhipCrack,
			sndRideOfTheValkyries, sndDenied, sndPlaced, sndBaseballBat, sndVaporize);

	TAmmoType  = (amGrenade, amClusterBomb, amBazooka, amUFO, amShotgun, amPickHammer,
			amSkip, amRope, amMine, amDEagle, amDynamite, amFirePunch, amWhip,
			amBaseballBat, amParachute, amAirAttack, amMineStrike, amBlowTorch,
			amGirder, amTeleport, amSwitch, amMortar, amKamikaze, amCake,
			amSeduction, amWatermelon, amHellishBomb, amNapalm, amDrill, amBallgun, 
            amRCPlane, amLowGravity, amExtraDamage, amInvulnerable, amExtraTime,
            amLaserSight, amVampiric, amSniperRifle, amJetpack);

	THWFont = (fnt16, fntBig, fntSmall);

	TCapGroup = (capgrpGameState, capgrpAmmoinfo, capgrpVolume,
			capgrpMessage);

	TStatInfoType = (siGameResult, siMaxStepDamage, siMaxStepKills, siKilledHHs,
			siClanHealth);

	TWave = (waveRollup, waveSad,waveWave, waveHurrah, waveLemonade, waveShrug, waveJuggle);

	THHFont = record
			Handle: PTTF_Font;
			Height: LongInt;
			style: LongInt;
			Name: string[21];
			end;

	PAmmo = ^TAmmo;
	TAmmo = record
			Propz: LongWord;
			Count: LongWord;
			NumPerTurn: LongWord;
			Timer: LongWord;
			Pos: LongWord;
			AmmoType: TAmmoType;
			end;

	TVertex2f = record
		X, Y: GLfloat;
		end;
			
	TTexture = record
			id: GLuint;
			w, h: LongInt;
			rx, ry: GLfloat;
			vb, tb: array [0..3] of TVertex2f;
			end;
	PTexture = ^TTexture;

const
	errmsgCreateSurface   = 'Error creating SDL surface';
	errmsgTransparentSet  = 'Error setting transparent color';
	errmsgUnknownCommand  = 'Unknown command';
	errmsgUnknownVariable = 'Unknown variable';
	errmsgIncorrectUse    = 'Incorrect use';
	errmsgShouldntRun     = 'This program shouldn''t be run manually';
	errmsgWrongNumber     = 'Wrong parameters number';

	msgLoading           = 'Loading ';
	msgOK                = 'ok';
	msgFailed            = 'failed';
	msgFailedSize        = 'failed due to size';
	msgGettingConfig     = 'Getting game config...';

const
	ifNone        = $00000000;
	ifAlpha       = $00000001;
	ifCritical    = $00000002;
	ifTransparent = $00000004;
	ifIgnoreCaps  = $00000008;
	
const
	cMaxPower     = 1500;
	cMaxAngle     = 2048;
	cPowerDivisor = 1500;

	MAXNAMELEN = 192;

    LAND_WIDTH = 4096;
    LAND_HEIGHT = 2048;
    LAND_WIDTH_MASK  = $FFFFF000;
    LAND_HEIGHT_MASK = $FFFFF800;

	COLOR_LAND           = $FFFFFFFF;  // white
	COLOR_INDESTRUCTIBLE = $FF0000FF;  // red

    GL_BGR = $80E0; // some opengl headers do not have these macros
	GL_BGRA = $80E1;

	cifRandomize = $00000001;
	cifTheme     = $00000002;
	cifMap       = $00000002; // either theme or map (or map+theme)
	cifAllInited = cifRandomize or
					cifTheme or
					cifMap;

	cTransparentColor: Longword = $000000;

	cMaxTeams        = 6;
	cMaxHHIndex      = 7;
	cMaxHHs          = 48;
	cMaxSpawnPoints  = 1024;

	cMaxEdgePoints = 16384;

	cHHRadius = 9;
	cHHStepTicks = 29;

	cUsualZ = 500;
	cSmokeZ = 499;
	cHHZ = 1000;
	cCurrHHZ = Succ(cHHZ);
	cOnHHZ = 2000;

	cShotgunRadius = 22;
	cBlowTorchC    = 6;

	cKeyMaxIndex = 1023;

	cMaxCaptions = 4;

	gfForts        = $00000001;
	gfMultiWeapon  = $00000002;
	gfSolidLand    = $00000004;
	gfBorder       = $00000008;
	gfDivideTeams  = $00000010;
	gfLowGravity   = $00000020;
	gfLaserSight   = $00000040;
	gfInvulnerable = $00000080;
	gfMines        = $00000100;
	gfVampiric     = $00000200;
	gfKarma        = $00000400;
	gfArtillery    = $00000800;
	gfOneClanMode  = $10000000;

	gstDrowning       = $00000001;
	gstHHDriven       = $00000002;
	gstMoving         = $00000004;
	gstAttacked       = $00000008;
	gstAttacking      = $00000010;
	gstCollision      = $00000020;
	gstHHChooseTarget = $00000040;
	gstHHJumping      = $00000100;
	gsttmpFlag        = $00000200;
	gstHHThinking     = $00000800;
	gstNoDamage       = $00001000;
	gstHHHJump        = $00002000;
	gstAnimation      = $00004000;
	gstHHDeath        = $00008000;
	gstWinner         = $00010000;  // this, along with gstLoser, is good for indicating hedgies know they screwed up
	gstWait           = $00020000;
	gstNotKickable    = $00040000;
	gstLoser          = $00080000;

	gm_Left   = $00000001;
	gm_Right  = $00000002;
	gm_Up     = $00000004;
	gm_Down   = $00000008;
	gm_Switch = $00000010;
	gm_Attack = $00000020;
	gm_LJump  = $00000040;
	gm_HJump  = $00000080;
	gm_Destroy= $00000100;
	gm_Slot   = $00000200; // with param
	gm_Weapon = $00000400; // with param
	gm_Timer  = $00000800; // with param
	gm_Animate= $00001000; // with param
	gm_Precise= $00002000;
	gmAllStoppable = gm_Left or gm_Right or gm_Up or gm_Down or gm_Attack or gm_Precise;

	cMaxSlotIndex       = 8;
	cMaxSlotAmmoIndex   = 4;

	ammoprop_Timerable    = $00000001;
	ammoprop_Power        = $00000002;
	ammoprop_NeedTarget   = $00000004;
	ammoprop_ForwMsgs     = $00000008;
	ammoprop_AttackInMove = $00000010;
	ammoprop_NoCrosshair  = $00000040;
	ammoprop_AttackingPut = $00000080;
	ammoprop_DontHold     = $00000100;
	ammoprop_AltAttack    = $00000200;
	ammoprop_AltUse       = $00000400;
	ammoprop_NotBorder    = $00000800;
	ammoprop_Utility      = $00001000;

	AMMO_INFINITE = 9;

	EXPLAllDamageInRadius = $00000001;
	EXPLAutoSound         = $00000002;
	EXPLNoDamage          = $00000004;
	EXPLDoNotTouchHH      = $00000008;
	EXPLDontDraw          = $00000010;

	posCaseAmmo    = $00000001;
	posCaseHealth  = $00000002;
	posCaseUtility = $00000004;

	NoPointX = Low(LongInt);

	cHHFileName   = 'Hedgehog';
	cCHFileName   = 'Crosshair';
	cThemeCFGFilename = 'theme.cfg';

	Fontz: array[THWFont] of THHFont = (
			(Handle: nil;
			Height: 12;
			style: TTF_STYLE_NORMAL;
			Name: 'DejaVuSans-Bold.ttf'),
			(Handle: nil;
			Height: 24;
			style: TTF_STYLE_NORMAL;
			Name: 'DejaVuSans-Bold.ttf'),
			(Handle: nil;
			Height: 10;
			style: TTF_STYLE_NORMAL;
			Name: 'DejaVuSans-Bold.ttf')
			);

	FontzCJK: array[THWFont] of THHFont = (
			(Handle: nil;
			Height: 12;
			style: TTF_STYLE_NORMAL;
			Name: 'DroidSansFallback.ttf'),
			(Handle: nil;
			Height: 24;
			style: TTF_STYLE_NORMAL;
			Name: 'DroidSansFallback.ttf'),
			(Handle: nil;
			Height: 10;
			style: TTF_STYLE_NORMAL;
			Name: 'DroidSansFallback.ttf')
			);

	FontBorder = 2;

	PathPrefix: string = './';
	Pathz: array[TPathType] of String = (
			'',                              // ptNone
			'',                              // ptData
			'Graphics',                      // ptGraphics
			'Themes',                        // ptThemes
			'Themes/avematan',               // ptCurrTheme
			'Teams',                         // ptTeams
			'Maps',                          // ptMaps
			'',                              // ptMapCurrent
			'Demos',                         // ptDemos
			'Sounds',                        // ptSounds
			'Graphics/Graves',               // ptGraves
			'Fonts',                         // ptFonts
			'Forts',                         // ptForts
			'Locale',                        // ptLocale
			'Graphics/AmmoMenu',             // ptAmmoMenu
			'Graphics/Hedgehog',             // ptHedgehog
			'Sounds/voices',                 // ptVoices
			'Graphics/Hats'                  // ptHats
			);

	SpritesData: array[TSprite] of record
			FileName: String[14];
			Path, AltPath: TPathType;
			Texture: PTexture;
			Surface: PSDL_Surface;
			Width, Height: LongInt;
			saveSurf: boolean;
			end = (
			(FileName:  'BlueWater'; Path: ptCurrTheme;AltPath: ptGraphics; Texture: nil; Surface: nil;
			Width: 0; Height: 0; saveSurf: false),// sprWater
			(FileName:     'Clouds'; Path: ptCurrTheme;AltPath: ptGraphics; Texture: nil; Surface: nil;
			Width: 256; Height:128; saveSurf: false),// sprCloud
			(FileName:       'Bomb'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   8; Height:  8; saveSurf: false),// sprBomb
			(FileName:  'BigDigits'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprBigDigit
			(FileName:      'Frame'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   4; Height: 32; saveSurf: false),// sprFrame
			(FileName:        'Lag'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  65; Height: 65; saveSurf: false),// sprLag
			(FileName:      'Arrow'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprCursor
			(FileName:    'Grenade'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprGrenade
			(FileName:    'Targetp'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprTargetP
			(FileName:        'UFO'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprUFO
			(FileName: 'SmokeTrace'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprSmokeTrace
			(FileName:   'RopeHook'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprRopeHook
			(FileName:     'Expl50'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprExplosion50
			(FileName:    'MineOff'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   8; Height:  8; saveSurf: false),// sprMineOff
			(FileName:     'MineOn'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   8; Height:  8; saveSurf: false),// sprMineOn
			(FileName:       'Case'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  48; Height: 48; saveSurf: false),// sprCase
			(FileName:   'FirstAid'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  48; Height: 48; saveSurf: false),// sprFAid
			(FileName:   'dynamite'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprDynamite
			(FileName:      'Power'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprPower
			(FileName:     'ClBomb'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprClusterBomb
			(FileName: 'ClParticle'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprClusterParticle
			(FileName:      'Flame'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprFlame
			(FileName:   'horizont'; Path: ptCurrTheme;AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   0; Height:  0; saveSurf: false),// sprHorizont
			(FileName:        'Sky'; Path: ptCurrTheme;AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   0; Height:  0; saveSurf: false),// sprSky
			(FileName:  'BrdrLines'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 202; Height:  1; saveSurf: false),// sprAMBorders
			(FileName:       'Slot'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 202; Height: 33; saveSurf: false),// sprAMSlot
			(FileName:   'AmmoName'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 202; Height: 33; saveSurf: false),// sprAMSlotName
			(FileName:      'Ammos'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprAMAmmos
			(FileName:   'SlotKeys'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprAMSlotKeys
			(FileName:  'Selection'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprAMSelection
			(FileName:     'Finger'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 48; saveSurf: false),// sprFinger
			(FileName:    'AirBomb'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprAirBomb
			(FileName:   'Airplane'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 254; Height: 101; saveSurf: false),// sprAirplane
			(FileName: 'amAirplane'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 32; saveSurf: false),// sprAmAirplane
			(FileName:   'amGirder'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 160; Height:160; saveSurf:  true),// sprAmGirder
			(FileName:     'hhMask'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf:  true),// sprHHTelepMask
			(FileName:     'Switch'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprSwitch
			(FileName:  'Parachute'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  48; Height: 48; saveSurf: false),// sprParachute
			(FileName:     'Target'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprTarget
			(FileName:   'RopeNode'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:   6; Height:  6; saveSurf: false),// sprRopeNode
			(FileName:   'thinking'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprQuestion
			(FileName:   'PowerBar'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 256; Height: 32; saveSurf: false),// sprPowerBar
			(FileName:    'WindBar'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 151; Height: 17; saveSurf: false),// sprWindBar
			(FileName:      'WindL'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  80; Height: 13; saveSurf: false),// sprWindL
			(FileName:      'WindR'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  80; Height: 13; saveSurf: false),// sprWindR
			(FileName:      'Flake'; Path:ptCurrTheme; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprFlake
			(FileName:     'amRope'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHandRope
			(FileName:  'amBazooka'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHandBazooka
			(FileName:  'amShotgun'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprHandShotgun
			(FileName:   'amDEagle'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprHandDEagle
			(FileName:'amAirAttack'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHandAirAttack
			(FileName: 'amBaseball'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHandBaseball
			(FileName:     'Hammer'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 64; saveSurf: false),// sprPHammer
			(FileName: 'amBTorch_i'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHandBlowTorch
			(FileName: 'amBTorch_w'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprBlowTorch
			(FileName:   'Teleport'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 32; saveSurf: false),// sprTeleport
			(FileName:    'HHDeath'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 64; saveSurf: false),// sprHHDeath
			(FileName:'amShotgun_w'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprShotgun
			(FileName: 'amDEagle_w'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprDEagle
			(FileName:       'Idle'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHHIdle
			(FileName:     'Mortar'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprMortar
			(FileName:  'TurnsLeft'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprTurnsLeft
			(FileName: 'amKamikaze'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 256; Height: 32; saveSurf: false),// sprKamikaze
			(FileName:     'amWhip'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 128; Height: 32; saveSurf: false),// sprWhip
			(FileName:     'Kowtow'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprKowtow
			(FileName:        'Sad'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprSad
			(FileName:       'Wave'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 32; saveSurf: false),// sprWave
			(FileName:     'Hurrah'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHurrah
			(FileName:'ILoveLemonade';Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 128; Height: 32; saveSurf: false),// sprLemonade
			(FileName:      'Shrug'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 32;  Height: 32; saveSurf: false),// sprShrug
			(FileName:     'Juggle'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 32;  Height: 32; saveSurf: false),// sprJuggle
			(FileName:   'ExplPart'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprExplPart
			(FileName:  'ExplPart2'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprExplPart2
			(FileName:  'Cake_walk'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprCakeWalk
			(FileName:  'Cake_down'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprCakeDown
			(FileName:   'Ammos_bw'; Path: ptAmmoMenu; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprAMAmmosBW
			(FileName: 'Watermelon'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprWatermelon
			(FileName:  'EvilTrace'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprEvilTrace
			(FileName:'HellishBomb'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprHellishBomb
			(FileName:  'Seduction'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprSeduction
			(FileName:    'HHDress'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprDress
			(FileName:   'Censored'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 16; saveSurf: false),// sprCensored
			(FileName:      'Drill'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false),// sprDrill
			(FileName:    'amDrill'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprHandDrill
			(FileName:  'amBallgun'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  64; Height: 64; saveSurf: false),// sprHandBallgun
			(FileName:      'Balls'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 20; saveSurf: false),// sprBalls
			(FileName:    'RCPlane'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false),// sprPlane
			(FileName:  'amRCPlane'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  32; Height: 32; saveSurf: false), // sprHandPlane
			(FileName:    'Utility'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  48; Height: 48; saveSurf: false), // sprUtility
			(FileName:'Invulnerable';Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  48; Height: 48; saveSurf: false), // sprInvulnerable
			(FileName:   'Vampiric'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  48; Height: 48; saveSurf: false), // sprVampiric
			(FileName:   'amGirder'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 512; Height:512; saveSurf: false), // sprGirder
			(FileName:'SpeechCorner';Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  12; Height: 9; saveSurf:  true), // sprSpeechCorner
			(FileName: 'SpeechEdge'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  25; Height: 9; saveSurf:  true), // sprSpeechEdge
			(FileName: 'SpeechTail'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  25; Height: 26; saveSurf: true), // sprSpeechTail
			(FileName:'ThoughtCorner';Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  49; Height: 37; saveSurf: true), // sprThoughtCorner
			(FileName:'ThoughtEdge'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  23; Height: 16; saveSurf: true), // sprThoughtEdge
			(FileName:'ThoughtTail'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  45; Height: 65; saveSurf: true), // sprThoughtTail
			(FileName:'ShoutCorner'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  34; Height: 23; saveSurf: true), // sprShoutCorner
			(FileName:  'ShoutEdge'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  30; Height: 20; saveSurf: true), // sprShoutEdge
			(FileName:  'ShoutTail'; Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  30; Height: 37; saveSurf: true), // sprShoutTail
			(FileName:'amSniperRifle';Path: ptHedgehog; AltPath: ptNone; Texture: nil; Surface: nil;
			Width: 128; Height: 32; saveSurf: false), // sprSniperRifle
			(FileName:    'Bubbles'; Path: ptGraphics; AltPath: ptNone; Texture: nil; Surface: nil;
			Width:  16; Height: 16; saveSurf: false) // sprBubbles
			);

	Wavez: array [TWave] of record
			Sprite: TSprite;
			FramesCount: Longword;
			Interval: Longword;
			cmd: String[20];
			end = (
			(Sprite:   sprKowtow; FramesCount: 12; Interval: 125; cmd: '/rollup'),
			(Sprite:      sprSad; FramesCount: 14; Interval: 125; cmd: '/sad'),
			(Sprite:     sprWave; FramesCount: 16; Interval: 125; cmd: '/wave'),
			(Sprite:   sprHurrah; FramesCount: 14; Interval: 125; cmd: '/hurrah'),
			(Sprite: sprLemonade; FramesCount: 24; Interval: 125; cmd: '/ilovelotsoflemonade'),
			(Sprite:    sprShrug; FramesCount: 24; Interval: 125; cmd: '/shrug'),
			(Sprite:   sprJuggle; FramesCount: 49; Interval:  38; cmd: '/juggle')
			);

	Soundz: array[TSound] of record
			FileName: String[25];
			Path    : TPathType;
			end = (
			(FileName:        'grenadeimpact.ogg'; Path: ptSounds),// sndGrenadeImpact
			(FileName:            'explosion.ogg'; Path: ptSounds),// sndExplosion
			(FileName:         'throwpowerup.ogg'; Path: ptSounds),// sndThrowPowerUp
			(FileName:         'throwrelease.ogg'; Path: ptSounds),// sndThrowRelease
			(FileName:               'splash.ogg'; Path: ptSounds),// sndSplash
			(FileName:        'shotgunreload.ogg'; Path: ptSounds),// sndShotgunReload
			(FileName:          'shotgunfire.ogg'; Path: ptSounds),// sndShotgunFire
			(FileName:          'graveimpact.ogg'; Path: ptSounds),// sndGraveImpact
			(FileName:             'minetick.ogg'; Path: ptSounds),// sndMineTicks
			(FileName:           'pickhammer.ogg'; Path: ptSounds),// sndPickhammer
			(FileName:                  'gun.ogg'; Path: ptSounds),// sndGun
			(FileName:                  'ufo.ogg'; Path: ptSounds),// sndUFO
			(FileName:                'Jump1.ogg'; Path: ptVoices),// sndJump1
			(FileName:                'Jump2.ogg'; Path: ptVoices),// sndJump2
			(FileName:                'Jump3.ogg'; Path: ptVoices),// sndJump3
			(FileName:               'Yessir.ogg'; Path: ptVoices),// sndYesSir
			(FileName:                'Laugh.ogg'; Path: ptVoices),// sndLaugh
			(FileName:            'Illgetyou.ogg'; Path: ptVoices),// sndIllGetYou
			(FileName:             'Incoming.ogg'; Path: ptVoices),// sndIncoming
			(FileName:               'Missed.ogg'; Path: ptVoices),// sndMissed
			(FileName:               'Stupid.ogg'; Path: ptVoices),// sndStupid
			(FileName:           'Firstblood.ogg'; Path: ptVoices),// sndFirstBlood
			(FileName:               'Boring.ogg'; Path: ptVoices),// sndBoring
			(FileName:               'Byebye.ogg'; Path: ptVoices),// sndByeBye
			(FileName:             'Sameteam.ogg'; Path: ptVoices),// sndSameTeam
			(FileName:               'Nutter.ogg'; Path: ptVoices),// sndNutter
			(FileName:       'Reinforcements.ogg'; Path: ptVoices),// sndReinforce
			(FileName:              'Traitor.ogg'; Path: ptVoices),// sndTraitor
			(FileName:      'Youllregretthat.ogg'; Path: ptVoices),// sndRegret
			(FileName:            'Enemydown.ogg'; Path: ptVoices),// sndEnemyDown
			(FileName:               'Coward.ogg'; Path: ptVoices),// sndCoward
			(FileName:                'Hurry.ogg'; Path: ptVoices),// sndHurry
			(FileName:              'Watchit.ogg'; Path: ptVoices),// sndWatchIt
			(FileName:             'Kamikaze.ogg'; Path: ptVoices),// sndKamikaze
			(FileName:                'cake2.ogg'; Path: ptSounds),// sndCake
			(FileName:                  'Ow1.ogg'; Path: ptVoices),// sndOw1
			(FileName:                  'Ow4.ogg'; Path: ptVoices),// sndOw4
			(FileName:           'Firepunch1.ogg'; Path: ptVoices),// sndFirepunch1
			(FileName:           'Firepunch2.ogg'; Path: ptVoices),// sndFirepunch2
			(FileName:           'Firepunch3.ogg'; Path: ptVoices),// sndFirepunch3
			(FileName:           'Firepunch4.ogg'; Path: ptVoices),// sndFirepunch4
			(FileName:           'Firepunch5.ogg'; Path: ptVoices),// sndFirepunch5
			(FileName:           'Firepunch6.ogg'; Path: ptVoices),// sndFirepunch6
			(FileName:                'Melon.ogg'; Path: ptSounds),// sndMelon
			(FileName:              'Hellish.ogg'; Path: ptSounds),// sndHellish
			(FileName:               'Yoohoo.ogg'; Path: ptSounds),// sndYoohoo
			(FileName:              'rcplane.ogg'; Path: ptSounds),// sndRCPlane
			(FileName:            'whipcrack.ogg'; Path: ptSounds),// sndWhipCrack
			(FileName:'ride_of_the_valkyries.ogg'; Path: ptSounds),// sndRideOfTheValkyries
			(FileName:               'denied.ogg'; Path: ptSounds),// sndDenied
			(FileName:               'placed.ogg'; Path: ptSounds),// sndPlaced
			(FileName:          'baseballbat.ogg'; Path: ptSounds),// sndBaseballBat
			(FileName:                'steam.ogg'; Path: ptSounds) // sndVaporize
			);

	Ammoz: array [TAmmoType] of record
			NameId: TAmmoStrId;
			NameTex: PTexture;
			Probability, NumberInCase: Longword;
			Ammo: TAmmo;
			Slot: 0..cMaxSlotIndex;
			TimeAfterTurn: Longword;
			minAngle, maxAngle: Longword;
			isDamaging: boolean;
			SkipTurns: Longword;
			PosCount: Longword;
			PosSprite: TSprite;
			end = (
			(NameId: sidGrenade;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_Timerable or
							ammoprop_Power or
							ammoprop_AltUse;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 3000;
					Pos: 0;
					AmmoType: amGrenade);
			Slot: 1;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidClusterBomb;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 3;
			Ammo: (Propz: ammoprop_Timerable or
							ammoprop_Power or
							ammoprop_AltUse;
					Count: 5;
					NumPerTurn: 0;
					Timer: 3000;
					Pos: 0;
					AmmoType: amClusterBomb);
			Slot: 1;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidBazooka;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_Power or
							ammoprop_AltUse;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amBazooka);
			Slot: 0;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidUFO;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_Power or
							ammoprop_NeedTarget or
							ammoprop_DontHold;
					Count: 2;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amUFO);
			Slot: 0;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidShotgun;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs;
					Count: AMMO_INFINITE;
					NumPerTurn: 1;
					Timer: 0;
					Pos: 0;
					AmmoType: amShotgun);
			Slot: 2;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidPickHammer;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_AttackInMove or
							ammoprop_NoCrosshair or
							ammoprop_DontHold;
					Count: 2;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amPickHammer);
			Slot: 6;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidSkip;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_DontHold;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amSkip);
			Slot: 8;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidRope;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 3;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_AttackInMove or
							ammoprop_DontHold or
							ammoprop_AltAttack;
					Count: 5;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amRope);
			Slot: 7;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: cMaxAngle div 2;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidMine;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_AttackInMove or
							ammoprop_DontHold or
							ammoprop_AltUse;
					Count: 2;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amMine);
			Slot: 4;
			TimeAfterTurn: 5000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidDEagle;
			NameTex: nil;
			Probability: 20;
			NumberInCase: 2;
			Ammo: (Propz: 0;
					Count: 3;
					NumPerTurn: 3;
					Timer: 0;
					Pos: 0;
					AmmoType: amDEagle);
			Slot: 2;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidDynamite;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_AttackInMove or
							ammoprop_DontHold or
							ammoprop_AltUse;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amDynamite);
			Slot: 4;
			TimeAfterTurn: 5000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidFirePunch;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_ForwMsgs or
							ammoprop_AttackInMove;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amFirePunch);
			Slot: 3;
			TimeAfterTurn: 3000;
			MinAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidWhip;
			NameTex: nil;
			Probability: 0;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amWhip);
			Slot: 3;
			TimeAfterTurn: 3000;
			MinAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidBaseballBat;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_DontHold;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amBaseballBat);
			Slot: 3;
			TimeAfterTurn: 5000;
			minAngle: 0;
			maxAngle: cMaxAngle div 2;
			isDamaging: true;
			SkipTurns: 2;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidParachute;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_AttackInMove or
							ammoprop_NoCrosshair or
							ammoprop_DontHold or
							ammoprop_AltAttack;
					Count: 2;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amParachute);
			Slot: 7;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidAirAttack;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_NeedTarget or
							ammoprop_AttackingPut or
							ammoprop_DontHold or
							ammoprop_NotBorder;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amAirAttack);
			Slot: 5;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 5;
			PosCount: 2;
			PosSprite: sprAmAirplane),
			(NameId: sidMineStrike;
			NameTex: nil;
			Probability: 200;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_NeedTarget or
							ammoprop_AttackingPut or
							ammoprop_DontHold or
							ammoprop_NotBorder;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amMineStrike);
			Slot: 5;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 5;
			PosCount: 2;
			PosSprite: sprAmAirplane),
			(NameId: sidBlowTorch;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 2;
			Ammo: (Propz: ammoprop_ForwMsgs;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amBlowTorch);
			Slot: 6;
			TimeAfterTurn: 3000;
			minAngle: 768;
			maxAngle: 1280;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidGirder;
			NameTex: nil;
			Probability: 150;
			NumberInCase: 3;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_NeedTarget or
							ammoprop_AttackingPut;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amGirder);
			Slot: 6;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 8;
			PosSprite: sprAmGirder),
			(NameId: sidTeleport;
			NameTex: nil;
			Probability: 200;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_NoCrosshair or
							ammoprop_NeedTarget or
							ammoprop_AttackingPut or
							ammoprop_DontHold;
					Count: 2;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amTeleport);
			Slot: 7;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidSwitch;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_NoCrosshair or
							ammoprop_DontHold;
					Count: 3;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amSwitch);
			Slot: 8;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidMortar;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 4;
			Ammo: (Propz: 0;
					Count: 4;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amMortar);
			Slot: 1;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidKamikaze;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_DontHold;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amKamikaze);
			Slot: 3;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidCake;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_NoCrosshair or
							ammoprop_DontHold;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amCake);
			Slot: 4;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 4;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidSeduction;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or ammoprop_DontHold;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amSeduction);
			Slot: 2;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidWatermelon;
			NameTex: nil;
			Probability: 400;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_Timerable or
							ammoprop_Power or
							ammoprop_AltUse;
					Count: 0;
					NumPerTurn: 0;
					Timer: 3000;
					Pos: 0;
					AmmoType: amWatermelon);
			Slot: 1;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidHellishBomb;
			NameTex: nil;
			Probability: 400;
			NumberInCase: 1;
			Ammo: (Propz:  ammoprop_Power or
							ammoprop_AltUse;
					Count: 0;
					NumPerTurn: 0;
					Timer: 5000;
					Pos: 0;
					AmmoType: amHellishBomb);
			Slot: 4;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidNapalm;
			NameTex: nil;
			Probability: 100;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
							ammoprop_NeedTarget or
							ammoprop_AttackingPut or
							ammoprop_DontHold or
							ammoprop_NotBorder;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amNapalm);
			Slot: 5;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 7;
			PosCount: 2;
			PosSprite: sprAmAirplane),
			(NameId: sidDrill;
			NameTex: nil;
			Probability: 300;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_Power or
							ammoprop_AltUse;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amDrill);
			Slot: 0;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprDrill),
			(NameId: sidBallgun;
			NameTex: nil;
			Probability: 400;
			NumberInCase: 1;
			Ammo: (Propz:  ammoprop_ForwMsgs or
							 ammoprop_DontHold;
					Count: AMMO_INFINITE;
					NumPerTurn: 0;
					Timer: 5001;
					Pos: 0;
					AmmoType: amBallgun);
			Slot: 2;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidRCPlane;
			NameTex: nil;
			Probability: 200;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs{ or
							ammoprop_DontHold or
							ammoprop_AltAttack};
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amRCPlane);
			Slot: 6;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 4;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidLowGravity;
			NameTex: nil;
			Probability: 20;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
						  ammoprop_DontHold or
						  ammoprop_AltUse or
                          ammoprop_Utility;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amLowGravity);
			Slot: 8;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidExtraDamage;
			NameTex: nil;
			Probability: 15;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
						  ammoprop_DontHold or
						  ammoprop_AltUse or
                          ammoprop_Utility;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amExtraDamage);
			Slot: 8;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidInvulnerable;
			NameTex: nil;
			Probability: 20;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
						  ammoprop_DontHold or
						  ammoprop_AltUse or
                          ammoprop_Utility;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amInvulnerable);
			Slot: 8;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidExtraTime;
			NameTex: nil;
			Probability: 30;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
						  ammoprop_DontHold or
						  ammoprop_AltUse or
                          ammoprop_Utility;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amExtraTime);
			Slot: 7;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidLaserSight;
			NameTex: nil;
			Probability: 15;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
						  ammoprop_DontHold or
						  ammoprop_AltUse or
                          ammoprop_Utility;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amLaserSight);
			Slot: 7;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidVampiric;
			NameTex: nil;
			Probability: 15;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_NoCrosshair or
						  ammoprop_DontHold or
						  ammoprop_AltUse or
                          ammoprop_Utility;
					Count: 1;
					NumPerTurn: 0;
					Timer: 0;
					Pos: 0;
					AmmoType: amVampiric);
			Slot: 6;
			TimeAfterTurn: 0;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidSniperRifle;
			NameTex: nil;
			Probability: 20;
			NumberInCase: 2;
			Ammo: (Propz: 0;
					Count: 2;
					NumPerTurn: 1;
					Timer: 0;
					Pos: 0;
					AmmoType: amSniperRifle);
			Slot: 2;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: true;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater),
			(NameId: sidJetpack;
			NameTex: nil;
			Probability: 20;
			NumberInCase: 1;
			Ammo: (Propz: ammoprop_ForwMsgs or
							ammoprop_AttackInMove or
							ammoprop_NoCrosshair or
							ammoprop_DontHold or
							ammoprop_AltAttack;
					Count: 1;
					NumPerTurn: 1;
					Timer: 0;
					Pos: 0;
					AmmoType: amJetpack);
			Slot: 3;
			TimeAfterTurn: 3000;
			minAngle: 0;
			maxAngle: 0;
			isDamaging: false;
			SkipTurns: 0;
			PosCount: 1;
			PosSprite: sprWater)
			);

var CountTexz: array[1..9] of PTexture;

implementation

end.
