; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Odin"
#define MyAppVersion "0.1"
#define MyAppPublisher "Odin Team"
#define MyAppURL "https://www.hashstudios.dev/"
#define MyAppExeName "odin.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{0E67D205-E6A1-4CEB-BEE2-9DCBBD0E364B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=D:\Desktop\Ubuntu\odin\installers
OutputBaseFilename=odin
SetupIconFile=C:\Users\maury\Downloads\Odin\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\bitsdojo_window_windows_plugin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\desktop_drop_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\odin.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\odin.exp"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\odin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Desktop\Ubuntu\odin\build\windows\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

