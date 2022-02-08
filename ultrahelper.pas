unit UltraHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  UltraGenInterfaceClass;

function ProcessTemplate(Adapter: TUltraAdapter): string;

implementation

function ProcessTemplate(Adapter: TUltraAdapter): string;
var
  Prelude: TStringList;
begin
  Prelude := TStringList.Create;
  Prelude.Add('addModulePath("ultragen/modules")');
  Prelude.Add('include @Core');
  Prelude.Add('$horseData = JSON.parse($fromHorse[:data])');
  Result := TUltraInterface.InterpretScript('index.ultra', Prelude, Adapter);
end;

end.

