unit ServerCep.Model.ViaCepAPI;

interface

uses
  ServerCep.Model.CepApi,
  REST.Types,
  REST.Client,
  System.Json,
  System.SysUtils;

type
  TViaCepAPI = class(TCepApi)
    private
    public
      constructor Create;
      destructor Destroy; override;

      function GetCEP(prCep: string): TJSONValue;
  end;

implementation

{ TViaCepAPI }

constructor TViaCepAPI.Create;
begin
  RESTClientCEP := TRESTClient.Create(nil);
  RESTRequestCEP := TRESTRequest.Create(nil);
  RESTRequestCEP.Client := RESTClientCEP;
end;

destructor TViaCepAPI.Destroy;
begin
  RESTRequestCEP.Free;
  RESTClientCEP.Free;
  inherited;
end;

function TViaCepAPI.GetCEP(prCep: string): TJSONValue;
begin
  try
    RESTRequestCEP.Method := TRESTRequestMethod.rmGET;
    RESTRequestCEP.Resource := '/ws/'+prCep+'/json';
    RESTClientCEP.BaseURL := 'https://viacep.com.br';
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
