program UltraHorse1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this },
  Horse, Horse.AutoReload, Horse.LazStatic, UltraGenInterfaceClass,
  userscontroller, ultrahelper, usersservice;


procedure RespondStatic(Req: THorseRequest; Res: ThorseResponse; Next: TNextProc);
var
  FileType, FileName: string;
begin
  Req.Params.TryGetValue('filetype', FileType);
  Req.Params.TryGetValue('filename', FileName);
  ThorseStaticResponse(Res).SendStatic(FileType + DirectorySeparator + FileName);
end;

procedure RespondIndex(Req: THorseRequest; Res: ThorseResponse; Next: TNextProc);
var
  Adapter: TUltraAdapter;
  ViewOutput: string;
begin
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('component', 'HomeIndex');
  Adapter.AddMember('data', '{"data": null}');
  ViewOutput := ProcessTemplate(Adapter);
  SendWithReloader(Res, ViewOutput);
end;

begin

  Thorse.Use(AutoReload(9000, True));
  Thorse.Use(LazStatic('static'));

  Thorse.Get('/static/:filetype/:filename', @RespondStatic);
  Thorse.Get('/', @RespondIndex);
  Thorse.Get('/users', @UsersController.FindAllUsers);
  THorse.Get('/users/:id', @UsersController.ShowUser);

  Thorse.Listen(9000);

end.

