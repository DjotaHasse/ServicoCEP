unit ServerCep.Model.ApiCepAPI;

interface

uses
  ServerCep.Model.CepApi,
  System.Json,
  REST.Types,
  REST.Client,
  System.SysUtils;

type
  TApiCepAPI = class(TCepApi)
    private
    public
      constructor Create;
      destructor Destroy; override;

      function GetCEP(prCep: string): TJSONValue;
  end;

implementation

{ TApiCepAPI }

constructor TApiCepAPI.Create;
begin
  RESTClientCEP := TRESTClient.Create(nil);
  RESTRequestCEP := TRESTRequest.Create(nil);
  RESTRequestCEP.Client := RESTClientCEP;
end;

destructor TApiCepAPI.Destroy;
begin
  RESTRequestCEP.Free;
  RESTClientCEP.Free;
  inherited;
end;

function TApiCepAPI.GetCEP(prCep: string): TJSONValue;
begin
  try
    RESTRequestCEP.Method := TRESTRequestMethod.rmGET;
    RESTRequestCEP.Resource := '/cep/'+prCep+'.json';
    RESTClientCEP.BaseURL := 'https://ws.apicep.com';
    RESTRequestCEP.Execute;
    if (RESTRequestCEP.Response.StatusCode = 200) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(RESTRequestCEP.Response.Content),0) as TJSONObject
    else
      Result := TJSONObject.ParseJSONValue('{"status":"Erro na requisicao"}') as TJSONObject;
  except
    on e: Exception do
      Result := TJSONObject.ParseJSONValue('{"erro":"'+e.Message+'"}') as TJSONObject;
  end;
end;

end.
