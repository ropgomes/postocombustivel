unit BombaBLL;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, clBomba, SysUtils, BombaDAO;

type
  TBombaBLL = class
  private
    { private declarations }
  public
    function ObterBombas(descricao: String = '*') : TFDQuery;
    function ObterBombaPorId(id :Integer) : TBomba;
    procedure Salvar(Bomba: TBomba);
    procedure Excluir(Bomba: TBomba);
  end;

implementation

{ TBombaBLL }

procedure TBombaBLL.Excluir(Bomba: TBomba);
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    BombaDAO.Excluir(Bomba);
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TBombaBLL.ObterBombaPorId(id: Integer): TBomba;
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    Result := BombaDAO.ObterBombaPorId(id);
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TBombaBLL.ObterBombas(descricao: String): TFDQuery;
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    Result := BombaDAO.ObterBombas(descricao);
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TBombaBLL.Salvar(Bomba: TBomba);
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    BombaDAO.Salvar(Bomba);
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
