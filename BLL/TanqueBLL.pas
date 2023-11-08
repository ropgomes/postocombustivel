unit TanqueBLL;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, TanqueDAO, clTanque, SysUtils;

type
  TTanqueBLL = class
  private
    { private declarations }
  public
    function ObterTanques(descricao: String = '*') : TFDQuery;
    function ObterTanquePorId(id :Integer) : TTanque;
    procedure Salvar(Tanque: TTanque);
    procedure Excluir(Tanque: TTanque);
  end;

implementation

{ TTanqueBLL }

procedure TTanqueBLL.Excluir(Tanque: TTanque);
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    TanqueDAO.Excluir(Tanque);
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TTanqueBLL.ObterTanquePorId(id: Integer): TTanque;
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    Result := TanqueDAO.ObterTanquePorId(id);
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TTanqueBLL.ObterTanques(descricao: String): TFDQuery;
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    Result := TanqueDAO.ObterTanques(descricao);
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TTanqueBLL.Salvar(Tanque: TTanque);
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    TanqueDAO.Salvar(Tanque);
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.

