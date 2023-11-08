unit PrecosDAO;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, clPrecos, ConexaoDAO,
  SysUtils;

type
  TPrecosDAO = class
  private
    { private declarations }
  public
    function ObterPrecos: TPrecos;
    procedure Salvar(Precos: TPrecos);
  end;

implementation

{ TPrecosDAO }
function TPrecosDAO.ObterPrecos: TPrecos;
var
  Query: TFDQuery;
  Precos: TPrecos;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('SELECT P.ID, ');
    Query.SQL.Add('       P.VLR_LITRO_GAS, ');
    Query.SQL.Add('       P.VLR_LITRO_OLE, ');
    Query.SQL.Add('       P.VLR_IMPOSTO, ');
    Query.SQL.Add('       P.VIGENTE ');
    Query.SQL.Add('  FROM TB_PRECOS P');
    Query.SQL.Add(' WHERE P.VIGENTE = 1');

    Query.Open();

    if not(Query.IsEmpty) then
    begin
      Precos := TPrecos.Create;
      Precos.Id := Query.FieldByName('Id').AsInteger;
      Precos.VlrLitroGas := Query.FieldByName('VLR_LITRO_GAS').AsCurrency;
      Precos.VlrLitroOle := Query.FieldByName('VLR_LITRO_OLE').AsCurrency;
      Precos.VlrImposto := Query.FieldByName('VLR_IMPOSTO').AsCurrency;
      Precos.Vigente := Query.FieldByName('VIGENTE').AsInteger;

      Result := Precos;
    end
    else
      Result := nil;

    TConexaoDAO.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TPrecosDAO.Salvar(Precos: TPrecos);
var
  Query: TFDQuery;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('UPDATE TB_PRECOS ');
    Query.SQL.Add('   SET VIGENTE = 0');
    Query.SQL.Add(' WHERE VIGENTE = 1');
    Query.ExecSQL();

    Query.SQL.Clear;
    Query.SQL.Add('INSERT INTO TB_PRECOS(VLR_LITRO_GAS, ');
    Query.SQL.Add('                      VLR_LITRO_OLE, ');
    Query.SQL.Add('                      VLR_IMPOSTO, ');
    Query.SQL.Add('                      VIGENTE) ');
    Query.SQL.Add('                      VALUES( ');
    Query.SQL.Add('                      :VLR_LITRO_GAS, ');
    Query.SQL.Add('                      :VLR_LITRO_OLE, ');
    Query.SQL.Add('                      :VLR_IMPOSTO, ');
    Query.SQL.Add('                      :VIGENTE) ');
    Query.ParamByName('VLR_LITRO_GAS').AsCurrency := Precos.VlrLitroGas;
    Query.ParamByName('VLR_LITRO_OLE').AsCurrency := Precos.VlrLitroOle;
    Query.ParamByName('VLR_IMPOSTO').AsCurrency := Precos.VlrImposto;
    Query.ParamByName('VIGENTE').AsCurrency := Precos.Vigente;

    Query.ExecSQL();

    TConexaoDAO.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
