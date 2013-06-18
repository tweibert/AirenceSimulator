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

function airenceOpen: integer; stdcall; export;
begin
  SimulatorMainForm.Show;
  Result := 0;
end;

function airenceClose: integer; stdcall; export;
begin
  SimulatorMainForm.Hide;
  Result := 0;
end;

function airenceSetLed(lednr: integer; color: TAirenceColor): integer; stdcall; export;
begin
  SimulatorMainForm.SetLED(lednr, color);
  Result := 0;
end;

function airenceSetLedBlink(lednr: integer; _on: TAirenceColor; _off: TAirenceColor; speed: TAirenceBlinkSpeed): integer; stdcall; export;
begin
  SimulatorMainForm.SetLEDBlink(lednr, _on, _off, speed);
  Result := 0;
end;

function airenceGetControlSignal(controlsignal: integer; var state: boolean): integer; stdcall; export;
begin
  if (controlsignal >= 1) and (controlsignal <= 38) then begin
    state := SimulatorMainForm.Signals[controlsignal];
    Result := 0;
  end
  else
    Result := -1;
end;

function airenceGetRawControlData(data: pointer): integer; stdcall; export;
begin
  // not implemented
  Result := 0;
end;

function airenceGetLibraryVersion(var major, minor: integer): PAnsiChar; stdcall; export;
begin
  major := 0;
  minor := 0;
  Result := nil;
end;

function airenceGetFirmwareVersion(var major, minor: integer): PAnsiChar; stdcall; export;
begin
  major := 0;
  minor := 0;
  Result := nil;
end;

procedure airenceSetControlSignalChangeCB(callback: TAirenceControlSignalChangeCallbackProc); stdcall; export;
begin
  ControlSignalChangeCallback := callback;
end;

procedure airenceClearControlSignalChangeCB; stdcall; export;
begin
  ControlSignalChangeCallback := nil;
end;

procedure airenceSetEncoderChangeCB(callback: TAirenceEncoderChangeCallbackProc); stdcall; export;
begin
end;

procedure  airenceClearEncoderChangeCB; stdcall; export;
begin
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
