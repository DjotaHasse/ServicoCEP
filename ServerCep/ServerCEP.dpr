program ServerCEP;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  System.Json,
  ServerCep.Model.ViaCepAPI in 'src\Model\ServerCep.Model.ViaCepAPI.pas',
  ServerCep.Model.CepApi in 'src\Model\ServerCep.Model.CepApi.pas',
  ServerCep.Model.ApiCepAPI in 'src\Model\ServerCep.Model.ApiCepAPI.pas',
  ServerCep.Model.AwesomeCepAPI in 'src\Model\ServerCep.Model.AwesomeCepAPI.pas',
  ServerCep.Controller.CepAPI in 'src\Controller\ServerCep.Controller.CepAPI.pas';

var
  ApiServer: THorse;

begin
  Writeln('Serviço startado!');
  ApiServer := THorse.Create;
  ServerCep.Controller.CepAPI.Registry(ApiServer);
  ApiServer.Listen(9000);
  Readln;
end.
