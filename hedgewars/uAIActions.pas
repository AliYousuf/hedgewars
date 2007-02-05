(*
 * Hedgewars, a worms-like game
 * Copyright (c) 2005-2007 Andrey Korotaev <unC0Rr@gmail.com>
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

unit uAIActions;
interface
uses uGears, uFloat;
{$INCLUDE options.inc}
const MAXACTIONS = 96;
      aia_none       = 0;
      aia_Left       = 1;
      aia_Right      = 2;
      aia_Timer      = 3;
      aia_attack     = 4;
      aia_Up         = 5;
      aia_Down       = 6;

      aia_Weapon     = $8000;
      aia_WaitXL     = $8001;
      aia_WaitXR     = $8002;
      aia_LookLeft   = $8003;
      aia_LookRight  = $8004;
      aia_AwareExpl  = $8005;
      aia_HJump      = $8006;
      aia_LJump      = $8007;
      aia_Skip       = $8008;
      aia_Wait       = $8009;

      aim_push       = $8000;
      aim_release    = $8001;
      ai_specmask    = $8000;

type TAction = record
               Action: Longword;
               X, Y, Param: LongInt;
               Time: Longword;
               end;
     TActions = record
                Count, Pos: Longword;
                actions: array[0..Pred(MAXACTIONS)] of TAction;
                Score: LongInt;
                end;

procedure AddAction(var Actions: TActions; Action: Longword; Param: LongInt; TimeDelta: Longword; X, Y: LongInt);
procedure ProcessAction(var Actions: TActions; Me: PGear);

implementation
uses uMisc, uTeams, uConsts, uConsole, uAIMisc;

const ActionIdToStr: array[0..6] of string[16] = (
{aia_none}           '',
{aia_Left}           'left',
{aia_Right}          'right',
{aia_Timer}          'timer',
{aia_attack}         'attack',
{aia_Up}             'up',
{aia_Down}           'down'
                     );

{$IFDEF TRACEAIACTIONS}
const SpecActionIdToStr: array[$8000..$8009] of string[16] = (
{aia_Weapon}             'aia_Weapon',
{aia_WaitX}              'aia_WaitX',
{aia_WaitY}              'aia_WaitY',
{aia_LookLeft}           'aia_LookLeft',
{aia_LookRight}          'aia_LookRight',
{aia_AwareExpl}          'aia_AwareExpl',
{aia_HJump}              'aia_HJump',
{aia_LJump}              'aia_LJump',
{aia_Skip}               'aia_Skip',
{aia_Wait}               'aia_Wait'
);

procedure DumpAction(Action: TAction; Me: PGear);
begin
if (Action.Action and ai_specmask) = 0 then
   WriteLnToConsole('AI action: '+ActionIdToStr[Action.Action])
else begin
   WriteLnToConsole('AI action: '+SpecActionIdToStr[Action.Action]);
   if (Action.Action = aia_WaitXL) or (Action.Action = aia_WaitXR) then
      WriteLnToConsole('AI action Wait X = '+inttostr(Action.Param)+', current X = '+inttostr(round(Me.X)));
   end
end;
{$ENDIF}

procedure AddAction(var Actions: TActions; Action: Longword; Param: LongInt; TimeDelta: Longword; X, Y: LongInt);
begin
with Actions do
     begin
     actions[Count].Action:= Action;
     actions[Count].Param:= Param;
     actions[Count].X:= X;
     actions[Count].Y:= Y;
     if Count > 0 then actions[Count].Time:= TimeDelta
                  else actions[Count].Time:= GameTicks + TimeDelta;
     inc(Count);
     TryDo(Count < MAXACTIONS, 'AI: actions overflow', true);
     end
end;

procedure ProcessAction(var Actions: TActions; Me: PGear);
var s: shortstring;

    procedure CheckHang;
    const PrevX: LongInt = 0;
          timedelta: Longword = 0;
    begin
    if hwRound(Me^.X) <> PrevX then
       begin
       PrevX:= hwRound(Me^.X);
       timedelta:= 0
       end else
       begin
       inc(timedelta);
       if timedelta > 2500 then
          begin
          timedelta:= 0;
          Actions.Count:= 0
          end
       end
    end;

begin
repeat
if Actions.Pos >= Actions.Count then exit;
with Actions.actions[Actions.Pos] do
     begin
     if Time > GameTicks then exit;
     {$IFDEF TRACEAIACTIONS}
     DumpAction(Actions.actions[Actions.Pos], Me);
     {$ENDIF}
     if (Action and ai_specmask) <> 0 then
        case Action of
           aia_Weapon: SetWeapon(TAmmoType(Param));
           aia_WaitXL: if hwRound(Me^.X) = Param then Time:= GameTicks
                          else if hwRound(Me^.X) < Param then
                               begin
                               OutError('AI: WaitXL assert', false);
                               Actions.Count:= 0
                               end
                          else begin CheckHang; exit end;
           aia_WaitXR: if hwRound(Me^.X) = Param then Time:= GameTicks
                          else if hwRound(Me^.X) > Param then
                               begin
                               OutError('AI: WaitXR assert', false);
                               Actions.Count:= 0
                               end
                          else begin CheckHang; exit end;
         aia_LookLeft: if not Me^.dX.isNegative then
                          begin
                          ParseCommand('+left', true);
                          exit
                          end else ParseCommand('-left', true);
        aia_LookRight: if Me^.dX.isNegative then
                          begin
                          ParseCommand('+right', true);
                          exit
                          end else ParseCommand('-right', true);
        aia_AwareExpl: AwareOfExplosion(X, Y, Param);
            aia_HJump: ParseCommand('hjump', true);
            aia_LJump: ParseCommand('ljump', true);
             aia_Skip: ParseCommand('skip', true);
             end else
        begin
        s:= ActionIdToStr[Action];
        if (Param and ai_specmask) <> 0 then
           case Param of
             aim_push: s:= '+' + s;
          aim_release: s:= '-' + s;
             end
          else if Param <> 0 then s:= s + ' ' + inttostr(Param);
        ParseCommand(s, true)
        end
     end;
inc(Actions.Pos);
if Actions.Pos <= Actions.Count then
   inc(Actions.actions[Actions.Pos].Time, GameTicks);
until false
end;

end.
