library airence;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  SimulatorMain in 'SimulatorMain.pas' {SimulatorMainForm};

{$R *.res}

function airenceOpen: integer; cdecl; export;
begin
  SimulatorMainForm.Show;
  Result := 0;
end;

function airenceClose: integer; cdecl; export;
begin
  SimulatorMainForm.Hide;
  Result := 0;
end;

function airenceSetLed(lednr: integer; color: TAirenceColor): integer; cdecl; export;
var
  i: integer;
begin
  if lednr = AIRENCE_LED_ALL then
    for i := 1 to 24 do
      SimulatorMainForm.SetLED(i, color)
  else
    SimulatorMainForm.SetLED(lednr, color);
  Result := 0;
end;

function airenceSetLedBlink(lednr: integer; _on: TAirenceColor; _off: TAirenceColor; speed: TAirenceBlinkSpeed): integer; cdecl; export;
var
  i: integer;
begin
  if lednr = AIRENCE_LED_ALL then
    for i := 1 to 24 do
      SimulatorMainForm.SetLEDBlink(i, _on, _off, speed)
  else
    SimulatorMainForm.SetLEDBlink(lednr, _on, _off, speed);
  Result := 0;
end;

function airenceGetControlSignal(controlsignal: integer; var state: boolean): integer; cdecl; export;
begin
  if (controlsignal >= 1) and (controlsignal <= 38) then begin
    state := SimulatorMainForm.Signals[controlsignal];
    Result := 0;
  end
  else
    Result := -1;
end;

function airenceGetRawControlData(data: pointer): integer; cdecl; export;
var
  data2: ^byte;
  delta: byte;
  i: integer;
begin
  data2 := data;

  with SimulatorMainForm do begin
    // Byte 0: Switch 1..8
    data2^ := 0;
    delta := 1;
    for i := AIRENCE_SW_LED_1 to AIRENCE_SW_LED_8 do begin
      if Signals[i] then data2^ := data2^ or delta;
      delta := delta shl 1;
    end;
    inc(data2);

    // Byte 1: Switch 9..16
    data2^ := 0;
    delta := 1;
    for i := AIRENCE_SW_LED_9 to AIRENCE_SW_LED_16 do begin
      if Signals[i] then data2^ := data2^ or delta;
      delta := delta shl 1;
    end;
    inc(data2);

    // Byte 2: Switch 17..24
    data2^ := 0;
    delta := 1;
    for i := AIRENCE_SW_LED_17 to AIRENCE_SW_LED_24 do begin
      if Signals[i] then data2^ := data2^ or delta;
      delta := delta shl 1;
    end;
    inc(data2);

    // Byte 3: Encoder + Nonstop
    data2^ := 0;
    delta := 1;
    for i := AIRENCE_SW_ENCODER to AIRENCE_SW_NONSTOP do begin
      if Signals[i] then data2^ := data2^ or delta;
      delta := delta shl 1;
    end;
    inc(data2);

    // Byte 4: USB1 + USB2
    data2^ := 0;
    delta := 1;
    for i := AIRENCE_SW_USB1_FADERSTART to AIRENCE_SW_USB2_CUE do begin
      if Signals[i] then data2^ := data2^ or delta;
      delta := delta shl 1;
    end;
    inc(data2);

    // Byte 5: USB3 + USB4
    data2^ := 0;
    delta := 1;
    for i := AIRENCE_SW_USB3_FADERSTART to AIRENCE_SW_USB4_CUE do begin
      if Signals[i] then data2^ := data2^ or delta;
      delta := delta shl 1;
    end;
  end;

  Result := 0;
end;

function airenceGetLibraryVersion(var major, minor: integer): PAnsiChar; cdecl; export;
begin
  if addr(major) <> nil then
    major := 0;
  if addr(minor) <> nil then
    minor := 0;
  Result := 'Airence Simulator';
end;

function airenceGetFirmwareVersion(var major, minor: integer): PAnsiChar; cdecl; export;
begin
  if addr(major) <> nil then
    major := 0;
  if addr(minor) <> nil then
    minor := 0;
  Result := 'Airence Simulator';
end;

procedure airenceSetControlSignalChangeCB(callback: TAirenceControlSignalChangeCallbackProc; data: pointer); cdecl; export;
begin
  ControlSignalChangeCallback := callback;
  ControlSignalChangeCallbackData := data;
end;

procedure airenceClearControlSignalChangeCB; cdecl; export;
begin
  ControlSignalChangeCallback := nil;
end;

procedure airenceSetEncoderChangeCB(callback: TAirenceEncoderChangeCallbackProc; data: pointer); cdecl; export;
begin
  EncoderChangeCallback := callback;
  EncoderChangeCallbackData := data;
end;

procedure airenceClearEncoderChangeCB; cdecl; export;
begin
  EncoderChangeCallback := nil;
end;

exports
  airenceOpen,
  airenceClose,
  airenceSetLed,
  airenceSetLedBlink,
  airenceGetControlSignal,
  airenceGetRawControlData,
  airenceGetLibraryVersion,
  airenceGetFirmwareVersion,
  airenceSetControlSignalChangeCB,
  airenceClearControlSignalChangeCB,
  airenceSetEncoderChangeCB,
  airenceClearEncoderChangeCB;

begin
  SimulatorMainForm := TSimulatorMainForm.Create(nil);
end.
