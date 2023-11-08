unit MovimentoDAO;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, clMovimento, ConexaoDAO,
  SysUtils;

type
  TMovimentoDAO = class
  private
    { private declarations }
  public
    procedure Salvar(Movimento: TMovimento);
  end;

implementation

{ TMovimentoDAO }

procedure TMovimentoDAO.Salvar(Movimento: TMovimento);
var
  Query: TFDQuery;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('INSERT INTO TB_MOVIMENTO');
    Query.SQL.Add('           (DTHR, ');
    Query.SQL.Add('           LITROS, ');
    Query.SQL.Add('           VLR_TOTAL, ');
    Query.SQL.Add('           VLR_IMPOSTO, ');
    Query.SQL.Add('           ID_BOMBA)');
    Query.SQL.Add('     VALUES(:DTHR,');
    Query.SQL.Add('            :LITROS,');
    Query.SQL.Add('            :VLR_TOTAL,');
    Query.SQL.Add('            :VLR_IMPOSTO,');
    Query.SQL.Add('            :ID_BOMBA)');

    Query.ParamByName('DTHR').AsString := Movimento.DtHr;
    Query.ParamByName('LITROS').AsFloat := Movimento.Litros;
    Query.ParamByName('VLR_TOTAL').AsCurrency := Movimento.VlrTotal;
    Query.ParamByName('VLR_IMPOSTO').AsCurrency := Movimento.VlrImposto;
    Query.ParamByName('ID_BOMBA').AsCurrency := Movimento.Bomba.Id;

    Query.ExecSQL();

    TConexaoDAO.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
