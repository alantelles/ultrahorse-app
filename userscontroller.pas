unit UsersController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UsersService,
  Horse;

procedure FindAllUsers(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure ShowUser(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

uses
  UltraGenInterfaceClass, Horse.AutoReload, UltraHelper;

procedure FindAllUsers(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Adapter: TUltraAdapter;
begin
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('component', 'UsersIndex');
  Adapter.AddMember('data', UsersService.FindAllUsers);
  SendWithReloader(Res, ProcessTemplate(Adapter));
end;

procedure ShowUser(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  UserId: string;
  Adapter: TUltraAdapter;
begin
  Req.Params.TryGetValue('id', UserId);
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('component', 'UsersShow');
  Adapter.AddMember('data', UsersService.ShowUser(UserId));
  SendWithReloader(Res, ProcessTemplate(Adapter));
end;

end.

