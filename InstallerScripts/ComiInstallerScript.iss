; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Comi"
#define MyAppVersion "0.1.2"
#define MyAppPublisher "schiltz3"
#define MyAppURL "https://github.com/schiltz3/ComInfo"
#define MyAppExeName "comi.exe"
#define MyIcon "../icon/ComiIcon.ico"
#define OutputDir "..\target\release"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{E57206E7-CAA1-4520-9880-52B7E98C0C8C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
; "ArchitecturesAllowed=x64compatible" specifies that Setup cannot run
; on anything but x64 and Windows 11 on Arm.
ArchitecturesAllowed=x64compatible
; "ArchitecturesInstallIn64BitMode=x64compatible" requests that the
; install be done in "64-bit mode" on x64 or Windows 11 on Arm,
; meaning it should use the native 64-bit Program Files directory and
; the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64compatible
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=no
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename=ComiSetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
UninstallDisplayName={#MyAppName}

SetupIconFile={#MyIcon}
UninstallDisplayIcon={#MyIcon}
OutputDir={#OutputDir}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#OutputDir}\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#OUtputDir}\{#MyAppName}Run.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\settings.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\README.md"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"


#include "environment.iss"

[Setup]
ChangesEnvironment=true

; More options in setup section as well as other sections like Files, Components, Tasks...

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
    if (CurStep = ssPostInstall) and WizardIsTaskSelected('envPath')
    then EnvAddPath(ExpandConstant('{app}'));
    if CurStep = ssPostInstall then
      begin
        MsgBox('settings.json installed to: ' + ExpandConstant('{userdocs}\{#MyAppName}\settings.json'), mbInformation, MB_OK);
      end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
    if CurUninstallStep = usPostUninstall
    then EnvRemovePath(ExpandConstant('{app}'));
end;
    
[Tasks]
Name: envPath; Description: "Add to PATH variable" 
