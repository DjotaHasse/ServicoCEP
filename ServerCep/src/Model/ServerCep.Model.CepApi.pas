unit ServerCep.Model.CepApi;

interface

uses
  REST.Types,
  REST.Client,
  Json;

type
  TCepApi = class
    protected
      FRESTClientCEP:  TRESTClient;
      FRESTRequestCEP: TRESTRequest;
    public
      procedure SetRESTClientCEP(prValue: TRESTClient);
      procedure SetRESTRequestCEP(prValue: TRESTRequest);
    public
      constructor Create;
      destructor Destroy; override;

      function GetCEP(prCep: string): TJSONValue; overload; virtual;

      property RESTClientCEP: TRESTClient read FRESTClientCEP write SetRESTClientCEP;
      property RESTRequestCEP: TRESTRequest read FRESTRequestCEP write SetRESTRequestCEP;
  end;

implementation

{ TCepApi }

constructor TCepApi.Create;
begin

end;

destructor TCepApi.Destroy;
begin
  inherited;
end;

function TCepApi.GetCEP(prCep: string): TJSONValue;
begin
  Result := nil;
end;

procedure TCepApi.SetRESTClientCEP(prValue: TRESTClient);
begin
  FRESTClientCEP := prValue;
end;

procedure TCepApi.SetRESTRequestCEP(prValue: TRESTRequest);
begin
  FRESTRequestCEP := prValue
end;

end.
