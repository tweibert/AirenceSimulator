unit SimulatorMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Vcl.ComCtrls;


const
  AIRENCE_LED_ALL               = $FF;
  AIRENCE_SW_LED_1              = 1;
  AIRENCE_SW_LED_2              = 2;
  AIRENCE_SW_LED_3              = 3;
  AIRENCE_SW_LED_4              = 4;
  AIRENCE_SW_LED_5              = 5;
  AIRENCE_SW_LED_6              = 6;
  AIRENCE_SW_LED_7              = 7;
  AIRENCE_SW_LED_8              = 8;
  AIRENCE_SW_LED_9              = 9;
  AIRENCE_SW_LED_10             = 10;
  AIRENCE_SW_LED_11             = 11;
  AIRENCE_SW_LED_12             = 12;
  AIRENCE_SW_LED_13             = 13;
  AIRENCE_SW_LED_14             = 14;
  AIRENCE_SW_LED_15             = 15;
  AIRENCE_SW_LED_16             = 16;
  AIRENCE_SW_LED_17             = 17;
  AIRENCE_SW_LED_18             = 18;
  AIRENCE_SW_LED_19             = 19;
  AIRENCE_SW_LED_20             = 20;
  AIRENCE_SW_LED_21             = 21;
  AIRENCE_SW_LED_22             = 22;
  AIRENCE_SW_LED_23             = 23;
  AIRENCE_SW_LED_24             = 24;
  AIRENCE_SW_ENCODER            = 25;
  AIRENCE_SW_NONSTOP            = 26;
  AIRENCE_SW_USB1_FADERSTART    = 27;
  AIRENCE_SW_USB1_ON            = 28;
  AIRENCE_SW_USB1_CUE           = 29;
  AIRENCE_SW_USB2_FADERSTART    = 30;
  AIRENCE_SW_USB2_ON            = 31;
  AIRENCE_SW_USB2_CUE           = 32;
  AIRENCE_SW_USB3_FADERSTART    = 33;
  AIRENCE_SW_USB3_ON            = 34;
  AIRENCE_SW_USB3_CUE           = 35;
  AIRENCE_SW_USB4_FADERSTART    = 36;
  AIRENCE_SW_USB4_ON            = 37;
  AIRENCE_SW_USB4_CUE           = 38;

  AIRENCE_READ_MODE             = 1000;

type
  TAirenceColor = (
    acNone,
    acRed,
    acGreen,
    acYellow
  );

  TAirenceBlinkSpeed = (
    abcSlow,
    abcNormal,
    abcFast
  );

  TAirenceControlSignalChangeCallbackProc = procedure(signal: integer; state: boolean; data: pointer); cdecl;
  TAirenceEncoderChangeCallbackProc = procedure(direction: integer; abs_value: byte; data: pointer); cdecl;

  TLEDStatus = record
    Color: TAirenceColor;
    Blinking: boolean;
    BlinkOnColor: TAirenceColor;
    BlinkOffColor: TAirenceColor;
    BlinkSpeed: TAirenceBlinkSpeed;
  end;

type
  TSimulatorMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    gbUSB1: TGroupBox;
    btnUSB1Cue: TSpeedButton;
    btnUSB1On: TSpeedButton;
    btnUSB1Fader: TSpeedButton;
    gbUSB2: TGroupBox;
    btnUSB2Cue: TSpeedButton;
    btnUSB2On: TSpeedButton;
    btnUSB2Fader: TSpeedButton;
    gbUSB3: TGroupBox;
    btnUSB3Cue: TSpeedButton;
    btnUSB3On: TSpeedButton;
    btnUSB3Fader: TSpeedButton;
    gbUSB4: TGroupBox;
    btnUSB4Fader: TSpeedButton;
    pnlLEDs: TPanel;
    shLED1: TShape;
    shLED2: TShape;
    shLED3: TShape;
    shLED4: TShape;
    shLED5: TShape;
    shLED6: TShape;
    shLED7: TShape;
    shLED9: TShape;
    shLED10: TShape;
    shLED11: TShape;
    shLED12: TShape;
    shLED8: TShape;
    shLED13: TShape;
    shLED14: TShape;
    shLED15: TShape;
    shLED16: TShape;
    shLED17: TShape;
    shLED18: TShape;
    shLED19: TShape;
    shLED20: TShape;
    shLED21: TShape;
    shLED22: TShape;
    shLED23: TShape;
    shLED24: TShape;
    Timer1: TTimer;
    pnlPushButtons: TPanel;
    btnButton1: TSpeedButton;
    btnButton2: TSpeedButton;
    btnButton3: TSpeedButton;
    btnButton4: TSpeedButton;
    btnButton8: TSpeedButton;
    btnButton7: TSpeedButton;
    btnButton6: TSpeedButton;
    btnButton5: TSpeedButton;
    btnButton9: TSpeedButton;
    btnButton10: TSpeedButton;
    btnButton11: TSpeedButton;
    btnButton12: TSpeedButton;
    btnButton13: TSpeedButton;
    btnButton14: TSpeedButton;
    btnButton15: TSpeedButton;
    btnButton16: TSpeedButton;
    btnButton17: TSpeedButton;
    btnButton18: TSpeedButton;
    btnButton19: TSpeedButton;
    btnButton20: TSpeedButton;
    btnButton21: TSpeedButton;
    btnButton22: TSpeedButton;
    btnButton23: TSpeedButton;
    btnButton24: TSpeedButton;
    gbEncoder: TGroupBox;
    tbEncoder: TTrackBar;
    btnUSB4Cue: TSpeedButton;
    btnUSB4On: TSpeedButton;
    btnEncoder: TSpeedButton;
    btnNonstop: TSpeedButton;
    procedure SwitchButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnPushButtonDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnPushButtonUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnUSB1FaderClick(Sender: TObject);
    procedure btnUSB1OnClick(Sender: TObject);
    procedure btnUSB2OnClick(Sender: TObject);
    procedure btnUSB3OnClick(Sender: TObject);
    procedure btnUSB4OnClick(Sender: TObject);
    procedure btnUSB2FaderClick(Sender: TObject);
    procedure btnUSB3FaderClick(Sender: TObject);
    procedure btnUSB4FaderClick(Sender: TObject);
    procedure tbEncoderChange(Sender: TObject);
  private
    fSignals: array[1..38] of boolean;
    fLEDs: array[1..24] of TShape;
    fLEDStatus: array[1..24] of TLEDStatus;
    fLastEncoderPosition: integer;
    procedure UpdateLEDs;
  public
    function GetSignal(iIndex: integer): boolean;
    procedure SetLED(iIndex: integer; iColor: TAirenceColor);
    procedure SetLEDBlink(iIndex: integer; iOnColor, iOffColor: TAirenceColor; iSpeed: TAirenceBlinkSpeed);
    property Signals[iIndex: integer]: boolean read GetSignal;
  end;

var
  SimulatorMainForm: TSimulatorMainForm;
  ControlSignalChangeCallback: TAirenceControlSignalChangeCallbackProc;
  ControlSignalChangeCallbackData: pointer;
  EncoderChangeCallback: TAirenceEncoderChangeCallbackProc;
  EncoderChangeCallbackData: pointer;

implementation

{$R *.dfm}

procedure TSimulatorMainForm.btnPushButtonDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with TSpeedButton(Sender) do begin
    fSignals[Tag] := true;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(Tag, true, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.btnPushButtonUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with TSpeedButton(Sender) do begin
    fSignals[Tag] := false;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(Tag, false, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.SwitchButtonClick(Sender: TObject);
begin
  with TSpeedButton(Sender) do begin
    fSignals[GroupIndex] := Down;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(GroupIndex, Down, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.btnUSB1FaderClick(Sender: TObject);
begin
  // only switch signal if btnUSB1On is also down
  if btnUSB1On.Down then begin
    fSignals[AIRENCE_SW_USB1_FADERSTART] := btnUSB1Fader.Down;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(AIRENCE_SW_USB1_FADERSTART, btnUSB1Fader.Down, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.btnUSB1OnClick(Sender: TObject);
var
  lastState: boolean;
begin
  fSignals[AIRENCE_SW_USB1_ON] := btnUSB1On.Down;
  if assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB1_ON, btnUSB1On.Down, ControlSignalChangeCallbackData);

  // also switch faderstart if necessary
  lastState := fSignals[AIRENCE_SW_USB1_FADERSTART];
  fSignals[AIRENCE_SW_USB1_FADERSTART] := btnUSB1On.Down and btnUSB1Fader.Down;
  if (fSignals[AIRENCE_SW_USB1_FADERSTART] <> lastState) and assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB1_FADERSTART, fSignals[AIRENCE_SW_USB1_FADERSTART], ControlSignalChangeCallbackData);
end;

procedure TSimulatorMainForm.btnUSB2FaderClick(Sender: TObject);
begin
  // only switch signal if btnUSB2On is also down
  if btnUSB2On.Down then begin
    fSignals[AIRENCE_SW_USB2_FADERSTART] := btnUSB2Fader.Down;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(AIRENCE_SW_USB2_FADERSTART, btnUSB2Fader.Down, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.btnUSB2OnClick(Sender: TObject);
var
  lastState: boolean;
begin
  fSignals[AIRENCE_SW_USB2_ON] := btnUSB2On.Down;
  if assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB2_ON, btnUSB2On.Down, ControlSignalChangeCallbackData);

  // also switch faderstart if necessary
  lastState := fSignals[AIRENCE_SW_USB2_FADERSTART];
  fSignals[AIRENCE_SW_USB2_FADERSTART] := btnUSB2On.Down and btnUSB2Fader.Down;
  if (fSignals[AIRENCE_SW_USB2_FADERSTART] <> lastState) and assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB2_FADERSTART, fSignals[AIRENCE_SW_USB2_FADERSTART], ControlSignalChangeCallbackData);
end;

procedure TSimulatorMainForm.btnUSB3FaderClick(Sender: TObject);
begin
  // only switch signal if btnUSB3On is also down
  if btnUSB3On.Down then begin
    fSignals[AIRENCE_SW_USB3_FADERSTART] := btnUSB3Fader.Down;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(AIRENCE_SW_USB3_FADERSTART, btnUSB3Fader.Down, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.btnUSB3OnClick(Sender: TObject);
var
  lastState: boolean;
begin
  fSignals[AIRENCE_SW_USB3_ON] := btnUSB3On.Down;
  if assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB3_ON, btnUSB3On.Down, ControlSignalChangeCallbackData);

  // also switch faderstart if necessary
  lastState := fSignals[AIRENCE_SW_USB3_FADERSTART];
  fSignals[AIRENCE_SW_USB3_FADERSTART] := btnUSB3On.Down and btnUSB3Fader.Down;
  if (fSignals[AIRENCE_SW_USB3_FADERSTART] <> lastState) and assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB3_FADERSTART, fSignals[AIRENCE_SW_USB3_FADERSTART], ControlSignalChangeCallbackData);
end;

procedure TSimulatorMainForm.btnUSB4FaderClick(Sender: TObject);
begin
  // only switch signal if btnUSB4On is also down
  if btnUSB4On.Down then begin
    fSignals[AIRENCE_SW_USB4_FADERSTART] := btnUSB4Fader.Down;
    if assigned(ControlSignalChangeCallback) then
      ControlSignalChangeCallback(AIRENCE_SW_USB4_FADERSTART, btnUSB4Fader.Down, ControlSignalChangeCallbackData);
  end;
end;

procedure TSimulatorMainForm.btnUSB4OnClick(Sender: TObject);
var
  lastState: boolean;
begin
  fSignals[AIRENCE_SW_USB4_ON] := btnUSB4On.Down;
  if assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB4_ON, btnUSB4On.Down, ControlSignalChangeCallbackData);

  // also switch faderstart if necessary
  lastState := fSignals[AIRENCE_SW_USB4_FADERSTART];
  fSignals[AIRENCE_SW_USB4_FADERSTART] := btnUSB4On.Down and btnUSB4Fader.Down;
  if (fSignals[AIRENCE_SW_USB4_FADERSTART] <> lastState) and assigned(ControlSignalChangeCallback) then
    ControlSignalChangeCallback(AIRENCE_SW_USB4_FADERSTART, fSignals[AIRENCE_SW_USB4_FADERSTART], ControlSignalChangeCallbackData);
end;

procedure TSimulatorMainForm.FormCreate(Sender: TObject);
begin
  fLEDs[1] := shLED1;
  fLEDs[2] := shLED2;
  fLEDs[3] := shLED3;
  fLEDs[4] := shLED4;
  fLEDs[5] := shLED5;
  fLEDs[6] := shLED6;
  fLEDs[7] := shLED7;
  fLEDs[8] := shLED8;
  fLEDs[9] := shLED9;
  fLEDs[10] := shLED10;
  fLEDs[11] := shLED11;
  fLEDs[12] := shLED12;
  fLEDs[13] := shLED13;
  fLEDs[14] := shLED14;
  fLEDs[15] := shLED15;
  fLEDs[16] := shLED16;
  fLEDs[17] := shLED17;
  fLEDs[18] := shLED18;
  fLEDs[19] := shLED19;
  fLEDs[20] := shLED20;
  fLEDs[21] := shLED21;
  fLEDs[22] := shLED22;
  fLEDs[23] := shLED23;
  fLEDs[24] := shLED24;
  UpdateLEDs;
end;

function TSimulatorMainForm.GetSignal(iIndex: integer): boolean;
begin
  Result := fSignals[iIndex];
end;

procedure TSimulatorMainForm.SetLED(iIndex: integer; iColor: TAirenceColor);
begin
  with fLEDStatus[iIndex] do begin
    Color := iColor;
    Blinking := false;
  end;
  UpdateLEDs;
end;

procedure TSimulatorMainForm.SetLEDBlink(iIndex: integer;
  iOnColor, iOffColor: TAirenceColor; iSpeed: TAirenceBlinkSpeed);
begin
  with fLEDStatus[iIndex] do begin
    Blinking := true;
    BlinkOnColor := iOnColor;
    BlinkOffColor := iOffColor;
    BlinkSpeed := iSpeed;
  end;
  UpdateLEDs;
end;

procedure TSimulatorMainForm.tbEncoderChange(Sender: TObject);
var
  direction: integer;
begin
  if assigned(EncoderChangeCallback) then begin
    if fLastEncoderPosition > tbEncoder.Position then
      direction := -1
    else
      direction := 1;
    EncoderChangeCallback(direction, byte(tbEncoder.Position), EncoderChangeCallbackData);
  end;
  fLastEncoderPosition := tbEncoder.Position;
end;

procedure TSimulatorMainForm.Timer1Timer(Sender: TObject);
begin
  UpdateLEDs;
end;

procedure TSimulatorMainForm.UpdateLEDs;
var
  i: integer;
  c: TAirenceColor;
  isOn: boolean;
begin
  isOn := false;
  for i := 1 to 24 do begin
    with fLEDStatus[i] do
      if not Blinking then
        c := Color
      else begin
        case BlinkSpeed of
          abcSlow: isOn := (GetTickCount div 800 mod 2) = 0;
          abcNormal: isOn := (GetTickCount div 400 mod 2) = 0;
          abcFast: isOn := (GetTickCount div 200 mod 2) = 0;
        end;
        if isOn then c := BlinkOnColor else c := BlinkOffColor;
      end;
    with fLEDs[i].Brush do
      case c of
        acNone: Color := clDkGray;
        acRed: Color := clRed;
        acGreen: Color := clLime;
        acYellow: Color := clYellow;
      end;
  end;
end;

end.
