unit RelatoriosBLL;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, RelatorioDAO, SysUtils;

type
  TRelatoriosBLL = class
  private
    { private declarations }
  public
    function ObterApuracaoPorPeriodo(dataini, datafim: string) : TFDQuery;
  end;

implementation

{ TRelatoriosBLL }

function TRelatoriosBLL.ObterApuracaoPorPeriodo(dataini,
  datafim: string): TFDQuery;
var
  RelatorioDAO: TRelatorioDAO;
begin
  try
    RelatorioDAO := TRelatorioDAO.Create;
    Result := RelatorioDAO.ObterApuracaoPorPeriodo(dataini, datafim);
    FreeAndNil(RelatorioDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
