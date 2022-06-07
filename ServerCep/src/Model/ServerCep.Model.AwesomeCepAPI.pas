unit ServerCep.Model.AwesomeCepAPI;

interface

uses
  ServerCep.Model.CepApi,
  System.Json,
  REST.Types,
  REST.Client,
  System.SysUtils;

type
  TAwesomeCepAPI = class(TCepApi)
    private
    public
      constructor Create;
      destructor Destroy; override;

      function GetCEP(prCep: string): TJSONValue;
  end;

implementation

{ TAwesomeCepAPI }

constructor TAwesomeCepAPI.Create;
begin
  RESTClientCEP := TRESTClient.Create(nil);
  RESTRequestCEP := TRESTRequest.Create(nil);
  RESTRequestCEP.Client := RESTClientCEP;
end;

destructor TAwesomeCepAPI.Destroy;
begin
  RESTRequestCEP.Free;
  RESTClientCEP.Free;
  inherited;
end;

function TAwesomeCepAPI.GetCEP(prCep: string): TJSONValue;
begin
  try
    RESTRequestCEP.Method := TRESTRequestMethod.rmGET;
    RESTRequestCEP.Resource := '/json/'+prCep;
    RESTClientCEP.BaseURL := 'https://cep.awesomeapi.com.br';
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
