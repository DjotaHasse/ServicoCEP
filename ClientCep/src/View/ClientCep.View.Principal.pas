unit ClientCep.View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.EditBox,
  FMX.NumberBox, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  FMX.ScrollBox, FMX.Memo;

type
  TfPrincipal = class(TForm)
    RESTClientCEP: TRESTClient;
    RESTRequestCEP: TRESTRequest;
    Rectangle1: TRectangle;
    Server: TLabel;
    edServer: TEdit;
    Rectangle2: TRectangle;
    Label1: TLabel;
    nbPorta: TNumberBox;
    MemoResponse: TMemo;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Label2: TLabel;
    btServer1: TButton;
    btServer3: TButton;
    btServer2: TButton;
    edCEP: TEdit;
    procedure btServer1Click(Sender: TObject);
  private

  public

  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.Macintosh.fmx MACOS}
{$R *.iPad.fmx IOS}
{$R *.XLgXhdpiTb.fmx ANDROID}

procedure TfPrincipal.btServer1Click(Sender: TObject);
var
  wURL, wPath: string;
begin
  if (edServer.Text = '') then Exit;
  if (nbPorta.Value = 0) then Exit;
  if (edCEP.Text = '') then Exit;

  wURL  := 'http://'+edServer.Text+':'+nbPorta.Text;
  wPath := '/ws'+IntToStr(TButton(Sender).Tag)+'/'+edCEP.Text;
  RESTRequestCEP.Method := TRESTRequestMethod.rmGET;
  RESTRequestCEP.Resource := wPath;
  RESTClientCEP.BaseURL := wURL;
  RESTRequestCEP.Execute;
  MemoResponse.Lines.Text := '';
  if (RESTRequestCEP.Response.StatusCode = 200) then
    MemoResponse.Lines.Text := RESTRequestCEP.Response.Content;
end;

end.
