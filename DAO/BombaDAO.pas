unit BombaDAO;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, TanqueDAO, clBomba, ConexaoDAO,
  SysUtils;

type
  TBombaDAO = class
  private
    { private declarations }
  public
    function ObterBombas(descricao: String = '*') : TFDQuery;
    function ObterBombaPorId(id :Integer) : TBomba;
    procedure Salvar(Bomba: TBomba);
    procedure Excluir(Bomba: TBomba);
  end;

implementation

{ TBombaDAO }

procedure TBombaDAO.Excluir(Bomba: TBomba);
var
  Query: TFDQuery;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('DELETE FROM TB_BOMBA ');
    Query.SQL.Add(' WHERE ID = :ID');
    Query.ParamByName('ID').AsInteger := Bomba.Id;
    Query.ExecSQL();

    TConexaoDAO.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TBombaDAO.ObterBombaPorId(id: Integer): TBomba;
var
  Query: TFDQuery;
  Bomba: TBomba;
  TanqueDAO: TTanqueDAO;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('SELECT B.ID, ');
    Query.SQL.Add('  B.DESCRICAO, ');
    Query.SQL.Add('  B.ID_TANQUE ');
    Query.SQL.Add('FROM TB_BOMBA B');
    Query.SQL.Add(' WHERE B.ID = :ID');
    Query.ParamByName('ID').AsInteger := Id;
    Query.Open();

    if not(Query.IsEmpty) then
    begin
      TanqueDAO := TTanqueDAO.Create;
      Bomba := TBomba.Create;
      Bomba.Id := Query.FieldByName('ID').AsInteger;
      Bomba.Descricao := Trim(Query.FieldByName('DESCRICAO').AsString);
      Bomba.Tanque := TanqueDAO.ObterTanquePorId(Query.FieldByName('ID_TANQUE').AsInteger);

      FreeAndNil(TanqueDAO);
      Result := Bomba;
    end
    else
    begin
      Result := nil;
    end;

    TConexaoDAO.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TBombaDAO.ObterBombas(descricao: String = '*'): TFDQuery;
var
  Query: TFDQuery;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    Query.SQL.Add('SELECT B.ID, ');
    Query.SQL.Add('  B.DESCRICAO, ');
    Query.SQL.Add('  B.ID_TANQUE, ');
    Query.SQL.Add('  T.TIPO ');
    Query.SQL.Add('FROM TB_BOMBA B ');
    Query.SQL.Add('INNER JOIN TB_TANQUE T ON B.ID_TANQUE = T.ID ');
    if descricao <> '*' then
      Query.SQL.Add(' WHERE B.DESCRICAO LIKE ''%'+Trim(descricao)+'%''');
    Query.SQL.Add(' ORDER BY B.ID');

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

procedure TBombaDAO.Salvar(Bomba: TBomba);
var
  Query: TFDQuery;
begin
  try
    TConexaoDAO.CriarQuery(Query);

    if (Bomba.Id = 0) then
    begin
      Query.SQL.Add('INSERT INTO TB_BOMBA');
      Query.SQL.Add('           (DESCRICAO, ');
      Query.SQL.Add('            ID_TANQUE) ');
      Query.SQL.Add('     VALUES(:DESCRICAO, ');
      Query.SQL.Add('            :ID_TANQUE) ');
    end
    else
    begin
      Query.SQL.Add('UPDATE TB_BOMBA');
      Query.SQL.Add('   SET DESCRICAO = :DESCRICAO, ');
      Query.SQL.Add('       ID_TANQUE = :ID_TANQUE');
      Query.SQL.Add(' WHERE ID = :ID');

      Query.ParamByName('ID').AsInteger := Bomba.Id;
    end;

    Query.ParamByName('DESCRICAO').AsString := Bomba.Descricao;
    Query.ParamByName('ID_TANQUE').AsInteger := Bomba.Tanque.Id;

    Query.ExecSQL();

    TConexaoDAO.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
