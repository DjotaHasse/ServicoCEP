program ClientCep;

uses
  System.StartUpCopy,
  FMX.Forms,
  ClientCep.View.Principal in 'src\View\ClientCep.View.Principal.pas' {fPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
