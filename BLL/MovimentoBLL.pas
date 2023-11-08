unit MovimentoBLL;

interface

uses MovimentoDAO, clMovimento, SysUtils;

type
  TMovimentoBLL = class
  private
    { private declarations }
  public
    procedure Salvar(Movimento : TMovimento);
  end;

implementation

{ TMovimentoBLL }

procedure TMovimentoBLL.Salvar(Movimento: TMovimento);
var
  MovimentoDAO: TMovimentoDAO;
begin
  try
    MovimentoDAO := TMovimentoDAO.Create;
    MovimentoDAO.Salvar(Movimento);
    FreeAndNil(MovimentoDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
