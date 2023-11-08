unit PrecosBLL;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, PrecosDAO, clPrecos, SysUtils;

type
  TPrecosBLL = class
  private
    { private declarations }
  public
    function ObterPrecos: TPrecos;
    procedure Salvar(Precos : TPrecos);
  end;

implementation

{ TPrecosBLL }

function TPrecosBLL.ObterPrecos: TPrecos;
var
  PrecosDAO: TPrecosDAO;
begin
  try
    PrecosDAO := TPrecosDAO.Create;
    Result := PrecosDAO.ObterPrecos();
    FreeAndNil(PrecosDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TPrecosBLL.Salvar(Precos: TPrecos);
var
  PrecosDAO: TPrecosDAO;
begin
  try
    PrecosDAO := TPrecosDAO.Create;
    PrecosDAO.Salvar(Precos);
    FreeAndNil(PrecosDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
