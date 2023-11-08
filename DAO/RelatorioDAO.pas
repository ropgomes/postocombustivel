unit RelatorioDAO;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, ConexaoDAO,
  SysUtils;

type
  TRelatorioDAO = class
  private
    { private declarations }
  public
    function ObterApuracaoPorPeriodo(dataini, datafim: string) : TFDQuery;
  end;

implementation

{ TRelatorioDAO }

function TRelatorioDAO.ObterApuracaoPorPeriodo(dataini,
  datafim: string): TFDQuery;
var
  Query: TFDQuery;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('SELECT B.DESCRICAO AS BOMBA,');
    Query.SQL.Add('      M.DTHR AS DATA, ');
    Query.SQL.Add('      T.DESCRICAO AS TANQUE, ');
    Query.SQL.Add('      M.VLR_TOTAL, ');
    Query.SQL.Add('      M.LITROS, ');
    Query.SQL.Add('      M.VLR_IMPOSTO ');
    Query.SQL.Add('  FROM TB_MOVIMENTO M');
    Query.SQL.Add(' INNER JOIN TB_BOMBA B ON M.ID_BOMBA = B.ID');
    Query.SQL.Add(' INNER JOIN TB_TANQUE T ON B.ID_TANQUE = T.ID ');
    Query.SQL.Add(' WHERE DATE(substr(DTHR,7,4)||''-''||substr(DTHR,4,2)||''-''||substr(DTHR,1,2))' );
    Query.SQL.Add(' BETWEEN DATE('''+dataini+''') AND DATE('''+datafim+''') ');
    Query.SQL.Add(' ORDER BY B.DESCRICAO');

    Query.Open();

    if not(Query.IsEmpty) then
      Result := Query
    else
    begin
      Result := nil;
      TConexaoDAO.DestruirQuery(Query);
    end;
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
