[Setup]
AppPublisher=Nehenemi Labs
AppPublisherURL=https://www.nehenemi.net/
AppName=Haptic Mice
AppVersion=0.5a
WizardStyle=modern
DefaultDirName={autopf}\haptic-mice
DefaultGroupName=haptic mice
UninstallDisplayIcon={app}\haptic-mice.exe
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=haptic_mice-w64
OutputDir=installers\

[Files]
Source: "application.windows64\haptic_mice.exe"; DestDir: "{app}"
Source: "application.windows64\lib\*"; DestDir: "{app}"
Source: "application.windows64\source\*"; DestDir: "{app}"

[Icons]
Name: "{group}\Haptic mice"; Filename: "{app}\haptic_mice.exe"
