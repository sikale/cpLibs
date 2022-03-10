{==============================================================================
   ___ ___
  / __| _ \__ _ ___™
 | (__|  _/ _` (_-<
  \___|_| \__,_/__/
    C for Delphi

 Copyright © 2020-22 tinyBigGAMES™ LLC
 All rights reserved.

 Website: https://tinybiggames.com
 Email  : support@tinybiggames.com

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software in
    a product, an acknowledgment in the product documentation would be
    appreciated but is not required.
 2. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

 3. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in
    the documentation and/or other materials provided with the
    distribution.

 4. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived
    from this software without specific prior written permission.

 5. All video, audio, graphics and other content accessed through the
    software in this distro is the property of the applicable content owner
    and may be protected by applicable copyright law. This License gives
    Customer no rights to such content, and Company disclaims any liability
    for misuse of content.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
============================================================================== }

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}

{$IFNDEF WIN64}
  {$MESSAGE Error 'Unsupported platform'}
{$ENDIF}

{$Z4}
{$A8}

{$IFNDEF FPC}
{$DEFINE CPAS_STATIC} //<-- define for static distribution
{$ENDIF}

unit CPas;

interface

uses
  SysUtils,
  Classes;

type
  { TCPas }
  TCPas = type Pointer;

  { TCPasOutput }
  TCPasOutput = (cpMemory, cpLib, cpEXE, cpDLL);

  { TCPasExe }
  TCPasExe = (cpConsole, cpGUI);

  { TCPasErrorMessageEvent }
  TCPasErrorEvent = procedure(aSender: Pointer; const aMsg: WideString);

{$IFNDEF CPAS_STATIC}

const
  { CPas dll }
  CPAS_DLL = 'CPas.dll';

{ Misc }
function  cpVersion: WideString; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{ State management }
function  cpNew: TCPas; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpFree(var aCPas: TCPas); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpReset(aCPas: TCPas); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{ Error handling }
procedure cpSetErrorHandler(aCPas: TCPas; aSender: Pointer; aHandler: TCPasErrorEvent); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpGetErrorHandler(aCPas: TCPas; var aSender: Pointer; var aHandler: TCPasErrorEvent); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{ Preprocessing }
procedure cpDefineSymbol(aCPas: TCPas; const aName: WideString; const aValue: WideString); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpUndefineSymbol(aCPas: TCPas; const aName: WideString); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpAddIncludePath(aCPas: TCPas; const aPath: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpAddLibraryPath(aCPas: TCPas; const aPath: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{ Compiling }
procedure cpSetOuput(aCPas: TCPas; aOutput: TCPasOutput); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpGetOutput(aCPas: TCPas): TCPasOutput; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpSetExe(aCPas: TCPas; aExe: TCPasExe); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpGetExe(aCPas: TCPas): TCPasExe; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpAddLibrary(aCPas: TCPas; const aName: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpAddFile(aCPas: TCPas; const aFilename: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpCompileString(aCPas: TCPas; const aBuffer: string): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpAddSymbol(aCPas: TCPas; const aName: WideString; aValue: Pointer); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpLoadLibFromFile(aCPas: TCPas; const aFilename: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpLoadLibFromResource(aCPas: TCPas; const aResName: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpLoadLibFromStream(aCPas: TCPas; aStream: TStream): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpSaveOutputFile(aCPas: TCPas; const aFilename: WideString): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpRelocate(aCPas: TCPas): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpRun(aCPas: TCPas): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpGetSymbol(aCPas: TCPas; const aName: WideString): Pointer; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{ Stats }
procedure cpStartStats(aCPas: TCPas); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpEndStats(aCPas: TCPas; aShow: Boolean): WideString; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{ Resources }
procedure cpSetExeIcon(aCPas: TCPas; const aFilename: WideString); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpGetExeIcon(aCPas: TCPas): WideString; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpSetAddVersionInfo(aCPas: TCPas; aAddVersionInfo: Boolean); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
function  cpGetAddVersionInfo(aCPas: TCPas): Boolean; external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpSetVersionInfo(aCPas: TCPas; const aCompanyName: WideString;
  const aFileVersion: WideString; const aFileDescription: WideString;
  const aOriginalFilename: WideString; const aLegalCopyright: WideString;
  const aComments: WideString); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};
procedure cpGetVersionInfo(aCPas: TCPas; var aCompanyName: WideString;
  var aFileVersion: WideString; var aFileDescription: WideString;
  var aOriginalFilename: WideString; var aLegalCopyright: WideString;
  var aComments: WideString); external CPAS_DLL {$IFNDEF FPC} delayed {$ENDIF};

{$ELSE}

var
  { Misc }
  cpVersion: function: WideString;

  { State management }
  cpNew: function: TCPas;
  cpFree: procedure(var aCPas: TCPas);
  cpReset: procedure(aCPas: TCPas);

  { Error handling }
  cpSetErrorHandler: procedure(aCPas: TCPas; aSender: Pointer; aHandler: TCPasErrorEvent);
  cpGetErrorHandler: procedure(aCPas: TCPas; var aSender: Pointer; var aHandler: TCPasErrorEvent);

  { Preprocessing }
  cpDefineSymbol: procedure(aCPas: TCPas; const aName: WideString; const aValue: WideString);
  cpUndefineSymbol: procedure(aCPas: TCPas; const aName: WideString);
  cpAddIncludePath: function(aCPas: TCPas; const aPath: WideString): Boolean;
  cpAddLibraryPath: function(aCPas: TCPas; const aPath: WideString): Boolean;

  { Compiling }
  cpSetOuput: procedure(aCPas: TCPas; aOutput: TCPasOutput);
  cpGetOutput: function(aCPas: TCPas): TCPasOutput;
  cpSetExe: procedure(aCPas: TCPas; aExe: TCPasExe);
  cpGetExe: function(aCPas: TCPas): TCPasExe;
  cpAddLibrary: function(aCPas: TCPas; const aName: WideString): Boolean;
  cpAddFile: function(aCPas: TCPas; const aFilename: WideString): Boolean;
  cpCompileString: function(aCPas: TCPas; const aBuffer: string): Boolean;
  cpAddSymbol: procedure(aCPas: TCPas; const aName: WideString; aValue: Pointer);
  cpLoadLibFromFile: function(aCPas: TCPas; const aFilename: WideString): Boolean;
  cpLoadLibFromResource: function(aCPas: TCPas; const aResName: WideString): Boolean;
  cpLoadLibFromStream: function(aCPas: TCPas; aStream: TStream): Boolean;
  cpSaveOutputFile: function(aCPas: TCPas; const aFilename: WideString): Boolean;
  cpRelocate: function(aCPas: TCPas): Boolean;
  cpRun: function(aCPas: TCPas): Boolean;
  cpGetSymbol: function(aCPas: TCPas; const aName: WideString): Pointer;

  { Stats }
  cpStartStats: procedure(aCPas: TCPas);
  cpEndStats: function(aCPas: TCPas; aShow: Boolean): WideString;

  { Resources }
  cpSetExeIcon: procedure(aCPas: TCPas; const aFilename: WideString);
  cpGetExeIcon: function(aCPas: TCPas): WideString;
  cpSetAddVersionInfo: procedure(aCPas: TCPas; aAddVersionInfo: Boolean);
  cpGetAddVersionInfo: function(aCPas: TCPas): Boolean;
  cpSetVersionInfo: procedure(aCPas: TCPas; const aCompanyName: WideString;
    const aFileVersion: WideString; const aFileDescription: WideString;
    const aLegalCopyright: WideString; const aOriginalFilename: WideString;
    const aComments: WideString);
  cpGetVersionInfo: procedure(aCPas: TCPas; var aCompanyName: WideString;
    var aFileVersion: WideString; var aFileDescription: WideString;
    var aOriginalFilename: WideString; var aLegalCopyright: WideString;
    var aComments: WideString);

{$ENDIF}

{$IFNDEF FPC}

{ Helper }
function  cpGetEnvVarValue(const aVarName: string): string;
function  cpSetEnvVarValue(const aVarName, aVarValue: string): Integer;
procedure cpAddToUserPath(aPath: string);

{$ENDIF}

implementation

{$IFNDEF CPAS_STATIC}
uses
  {$IFNDEF FPC}
  StrUtils,
  {$ENDIF}
  Windows;
{$ENDIF}

{$IFDEF CPAS_STATIC}

{$R CPas.res}

uses
  System.StrUtils,
  System.IOUtils,
  System.Zip,
  WinApi.Windows,
  WinApi.ShellAPI;

const
  cCPasResName = '41cd3fe4a9c942d48d067cc72c30c95c';

var
  LDllHandle: THandle;
  LDllName: string;

// DeferDelFile
procedure DeferDelFile(const aFilename: string);
var
  LCode: TStringList;
  LFilename: string;

  procedure C(const aMsg: string; const aArgs: array of const);
  var
    LLine: string;
  begin
    LLine := Format(aMsg, aArgs);
    LCode.Add(LLine);
  end;

begin
  if aFilename.IsEmpty then Exit;
  LFilename := ChangeFileExt(aFilename, '');
  LFilename := LFilename + '_DeferDelFile.bat';

  LCode := TStringList.Create;
  try
    C('@echo off', []);
    C(':Repeat', []);
    C('del "%s"', [aFilename]);
    C('if exist "%s" goto Repeat', [aFilename]);
    C('del "%s"', [LFilename]);
    LCode.SaveToFile(LFilename);
  finally
    FreeAndNil(LCode);
  end;

  if FileExists(LFilename) then
  begin
    ShellExecute(0, 'open', PChar(LFilename), nil, nil, SW_HIDE);
  end;
end;

// LoadDLL
procedure LoadDLL;
var
  LResStream: TResourceStream;
  LZipFile: TZipFile;
  LZipStream: TStream;
  LFileStream: TFileStream;
  LHeader: TZipHeader;
begin
  // extract CPass DLL
  LResStream := TResourceStream.Create(HInstance,cCPasResName, RT_RCDATA);
  try
    LZipFile := TZipFile.Create;
    try
      LZipFile.Open(LResStream, zmRead);
      LZipFile.Read(0, LZipStream, LHeader);
      try
        LDllName := TPath.GetGUIDFileName.ToLower + '.tmp';
        LDllName := TPath.Combine(TPath.GetTempPath, LDllName);
        LFileStream := TFile.Create(LDllName);
        try
          LFileStream.CopyFrom(LZipStream, LZipStream.Size);
        finally
          FreeAndNil(LFileStream);
        end;
      finally
        FreeAndNil(LZipStream);
      end;
    finally
      FreeAndNil(LZipFile);
    end;
  finally
    FreeAndNil(LResStream);
  end;

  // load to CPas DLL into address space
  LDllHandle := SafeLoadLibrary(LDllName);

  // link to exported routines

  { Misc }
  cpVersion := GetProcAddress(LDllHandle, 'cpVersion');

  { State management }
  cpNew := GetProcAddress(LDllHandle, 'cpNew');
  cpFree := GetProcAddress(LDllHandle, 'cpFree');
  cpReset := GetProcAddress(LDllHandle, 'cpReset');

  { Error handling }
  cpSetErrorHandler := GetProcAddress(LDllHandle, 'cpSetErrorHandler');
  cpGetErrorHandler := GetProcAddress(LDllHandle, 'cpGetErrorHandler');

  { Preprocessing }
  cpDefineSymbol := GetProcAddress(LDllHandle, 'cpDefineSymbol');
  cpUndefineSymbol := GetProcAddress(LDllHandle, 'cpUndefineSymbol');
  cpAddIncludePath := GetProcAddress(LDllHandle, 'cpAddIncludePath');
  cpAddLibraryPath := GetProcAddress(LDllHandle, 'cpAddLibraryPath');

  { Compiling }
  cpSetOuput := GetProcAddress(LDllHandle, 'cpSetOuput');
  cpGetOutput := GetProcAddress(LDllHandle, 'cpGetOutput');
  cpSetExe := GetProcAddress(LDllHandle, 'cpSetExe');
  cpGetExe := GetProcAddress(LDllHandle, 'cpGetExe');
  cpAddLibrary := GetProcAddress(LDllHandle, 'cpAddLibrary');
  cpAddFile := GetProcAddress(LDllHandle, 'cpAddFile');
  cpCompileString := GetProcAddress(LDllHandle, 'cpCompileString');
  cpAddSymbol := GetProcAddress(LDllHandle, 'cpAddSymbol');
  cpLoadLibFromFile := GetProcAddress(LDllHandle, 'cpLoadLibFromFile');
  cpLoadLibFromResource := GetProcAddress(LDllHandle, 'cpLoadLibFromResource');
  cpLoadLibFromStream := GetProcAddress(LDllHandle, 'cpLoadLibFromStream');
  cpRun := GetProcAddress(LDllHandle, 'cpRun');
  cpSaveOutputFile := GetProcAddress(LDllHandle, 'cpSaveOutputFile');
  cpRelocate := GetProcAddress(LDllHandle, 'cpRelocate');
  cpGetSymbol := GetProcAddress(LDllHandle, 'cpGetSymbol');

  { Stats }
  cpStartStats := GetProcAddress(LDllHandle, 'cpStartStats');
  cpEndStats := GetProcAddress(LDllHandle, 'cpEndStats');

  { Resources }
  cpSetExeIcon := GetProcAddress(LDllHandle, 'cpSetExeIcon');
  cpGetExeIcon := GetProcAddress(LDllHandle, 'cpGetExeIcon');
  cpSetAddVersionInfo := GetProcAddress(LDllHandle, 'cpSetAddVersionInfo');
  cpGetAddVersionInfo := GetProcAddress(LDllHandle, 'cpGetAddVersionInfo');
  cpSetVersionInfo := GetProcAddress(LDllHandle, 'cpSetVersionInfo');
  cpGetVersionInfo := GetProcAddress(LDllHandle, 'cpGetVersionInfo');

end;

// UnloadDLL
procedure UnloadDLL;
begin
  // unload from CPas DLL from address space
  FreeLibrary(LDllHandle);

  // remove from filesystem after exit
  DeferDelFile(LDllName);
end;

{$ENDIF}

{$IFNDEF FPC}
function cpGetEnvVarValue(const aVarName: string): string;
var
  LBufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  LBufSize := GetEnvironmentVariable(PChar(aVarName), nil, 0);
  if LBufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, LBufSize - 1);
    GetEnvironmentVariable(PChar(aVarName), PChar(Result), LBufSize);
  end
  else
    // No such environment variable
    Result := '';
end;

function cpSetEnvVarValue(const aVarName, aVarValue: string): Integer;
begin
  if SetEnvironmentVariable(PChar(aVarName), PChar(aVarValue)) then
    Result := 0
  else
    Result := GetLastError;
end;

procedure cpAddToUserPath(aPath: string);
var
  LPath: string;
  LInstallPath: string;
begin
  LInstallPath := IncludeTrailingPathDelimiter(aPath);
  LPath := cpGetEnvVarValue('PATH');
  if not ContainsText(LPath, LInstallPath) then
  begin
    LPath := LPath + ';' + LInstallPath;
    cpSetEnvVarValue('PATH', LInstallPath);
  end;
end;

{$ENDIF}

initialization
  {$IFNDEF FPC}
  // report memory leaks
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

{$IFDEF CPAS_STATIC}

  // load CPas DLL
  LoadDLL;

{$ENDIF}

finalization
{$IFDEF CPAS_STATIC}
  // unload CPas DLL
  UnloadDLL;

{$ENDIF}  

end.
