unit ServerCep.Controller.CepAPI;

interface

uses
  Horse,
  System.Json,
  ServerCep.Model.ViaCepAPI,
  ServerCep.Model.ApiCepAPI,
  ServerCep.Model.AwesomeCepAPI,
  Horse.Utils.ClientIP;

procedure Registry(Api: THorse);
procedure GetViaCep(prRequest: THorseRequest; prResponse: THorseResponse; prNext: TProc);
procedure GetApiCep(prRequest: THorseRequest; prResponse: THorseResponse; prNext: TProc);
procedure GetAwesomeCep(prRequest: THorseRequest; prResponse: THorseResponse; prNext: TProc);

implementation

procedure Registry(Api: THorse);
begin
  Api.Get('/ws1/:cep',GetViaCep);
  Api.Get('/ws2/:cep',GetApiCep);
  Api.Get('/ws3/:cep',GetAwesomeCep);
end;

procedure GetViaCep(prRequest: THorseRequest; prResponse: THorseResponse; prNext: TProc);
var
  ViaCepObj: TViaCepAPI;
  CepValue: TJSONValue;
begin
  ViaCepObj := TViaCepAPI.Create;
  try
    CepValue := ViaCepObj.GetCEP(prRequest.Params.Items['cep']);
    prResponse.Send(CepValue.ToJSON);
    Writeln('Requisição ViaCEP - IP: '+ClientIP(prRequest));
  finally
    ViaCepObj.Free;
  end;
end;

procedure GetApiCep(prRequest: THorseRequest; prResponse: THorseResponse; prNext: TProc);
var
  ApiCepObj: TApiCepAPI;
  CepValue: TJSONValue;
begin
  ApiCepObj := TApiCepAPI.Create;
  try
    CepValue := ApiCepObj.GetCEP(prRequest.Params.Items['cep']);
    prResponse.Send(CepValue.ToJSON);
    Writeln('Requisição ApiCEP - IP: '+ClientIP(prRequest));
  finally
    ApiCepObj.Free;
  end;
end;

procedure GetAwesomeCep(prRequest: THorseRequest; prResponse: THorseResponse; prNext: TProc);
var
  AwesomeCepObj: TAwesomeCepAPI;
  CepValue: TJSONValue;
begin
  AwesomeCepObj := TAwesomeCepAPI.Create;
  try
    CepValue := AwesomeCepObj.GetCEP(prRequest.Params.Items['cep']);
    prResponse.Send(CepValue.ToJSON);
    Writeln('Requisição AwesomeCEP - IP: '+ClientIP(prRequest));
  finally
    AwesomeCepObj.Free;
  end;
end;

end.
