unit UsersService;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function FindAllUsers: string;
function ShowUser(uuid: string): string;

implementation

uses
  Fpjson, JsonParser;

function FindAllUsers: string;
begin
  with TStringList.Create do
  begin
    LoadFromFile('fakedata/users.json');
    Result := Text;
    Free;
  end;
end;

function ShowUser(uuid: string): string;
var
  AllUsers, UserObj, LoginInfoObj: TJSONData;
  i: integer;
begin
  AllUsers := GetJson(FindAllUsers);
  if Allusers.Count > 0 then
  begin
    for  i:=0 to AllUsers.Count-1 do
    begin
      UserObj := AllUsers.Items[i];
      LoginInfoObj := UserObj.FindPath('login.uuid');
      if LoginInfoObj.AsString = uuid then
      begin
        Result := UserObj.AsJSON;
        Break;
      end;
    end;
  end;

end;



end.

